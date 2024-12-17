-- Telescope picker to open buffer's Ruff diagnostics docs pages in web browser
-- Set as a buffer keymap function in python: after/ftplugin/python.lua
-- FIXME: migrate picker to fzf-lua

local M = {}

local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")

M.ruff_diagnostics_picker = function(opts)
  local opts = opts or {}
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)
  local results = {}

  for _, diagnostic in ipairs(diagnostics) do
    -- add diagnostic to results if:
    -- diagnostic comes from Ruff
    -- AND diagnostic with same code is not already in results (only one entry per code)
    if diagnostic.source == "Ruff" then
      if
        not vim.tbl_contains(results, function(v)
          return v.code == diagnostic.code
        end, { predicate = true })
      then
        table.insert(results, diagnostic)
      end
    end
  end

  if #results == 0 then
    vim.notify("No Ruff diagnostics in this buffer.", vim.log.levels.INFO)
    return
  end

  local entry_maker = function(diagnostic)
    return {
      value = diagnostic,
      display = string.format(
        "%s - %s: %s",
        vim.diagnostic.severity[diagnostic.severity],
        diagnostic.code,
        diagnostic.message
      ),
      -- sort by code, then line number if matching code
      ordinal = string.format("%s: %s", diagnostic.code, diagnostic.message),
      lnum = diagnostic.lnum + 1, -- must be present for previewer
      path = vim.api.nvim_buf_get_name(bufnr), -- path or filename must be present for previewer
    }
  end

  pickers
    .new(opts, {
      prompt_title = "Ruff Diagnostics",
      finder = finders.new_table({
        results = results,
        entry_maker = entry_maker,
      }),
      previewer = conf.grep_previewer(opts),
      sorter = sorters.get_generic_fuzzy_sorter(opts),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          local diagnostic = selection.value
          local url = diagnostic.user_data.lsp.codeDescription.href

          if url then
            local command = nil
            if vim.fn.has("unix") == 1 then
              if vim.fn.has("wsl") == 1 then
                command = { "wslview", url }
              else
                command = { "xdg-open", url }
              end
            elseif vim.fn.has("mac") == 1 then
              command = { "open", url }
            elseif vim.fn.has("win32") == 1 then
              command = { "start", url }
            end

            if command then
              vim.system(command, { detach = true })
            else
              vim.notify(
                "Unable to open URL on this platform, " .. vim.uv.os_uname().sysname .. ".",
                vim.log.levels.WARN
              )
            end
          else
            vim.notify("No URL found for this diagnostic.", vim.log.levels.WARN)
          end
        end)
        return true
      end,
    })
    :find()
end

return M
