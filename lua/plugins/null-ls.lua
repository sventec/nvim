-- null-ls config

local status_ok, nls = pcall(require, "null-ls")
if not status_ok then
  return
end

local sources = {
  nls.builtins.formatting.prettier.with({
    filetypes = { "html", "json", "yaml", "markdown" },
    extra_args = { "--no-semi", "--single-quote" },
  }),
  -- lua sources
  nls.builtins.formatting.stylua,

  -- plaintext/language sources
  -- nls.builtins.diagnostics.write_good.with({
  --   filetypes = { "text" },
  -- }),
  -- nls.builtins.completion.spell,
  nls.builtins.code_actions.proselint,
  nls.builtins.diagnostics.proselint,
  -- nls.builtins.diagnostics.vale.with({
  --   filetypes = { "markdown", "tex", "txt", "asciidoc" },
  -- }),

  -- python sources
  nls.builtins.diagnostics.pylint.with({
    --  method = nls.methods.DIAGNOSTICS_ON_SAVE,  -- this can be used if live is too slow
  }),
  nls.builtins.diagnostics.flake8.with({ extra_args = { "--max-line-length", "88" } }),
  nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
  -- nls.builtins.formatting.isort,
  nls.builtins.formatting.reorder_python_imports,
  -- nls.builtins.diagnostics.pydocstyle.with({ extra_args = { "--convention", "google" } }),

  -- markdown sources
  nls.builtins.diagnostics.markdownlint.with({ extra_args = { "--disable", "MD013" } }),
  nls.builtins.formatting.markdownlint,

  -- shell sources
  nls.builtins.diagnostics.shellcheck,
  nls.builtins.code_actions.shellcheck,
  nls.builtins.formatting.shfmt,

  -- golang sources
  nls.builtins.formatting.gofmt,
  nls.builtins.formatting.goimports,
  -- nls.builtins.formatting.golines,
}

nls.setup({
  sources = sources,
  -- #{c}: code, #{m}: message, #{s}: source name
  diagnostics_format = "[#{c}] #{m}",
})
