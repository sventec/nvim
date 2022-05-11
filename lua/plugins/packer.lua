-- Plugin installation and packer configuration here

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Helper function for checking code-stats config presence
function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- Packer plugin setup

packer = require("packer")

vim.cmd("packadd packer.nvim")

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

packer.startup(function(use)
	-- keep packer updated
	use("wbthomason/packer.nvim")

	-- only use code-stats if the local config file has been created
	if file_exists(vim.fn.stdpath("config") .. "/lua/codestatsapi.lua") then
		use("https://gitlab.com/code-stats/code-stats-vim.git")
	end

	-- Coding, LSP, autocomplete, snippets, etc.
	use({
		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer",
	})
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json
	use({
		"ray-x/lsp_signature.nvim", -- show function signature when typing
		after = "nvim-lspconfig",
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"L3MON4D3/LuaSnip", -- snippet plugin
			"lukas-reineke/cmp-under-comparator", -- sorts completion items that have "_"
			"hrsh7th/cmp-nvim-lsp", -- source for lsp completions
			"hrsh7th/cmp-path", -- source for file paths
			"hrsh7th/cmp-buffer", -- source for buffer words
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua", -- source for nvim's Lua API
			"saadparwaiz1/cmp_luasnip", -- source for luasnip snippets
			-- "hrsh7th/cmp-copilot", -- source for github copilot
			-- "uga-rosa/cmp-dictionary", -- source for dictionary words
		},
	})
	-- use("github/copilot.vim")
	use("rafamadriz/friendly-snippets") -- collection of snippets
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow") -- rainbow brackets for treesitter
	use("Vimjas/vim-python-pep8-indent") -- for python indentation until treesitter's is fixed
	use("windwp/nvim-autopairs")
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({
		"abecodes/tabout.nvim",
		wants = { "nvim-treesitter" },
	})
	-- })
	use("ggandor/lightspeed.nvim") -- replacing hop
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"ekickx/clipboard-image.nvim",
		config = function()
			require("clipboard-image").setup({
				default = {
					img_dir = "img",
				},
			})
		end,
	})
	use("rmagatti/alternate-toggler") -- toggles boolean values on <leader>lt
	use({
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup({
				mapping = { "jk", "kj" },
				timeout = vim.o.timeoutlen,
				clear_empty_lines = false,
			})
		end,
	})
	-- use({
	--  "kkoomen/vim-doge", -- autogenerate docstrings
	--  config = function()
	--    vim.g.doge_doc_standard_python = "google" -- google, numpy, rest, sphinx
	--  end,
	-- })
	use({
		"danymat/neogen",
		config = function()
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
		end,
		requires = "nvim-treesitter/nvim-treesitter",
	})
	-- notetaking and writing
	use({
		"nvim-neorg/neorg",
		requires = "nvim-lua/plenary.nvim",
	})
	-- visual plugins
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use("SmiteshP/nvim-gps") -- component for statusline
	use("lukas-reineke/indent-blankline.nvim")
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})
	use("folke/which-key.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("rudism/telescope-dict.nvim") -- dictionary/thesaurus Telescope module
	use({
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	})
	-- dashboard (dashboard-nvim or alpha)
	-- use("glepnir/dashboard-nvim")
	use("goolord/alpha-nvim")
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				mode = "document_diagnostics",
				auto_close = false,
				auto_open = false,
				padding = false,
				height = 8,
			})
		end,
	})
	-- performance
	use("nathom/filetype.nvim")
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("lewis6991/impatient.nvim") -- Speeds up loading modules
	-- colors/themes
	use("sainnhe/everforest")
	use("RRethy/nvim-base16")
	use("marko-cerovac/material.nvim")
	use("folke/tokyonight.nvim")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({
				integrations = {
					which_key = true,
					lightspeed = true,
					ts_rainbow = true,
				},
			})
		end,
	})
	use({
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				mirage = true,
			})
		end,
	})
end)
