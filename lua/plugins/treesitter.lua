-- nvim-treesitter config

-- neorg treesitter integration
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

-- parser_configs.norg = {
-- 	install_info = {
-- 		url = "https://github.com/nvim-neorg/tree-sitter-norg",
-- 		files = { "src/parser.c", "src/scanner.cc" },
-- 		branch = "main",
-- 	},
-- }

-- parser_configs.norg_meta = {
--   install_info = {
--     url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
--     files = { "src/parser.c" },
--     branch = "main",
--   },
-- }

-- parser_configs.norg_table = {
--   install_info = {
--     url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
--     files = { "src/parser.c" },
--     branch = "main",
--   },
-- }

require("nvim-treesitter.configs").setup({
  ensure_isntalled = { "all", "markdown", "norg" }, -- "all" or a list of languages
  sync_install = false,
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
    disable = {
      "yaml",
      "python", -- Currently a bug with indentation, using vim-python-pep8-indent
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = { -- provided by p00f/nvim-ts-rainbow
    enable = true, -- enable the extension
    extended_mode = true, -- enable for non-bracket delimieters, like 'end'
    max_file_lines = 1000, -- disable for file > 1000 lines
  },
  -- ensure_installed = {
  -- 	"html",
  -- 	"json",
  -- 	"lua",
  -- 	"python",
  -- 	"toml",
  -- 	"yaml",
  -- 	"markdown",
  -- },
})
