-- Plugin installation and packer configuration here

-- Automatically install packer
-- Credit: https://github.com/LunarVim/Neovim-from-scratch
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

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
  local codestats_path = vim.fn.stdpath("config") .. "/lua/codestatsapi.lua"
  if vim.fn.empty(vim.fn.glob(codestats_path)) == 0 then
    use("https://gitlab.com/code-stats/code-stats-vim.git")
  end

  -- Coding, LSP, autocomplete, snippets, etc. {{{
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
  -- use({
  --   "max397574/better-escape.nvim",
  --   config = function()
  --     require("better_escape").setup({
  --       mapping = { "jk", "kj" },
  --       timeout = vim.o.timeoutlen,
  --       clear_empty_lines = false,
  --     })
  --   end,
  -- })
  use("akinsho/toggleterm.nvim")
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
  -- }}}
  -- notetaking and writing {{{
  use({
    "nvim-neorg/neorg",
    requires = "nvim-lua/plenary.nvim",
  })
  -- }}}
  -- visual plugins {{{
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use("SmiteshP/nvim-gps") -- component for statusline
  use("lukas-reineke/indent-blankline.nvim")
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
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
  use({
    "kosayoda/nvim-lightbulb",
    config = function()
      require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
    end,
  })
  use("kyazdani42/nvim-tree.lua")
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_auto_close = 0
      -- vim.g.mkdp_theme = "dark"
      vim.g.mkdp_browser = "firefox"
    end,
  })
  use({
    "ellisonleao/glow.nvim",
    branch = "main",
    config = function()
      vim.g.glow_style = "light"
      vim.g.glow_border = "rounded"
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
  -- }}}
  -- dashboard (dashboard-nvim or alpha) {{{
  -- use("glepnir/dashboard-nvim")
  use("goolord/alpha-nvim")
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  })
  -- }}}
  -- performance {{{
  use("nathom/filetype.nvim")
  use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
  use("lewis6991/impatient.nvim") -- Speeds up loading modules
  -- }}}
  -- colors/themes {{{
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
  use({
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        undercurl = true,
        commentStyle = "italic",
        functionStyle = "NONE",
        keywordStyle = "italic",
        statementStyle = "bold",
        typeStyle = "NONE",
        variablebuiltinStyle = "italic",
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        globalStatus = false, -- adjust window separators highlight for laststatus=3
      })
    end,
  })
  -- nightfox {{{
  use({
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false, -- Non focused panes set to alternative background
          styles = {
            comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
          inverse = { -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
          modules = { -- List of various plugins and additional options
            cmp = true,
            diagnostic = true,
            gitsigns = true,
            lightspeed = true,
            lsp_trouble = true,
            nvimtree = true,
            telescope = true,
            treesitter = true,
            tsrainbow = true,
            whichkey = true,
          },
        },
      })
    end,
  })
  -- }}}
  -- }}}
end)
