-- load all packer plugins and their requisite config files

local plugins = {
  -- pre-requisites used early in setup or by most other plugins
  ["nvim-lua/plenary.nvim"] = {},
  ["lewis6991/impatient.nvim"] = {},
  ["wbthomason/packer.nvim"] = {},

  -- fixes https://github.com/neovim/neovim/issues/12587
  ["antoinemadec/FixCursorHold.nvim"] = {},

  -- popup terminal on demand
  ["akinsho/toggleterm.nvim"] = {
    config = function()
      require("plugins.toggleterm")
    end,
  },

  -- allows defining custom base16 colors
  ["rrethy/nvim-base16"] = {
    disable = false, -- togle colorscheme loading
    -- setup function is called in plugins.colors.base()
    -- comment `M.base16()` there to disable base16 as active colorscheme
    -- config = function()
    --   require("plugins.colors").base16()
    -- end,
  },

  -- colorscheme: nightfox
  ["EdenEast/nightfox.nvim"] = {
    disable = false, -- toggle colorscheme loading
    -- after = "toggleterm",
    config = function()
      require("plugins.colors").nightfox()
    end,
  },

  -- colorscheme: catppuccin
  ["catppuccin/nvim"] = {
    disable = false, -- toggle colorscheme loading
    as = "catppuccin",
    config = function()
      require("plugins.colors").catppuccin()
    end,
  },

  -- colorscheme: zenbones
  ["mcchrish/zenbones.nvim"] = {
    disable = false, -- toggle colorscheme loading
    requires = "rktjmp/lush.nvim",
    config = function()
      require("plugins.colors").zenbones()
    end,
  },

  -- colorscheme: kanagawa
  ["rebelot/kanagawa.nvim"] = {
    config = function()
      require("plugins.colors").kanagawa()
    end,
  },

  -- icons used by many other plugins
  ["kyazdani42/nvim-web-devicons"] = {
    after = "nvim-base16",
    config = function()
      require("plugins.icons")
    end,
  },

  -- component showing relative location of current symbol
  -- ["SmiteshP/nvim-gps"] = {},

  -- statusbar at bottom of screen
  ["nvim-lualine/lualine.nvim"] = {
    after = "nvim-web-devicons",
    -- wants = "nvim-gps",
    config = function()
      require("plugins.lualine")
    end,
  },

  -- buffers as tabs on top of screen
  ["akinsho/bufferline.nvim"] = {
    after = "nvim-web-devicons",
    config = function()
      require("plugins.bufferline")
    end,
  },

  -- referenced in cmp setup, must be loaded first
  -- moves completions starting with _ (like __init__) off top of comp. list
  ["lukas-reineke/cmp-under-comparator"] = {},

  ["lukas-reineke/indent-blankline.nvim"] = {
    event = { "bufread", "bufnewfile" },
    config = function()
      require("plugins.indent-blankline")
    end,
  },

  -- render hex colors in editor
  ["norcalli/nvim-colorizer.lua"] = {
    event = { "bufread", "bufnewfile" },
    config = function()
      require("colorizer").setup()
    end,
  },

  -- better syntax highlighting & more
  ["nvim-treesitter/nvim-treesitter"] = {
    event = { "bufread", "bufnewfile" },
    run = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- intelligently use tab to escape brackets, quotes, etc.
  ["abecodes/tabout.nvim"] = {
    wants = { "nvim-treesitter" },
    after = { "nvim-cmp" },
    config = function()
      require("plugins.tabout")
    end,
  },

  -- rainbow brackets for treesitter
  ["p00f/nvim-ts-rainbow"] = {
    after = "nvim-treesitter",
  },

  -- dynamically generate docstrings
  ["danymat/neogen"] = {
    after = "nvim-treesitter",
    config = function()
      require("plugins.others").neogen()
    end,
  },

  -- show line git status in sidebar
  ["lewis6991/gitsigns.nvim"] = {
    opt = true,
    config = function()
      require("plugins.gitsigns")
    end,
    setup = function()
      util.packer_lazy_load("gitsigns.nvim")
    end,
  },

  -- allows for installation & updating of lsp servers
  ["williamboman/nvim-lsp-installer"] = {
    opt = true,
    setup = function()
      util.packer_lazy_load("nvim-lsp-installer")
      -- reload the current file so lsp actually starts for it
      vim.defer_fn(function()
        vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
      end, 0)
    end,
  },

  -- bundle of common lsp server configurations
  ["neovim/nvim-lspconfig"] = {
    after = "nvim-lsp-installer",
    module = "lspconfig",
    config = function()
      require("plugins.lsp")
    end,
  },

  -- allows definition of lsp settings using json
  ["tamago324/nlsp-settings.nvim"] = {
    after = "nvim-lspconfig",
  },

  -- adds formatters, linters & etc. as lsp sources
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("plugins.null-ls")
    end,
  },

  -- show function signature when typing
  ["ray-x/lsp_signature.nvim"] = {
    after = "null-ls.nvim",
  },

  -- maps kj and jk to <esc>
  ["max397574/better-escape.nvim"] = {
    event = "insertcharpre",
    config = function()
      require("plugins.others").better_escape()
    end,
  },

  -- easy definition of custom filetypes
  ["nathom/filetype.nvim"] = {
    -- event = { "bufread", "bufnewfile" },
    config = function()
      require("plugins.others").filetype()
    end,
  },

  -- big bundle of snippets for various languages
  ["rafamadriz/friendly-snippets"] = {
    module = "cmp_nvim_lsp",
    event = "insertenter",
  },

  -- completion menu
  ["hrsh7th/nvim-cmp"] = {
    -- after = "friendly-snippets",
    wants = "cmp-under-comparator",
    config = function()
      require("plugins.cmp")
    end,
  },

  -- snippet provider
  ["l3mon4d3/luasnip"] = {
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("plugins.luasnip")
    end,
  },

  -- cmp completion providers
  ["saadparwaiz1/cmp_luasnip"] = {
    after = "luasnip",
  },

  ["hrsh7th/cmp-nvim-lua"] = {
    after = "cmp_luasnip",
  },

  ["hrsh7th/cmp-nvim-lsp"] = {
    after = "cmp-nvim-lua",
  },

  ["hrsh7th/cmp-buffer"] = {
    after = "cmp-nvim-lsp",
  },

  ["hrsh7th/cmp-path"] = {
    after = "cmp-buffer",
  },

  ["hrsh7th/cmp-cmdline"] = {
    after = "cmp-path",
  },

  -- intelligent bracket pairs
  ["windwp/nvim-autopairs"] = {
    after = "nvim-cmp", -- autopairs loads a cmp module in the conf file
    config = function()
      require("plugins.autopairs")
    end,
  },

  -- versatile & extensible search plugin
  ["nvim-telescope/telescope.nvim"] = {
    branch = "0.1.x",
    cmd = "Telescope",
    config = function()
      require("plugins.telescope")
    end,
  },

  -- startup dashboard view
  ["goolord/alpha-nvim"] = {
    -- disable = true,
    config = function()
      require("plugins.dashboard")
    end,
  },

  -- toggle comments linewise & blockwise
  ["numtostr/comment.nvim"] = {
    module = "comment",
    keys = { "gc", "gb" },
    config = function()
      require("plugins.others").comment()
    end,
  },

  -- sidebar file explorer
  ["kyazdani42/nvim-tree.lua"] = {
    ft = "alpha",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require("plugins.nvim-tree")
    end,
  },

  -- provides popup keybind hints on <leader> and others
  ["folke/which-key.nvim"] = {
    opt = true,
    setup = function()
      util.packer_lazy_load("which-key.nvim")
    end,
    config = function()
      require("plugins.whichkey")
    end,
  },

  -- predecessor of leap.nvim
  -- ["ggandor/lightspeed.nvim"] = {
  -- event = { "bufread", "bufnewfile" },
  -- },

  -- use `s` and `s` for quick text hopping
  ["ggandor/leap.nvim"] = {
    event = { "bufread", "bufnewfile" },
    config = function()
      require("plugins.others").leap()
    end,
  },

  -- highlights unique characters on line for easier f/F navigation
  -- ["jinh0/eyeliner.nvim"] = {},

  -- toggle boolean values with command
  ["rmagatti/alternate-toggler"] = {
    event = { "bufread", "bufnewfile" },
  },

  -- fix python indentation to adhere to pep8
  ["vimjas/vim-python-pep8-indent"] = {
    setup = function()
      util.packer_lazy_load("vim-python-pep8-indent")
    end,
  },

  -- sidebar displaying document symbols
  -- ["simrat39/symbols-outline.nvim"] = {
  --   config = function()
  --     require("plugins.symbols-outline")
  --   end,
  --   setup = function()
  --     util.packer_lazy_load("symbols-outline.nvim")
  --   end,
  -- },

  -- highlights/marks TODO, FIXME, etc. comments
  ["folke/todo-comments.nvim"] = {
    event = { "bufread", "bufnewfile" },
    config = function()
      require("plugins.others").todo()
    end,
  },

  -- popup buffer displaying document LSP diagnostics
  ["folke/trouble.nvim"] = {
    wants = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.others").trouble()
    end,
  },

  -- org-like note management with neovim
  ["nvim-neorg/neorg"] = {
    config = function()
      require("plugins.neorg")
    end,
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-neorg/neorg-telescope",
    },
    -- tag = "*",
  },

  -- intended as a clone of orgmode
  ["nvim-orgmode/orgmode"] = {
    config = function()
      require("plugins.orgmode")
    end,
  },

  -- automatically add next entry of [un]ordered list on <CR>
  -- ["dkarter/bullets.vim"] = {
  --   event = { "bufread", "bufnewfile" },
  --   config = function()
  --     require("plugins.others").bullets()
  --   end,
  -- },

  -- show live markdown preview in browser with :MarkdownPreviewToggle
  ["iamcco/markdown-preview.nvim"] = {
    event = { "bufread", "bufnewfile" },
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      require("plugins.others").mdpreview()
    end,
  },
}

-- optionally include codestats.net tracking, see readme for details
local codestats_path = vim.fn.stdpath("config") .. "/lua/codestatsapi.lua"
if vim.fn.empty(vim.fn.glob(codestats_path)) == 0 then
  local codestats_packer = {
    ["https://gitlab.com/code-stats/code-stats-vim.git"] = {
      setup = function()
        require("codestatsapi") -- create this file to use plugin, see readme (contains API key)
        util.packer_lazy_load("code-stats-vim.git")
      end,
    },
  }
  plugins = vim.tbl_deep_extend("force", codestats_packer, plugins)
end

require("core.packer").run(plugins)
