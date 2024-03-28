-- Optional configurations for code/project stats tracking plugins
-- Currently available: codestats.net, wakatime (wakapi.dev)

return {
  -- Optional configuration for codestats.net plugin
  -- To enable codestats.net integration:
  --  - set the CODESTATS_API_KEY environment variable to a codestats.net API key
  --    - this env var is also used to configure e.g. code-stats-zsh
  --  - set the CODESTATS_USERNAME environment variable to the key's associated codestats.net username
  {
    -- fork of https://github.com/nyaa8/codestats.nvim
    "mcarn/codestats.nvim",
    event = "VeryLazy",
    -- uses env vars CODESTATS_API_KEY (same as e.g. code-stats-zsh) and CODESTATS_USERNAME by default
    -- WILL ONLY BE LOADED IF these env vars are set
    cond = function()
      return vim.env.CODESTATS_API_KEY ~= nil and vim.env.CODESTATS_USERNAME ~= nil
    end,
    -- can also just set enabled = false to disable even if those env vars exist
    -- enabled = false,
    config = function()
      require("codestats").setup({
        key = vim.env.CODESTATS_API_KEY,
        username = vim.env.CODESTATS_USERNAME,
      })
    end,
  },

  -- Optional configuration for a wakatime (or https://wakapi.dev) instance
  -- Requires a ~/.wakatime.cfg file to be loaded, e.g.:
  -- [settings]
  -- api_key = key
  -- api_url = https://wakapi.dev/api (if not default)
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    cond = function()
      -- only load if ~/.wakatime.cfg exists
      return vim.fn.filereadable(vim.env.HOME .. "/.wakatime.cfg") == 1
    end,
  },
}
