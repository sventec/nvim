local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local servers = {
  "cssls",
  "cssmodules_ls",
  "html",
  "jsonls",
  "sumneko_lua",
  "pyright",
  "yamlls",
  "bashls",
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("plugins.lsp.handlers").on_attach,
    capabilities = require("plugins.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  if server == "jsonls" then
    local jsonls_opts = require("plugins.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "yamlls" then
    local yamlls_opts = require("plugins.lsp.settings.yamlls")
    opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
  end

  if server == "sumneko_lua" then
    local n_status_ok, neo_dev = pcall(require, "neodev")
    if not n_status_ok then
      lspconfig.sumneko_lua.setup({})
      return
    end
    -- https://github.com/folke/neodev.nvim
    neo_dev.setup({
      library = {
        enabled = true, -- enable/disable neodev modification of sumneko_lua
        runtime = true, -- add runtime path
        types = true, -- add full signature, docs, completion for vim.[api, lsp, treesitter, etc.]
        plugins = false, -- add installed opt/start plugins in packpath. alternatively, a list of plugins to add.
      },
      setup_jsonls = true, -- disable if jsonls is not being used
      lspconfig = true,
    })

    lspconfig.sumneko_lua.setup({
      lspconfig = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
      },
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
    -- goto continue
  end

  if server == "pyright" then
    local pyright_opts = require("plugins.lsp.settings.pyright")
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server ~= "sumneko_lua" then
    lspconfig[server].setup(opts)
  end
  -- ::continue::
end
