-- general utility plugins, adding commands & etc.
return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- show list of actions when none is provided
      enable_builtin = true,
      -- order to try remotes, default: { "upstream", "origin" }
      -- default_remote = { "origin", "upstream" },
      picker = "telescope",
    },
    keys = {
      { "<leader>goa", "<cmd>Octo asignee add<cr>", desc = "Add assignee" },
      { "<leader>goc", "<cmd>Octo comment add<cr>", desc = "Add comment" },
      { "<leader>goC", "<cmd>Octo comment delete<cr>", desc = "Delete comment" },
      { "<leader>goi", "<cmd>Octo issue list<cr>", desc = "List issues" },
      { "<leader>gol", "<cmd>Octo label add<cr>", desc = "Add label" },
      { "<leader>goL", "<cmd>Octo label remove<cr>", desc = "Remove label" },
      { "<leader>gop", "<cmd>Octo pr list<cr>", desc = "List PRs" },
      { "<leader>gor", "<cmd>Octo repo list<cr>", desc = "List user repos" },
      { "<leader>goR", "<cmd>Octo reviewer add<cr>", desc = "Add PR reviewer" },
      { "<leader>gos", "<cmd>Octo review start<cr>", desc = "Start PR review" },
    },
  },

  -- name the which-key group
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>go"] = { name = "octo" },
      },
    },
  },
}
