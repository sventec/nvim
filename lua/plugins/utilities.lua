-- general utility plugins, adding commands & etc.
return {
  -- {
  --   "pwntester/octo.nvim",
  --   cmd = "Octo",
  --   lazy = true,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- opts = {
  --   -- show list of actions when none is provided
  --   enable_builtin = true,
  --   -- order to try remotes, default: { "upstream", "origin" }
  --   -- default_remote = { "origin", "upstream" },
  --   picker = "telescope",
  --   default_merge_method = "squash",
  --   default_to_projects_v2 = true,
  -- },
  --   keys = {
  --     { "<leader>goa", "<cmd>Octo assignee add<cr>", desc = "Add assignee" },
  --     { "<leader>goc", "<cmd>Octo comment add<cr>", desc = "Add comment" },
  --     { "<leader>goC", "<cmd>Octo comment delete<cr>", desc = "Delete comment" },
  --     { "<leader>god", "<cmd>Octo pr diff<cr>", desc = "Show PR diff" },
  --     { "<leader>goi", "<cmd>Octo issue list<cr>", desc = "List issues" },
  --     { "<leader>gol", "<cmd>Octo label add<cr>", desc = "Add label" },
  --     { "<leader>goL", "<cmd>Octo label remove<cr>", desc = "Remove label" },
  --     { "<leader>goo", "<cmd>Octo pr open<cr>", desc = "Open PR in browser" },
  --     { "<leader>goP", "<cmd>Octo pr create<cr>", desc = "Create PR" },
  --     { "<leader>gop", "<cmd>Octo pr list<cr>", desc = "List PRs" },
  --     { "<leader>gor", "<cmd>Octo repo list<cr>", desc = "List user repos" },
  --     { "<leader>goR", "<cmd>Octo reviewer add<cr>", desc = "Add PR reviewer" },
  --     { "<leader>gos", "<cmd>Octo review start<cr>", desc = "Start PR review" },
  --   },
  -- },

  -- name the which-key group
  -- {
  --   "folke/which-key.nvim",
  --   opts = {
  --     spec = {
  --       { "<leader>go", group = "octo" },
  --     },
  --   },
  -- },

  -- use :Gitignore to generate .gitignore for project types (append to existing by default)
  {
    "wintermute-cell/gitignore.nvim",
    keys = {
      { "<leader>gi", "<cmd>Gitignore<cr>", desc = "Generate gitignore" },
    },
  },
}
