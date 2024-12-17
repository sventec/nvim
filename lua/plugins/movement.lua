-- movement and navigation related plugins (non-defaults)
return {
  -- ==MOVEMENT/NAVIGATION== --
  -- tab out of quotes, brackets, etc.
  {
    "abecodes/tabout.nvim",
    opts = {
      tabkey = "<a-l>", -- key to trigger tabout, set to an empty string to disable
      backwards_tabkey = "<a-h>", -- key to trigger backwards tabout, set to an empty string to disable
      act_as_tab = false, -- shift content if tab out is not possible
      act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <s-tab>)
      enable_backwards = true, -- well ...
      completion = false, -- if the tabkey is used in a completion pum
      ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
    },
    event = { "InsertCharPre" },
    priority = 1000,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    },
  },
  -- <C-[hjkl]> navigation between neovim and tmux. Requires companion tmux plugin.
  {
    "christoomey/vim-tmux-navigator",
    -- only install if environment has `tmux`
    cond = function()
      return vim.fn.executable("tmux") == 1
    end,
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
