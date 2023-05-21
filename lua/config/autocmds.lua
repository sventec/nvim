-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Don't auto-comment new lines after commented line
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*",
  command = "setlocal formatoptions-=ro",
})

-- Use internal formatting for bindings like gq
-- See: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131#issuecomment-1268760653
-- W/o this, null-ls source attached to buffer can cause 'gq' to not work
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
  end,
})
