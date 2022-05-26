-- config for plugins not long or noteworth enough for a separate file
local M = {}

M.better_escape = function()
  local status_ok, escape = pcall(require, "better_escape")
  if not status_ok then
    return
  end

  escape.setup({
    mapping = { "jk", "kj" },
    timeout = vim.o.timeoutlen,
    clear_empty_lines = false,
  })
end

M.filetype = function()
  local status_ok, filetype = pcall(require, "filetype")
  if not status_ok then
    return
  end

  filetype.setup({
    overrides = {
      extensions = {
        -- gitignore = "gitignore",
      },
      literal = {
        [".gitignore"] = "gitignore",
      },

      shebang = {
        dash = "sh",
      },
    },
  })
end

M.lsp_signature = function()
  local status_ok, lsp_signature = pcall(require, "lsp_signature")
  if not status_ok then
    return
  end

  local options = {
    bind = true,
    doc_lines = 0,
    floating_window = true,
    fix_pos = true,
    hint_enable = true,
    hint_prefix = " ",
    hint_scheme = "String",
    hi_parameter = "Search",
    max_height = 22,
    max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
      border = "single", -- double, single, shadow, none
    },
    zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
    padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
  }

  lsp_signature.setup(options)
end

M.comment = function()
  local status_ok, nvim_comment = pcall(require, "Comment")
  if not status_ok then
    return
  end

  nvim_comment.setup()
end

M.leap = function()
  local status_ok, leap = pcall(require, "leap")
  if not status_ok then
    return
  end

  leap.set_default_keymaps()
end

return M
