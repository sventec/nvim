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

M.neogen = function()
  local status_ok, neogen = pcall(require, "neogen")
  if not status_ok then
    return
  end

  require("neogen").setup({
    enabled = true,
    languages = {
      python = {
        template = {
          -- google_docstrings, numpydoc, or reST
          annotation_convention = "google_docstrings",
        },
      },
    },
  })
end

M.todo = function()
  local status_ok, todo = pcall(require, "todo-comments")
  if not status_ok then
    return
  end

  todo.setup()
end

M.trouble = function()
  local status_ok, trouble = pcall(require, "trouble")
  if not status_ok then
    return
  end

  trouble.setup({
    mode = "document_diagnostics",
    auto_close = false,
    auto_open = false,
    padding = false,
    height = 8,
  })
end

M.bullets = function()
  vim.g.bullets_enable_in_empty_buffers = 0
  vim.g.bullets_outline_levels = { "ROM", "ABC", "num", "abc", "rom", "std-" }
end

M.mdpreview = function()
  vim.g.mkdp_auto_close = 0
  -- vim.g.mkdp_theme = "dark"
  -- vim.g.mkdp_browser = "firefox"
  vim.g.mkdp_browser = "qutebrowser"
end

M.fidget = function()
  local status_ok, fidget = pcall(require, "fidget")
  if not status_ok then
    return
  end

  fidget.setup()
end

M.eyeliner = function()
  local status_ok, eyeliner = pcall(require, "eyeliner")
  if not status_ok then
    return
  end

  eyeliner.setup({
    highlight_on_key = true,
  })
end

M.projects = function()
  local status_ok, proj = pcall(require, "project_nvim")
  if not status_ok then
    return
  end

  proj.setup()
  -- Telescope extension to browse projects
  require("telescope").load_extension("projects")
end

M.colorizer = function()
  local status_ok, colorizer = pcall(require, "colorizer")
  if not status_ok then
    return
  end

  colorizer.setup({
    filetypes = {
      "*",
    },
    user_default_options = {
      names = false,
    },
  })
end

M.autolist = function()
  local status_ok, autolist = pcall(require, "autolist")
  if not status_ok then
    return
  end

  autolist.setup({
    new_entry_on_o = false,
  })
end

return M
