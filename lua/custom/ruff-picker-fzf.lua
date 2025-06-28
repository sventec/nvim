-- fzf picker to open buffer's Ruff diagnostics docs pages in web browser
-- Set as a buffer keymap function in python: after/ftplugin/python.lua

local M = {}

local fzf_lua = require("fzf-lua")

M.ruff_diagnostics_picker = function(opts)
  local results = {}

  local get_diag_url = function(diagnostics, code)
    for _, diag in ipairs(diagnostics) do
      if diag.code == code then
        return diag.user_data.lsp.codeDescription.href
      end
    end
  end

  local open_url = function(url)
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
        vim.notify("Unable to open URL on this platform, " .. vim.uv.os_uname().sysname .. ".", vim.log.levels.WARN)
      end
    else
      vim.notify("No URL found for this diagnostic.", vim.log.levels.WARN)
    end
  end

  local fzf_select = function(selection)
    local diag_code = string.match(selection, "^([^:]+)")
    local diag_url = get_diag_url(results, diag_code)
    open_url(diag_url)
  end

  local opts = opts
    or {
      prompt = "Ruff Diagnostics> ",
      actions = {
        ["default"] = function(selected)
          fzf_select(selected[1])
        end,
      },
    }
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)

  local fzf_results = {}
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
        table.insert(fzf_results, string.format("%s: %s", diagnostic.code, diagnostic.message))
      end
    end
  end

  if #results == 0 then
    vim.notify("No Ruff diagnostics in this buffer.", vim.log.levels.INFO)
    return
  end

  fzf_lua.fzf_exec(fzf_results, opts)
end

return M
