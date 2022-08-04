-- lsp server configuration

local lspconfig = require("lspconfig")

-- Set desired servers here
-- Additional servers: gopls (Go), ltex (plaintext - LanguageTool), marksman (Markdown, wiki link completion & etc.)
local servers = { "jsonls", "sumneko_lua", "pyright" }

-- mason-lspconfig is used to automatically install configured servers
local status_ok_mlc, mlc = pcall(require, "mason-lspconfig")
if not status_ok_mlc then
  return
end

-- install any configured servers with Mason
mlc.setup({
  ensure_installed = servers,
})

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("plugins.lsp.handlers").on_attach,
    capabilities = require("plugins.lsp.handlers").capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "plugins.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  lspconfig[server].setup(opts)
end
