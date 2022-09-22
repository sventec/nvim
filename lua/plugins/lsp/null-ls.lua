local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    -- general sources
    formatting.prettier.with({
      filetypes = { "html", "json", "yaml", "markdown" },
      extra_args = { "--no-semi", "--single-quote" },
    }),

    -- python sources
    formatting.black.with({ extra_args = { "--fast" } }),
    diagnostics.pylint.with({
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE, -- this can be used if live is too slow
    }),
    diagnostics.flake8.with({ extra_args = { "--max-line-length", "120" } }),
    formatting.reorder_python_imports,
    -- diagnostics.pydocstyle.with({ extra_args = { "--convention", "google" } }),

    -- bash sources
    formatting.shfmt,
    diagnostics.shellcheck,

    -- lua sources
    formatting.stylua,

    -- markdown sources
    -- markdownlint rules: https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md
    -- MD013: line length (too long)
    -- MD036: no emphasis as heading
    diagnostics.markdownlint.with({ extra_args = { "-r", "~MD013,~MD036,~MD025" } }),
    formatting.markdownlint,

    -- plaintext/language sources
    -- diagnostics.write_good.with({
    --   filetypes = { "text" },
    -- }),
    -- completion.spell,
    -- code_actions.proselint,
    -- diagnostics.proselint,
    -- diagnostics.vale.with({
    --   filetypes = { "markdown", "tex", "txt", "asciidoc" },
    -- }),

    -- yaml sources
    diagnostics.yamllint,
  },
  diagnostics_format = "[#{c}] #{m}",
})
