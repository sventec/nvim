-- movement and navigation related plugins (non-defaults)
return {
  -- ==MOVEMENT/NAVIGATION== --
  -- tab out of quotes, brackets, etc.
  {
    "abecodes/tabout.nvim",
    opts = {
      tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
      backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
      act_as_tab = true, -- shift content if tab out is not possible
      act_as_shift_tab = true, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <s-tab>)
      enable_backwards = true, -- well ...
      completion = false, -- if the tabkey is used in a completion pum
      ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
    },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
      "hrsh7th/nvim-cmp",
    },
  },
  -- harpoon extra setup and added configuration
  -- <leader>H to add file, <leader>h for file menu. <leader>N where N=1-5 to quick open file N
  { import = "lazyvim.plugins.extras.editor.harpoon2" }, -- harpoon file list
  {
    "ThePrimeagen/harpoon",
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
  },
  -- remove harpoon binds from which-key (cluttered)
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>1"] = "which_key_ignore",
        ["<leader>2"] = "which_key_ignore",
        ["<leader>3"] = "which_key_ignore",
        ["<leader>4"] = "which_key_ignore",
        ["<leader>5"] = "which_key_ignore",
      },
    },
  },
  -- <C-[hjkl]> navigation between neovim and tmux. Requires companion tmux plugin.
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
