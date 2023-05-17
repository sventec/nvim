-- Mason config
-- Define and configure language servers here

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mlc_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mlc_ok then
  return
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  return
end

-- List of servers to automatically install
local servers = {
  "cssls",
  "cssmodules_ls",
  "html",
  "jsonls",
  "lua_ls",
  "pyright",
  "yamlls",
  "bashls",
}

-- Mason settings
mason.setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  keymaps = {
    toggle_package_expand = "<CR>",
    install_package = "i",
    update_package = "u",
    check_package_version = "c",
    update_all_packages = "U",
    check_outdated_packages = "C",
    uninstall_package = "X",
    cancel_installation = "<C-c>",
    apply_language_filter = "<C-f>",
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true, -- Automatically install above list of servers
})

-- Configure language server handlers here
mason_lspconfig.setup_handlers({
  -- Default handler (for servers not explicitly specified)
  function(server_name)
    local opts = {
      on_attach = require("plugins.lsp.handlers").on_attach,
      capabilities = require("plugins.lsp.handlers").capabilities,
    }

    local has_opts, s_opts = pcall(require, "plugins.lsp.settings." .. server_name)
    if has_opts then
      opts = vim.tbl_deep_extend("force", s_opts, opts)
    end

    lspconfig[server_name].setup(opts)
  end,
  -- Handlers with non-default seutp functions defined explicitly below
  ["lua_ls"] = function()
    local n_status_ok, neo_dev = pcall(require, "neodev")
    if not n_status_ok then
      -- Setup without neodev.nvim if not present
      lspconfig.lua_ls.setup({})
      return
    end

    -- https://github.com/folke/neodev.nvim
    neo_dev.setup({
      library = {
        enabled = true, -- enable/disable neodev modification of lua_ls
        runtime = true, -- add runtime path
        types = true, -- add full signature, docs, completion for vim.[api, lsp, treesitter, etc.]
        plugins = false, -- add installed opt/start plugins in packpath. alternatively, a list of plugins to add.
      },
      setup_jsonls = true, -- disable if jsonls is not being used
      lspconfig = true,
    })

    lspconfig.lua_ls.setup({
      lspconfig = {
        on_attach = require("plugins.lsp.handlers").on_attach,
        capabilities = require("plugins.lsp.handlers").capabilities,
      },
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
  end,
})
