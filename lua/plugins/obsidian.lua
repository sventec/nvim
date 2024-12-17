-- configuration for editing my Obsidian vault
-- this can safely be disabled if not editing Obsidian vault(s)
--
-- inspiration from https://github.com/aarnphm/editor/blob/simple/lua/plugins/garden.lua

-- return path to Obsidian vault based on OS (which machine)
local function get_vault_path()
  if vim.loop.os_uname().sysname == "windows" then
    return "D:/scratch-small/obsidian-vault/notes"
  else
    return vim.fn.expand("~") .. "/doc/obsidian-vault/notes"
  end
end

local vault = get_vault_path()

return {
  {
    "epwalsh/obsidian.nvim",
    dependencies = {
      -- FIXME: config blink.cmp to spuport completion
      -- https://github.com/epwalsh/obsidian.nvim/issues/770
      -- "hrsh7th/nvim-cmp",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
    event = {
      "BufNewFile " .. vault .. "/**.md",
      "BufReadPre " .. vault .. "/**.md",
    },
    opts = {
      workspaces = {
        {
          name = "notes",
          path = vault,
          overrides = { notes_subdir = "uncategorized" },
        },
      },

      -- to apply specific directory for new notes to all vaults
      -- notes_subdir = "uncategorized",
      new_notes_location = "notes_subdir", -- "notes_subdir" or "current_dir"

      daily_notes = {
        folder = "daily-notes",
        template = "daily", -- relative to preconfigured template path
      },

      completion = {
        -- FIXME: config to use blink.cmp for completion (see above)
        nvim_cmp = true,
      },

      -- Optional, customize how wiki links are formatted. You can set this to one of:
      --  * "use_alias_only", e.g. '[[Foo Bar]]'
      --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
      --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
      --  * "use_path_only", e.g. '[[foo-bar.md]]'
      wiki_link_func = "prepend_note_id",

      preferred_link_style = "wiki", -- "wiki" or "markdown"

      templates = { subdir = "templates/standard" },

      attachments = {
        img_folder = "assets",
      },

      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
      },

      sort_by = "modified", -- "path", "modified", "accessed", or "created".
      sort_reversed = true,

      -- Optional, determines how certain commands open notes. The valid options are:
      -- 1. "current" (the default) - to always open in the current window
      -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
      -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
      open_notes_in = "current",

      ui = {
        enable = true,
      },

      -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
      ---@return string
      image_name_func = function()
        -- Prefix image names with timestamp.
        return string.format("%s-", os.time())
      end,

      -- let obsidian.nvim handle frontmatter
      disable_frontmatter = false,

      ---@type fun(note: obsidian.Note): table<string, string>
      note_frontmatter_func = function(note)
        if note.path.filename:match("tags") then
          return note.metadata
        end
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          out = vim.tbl_deep_extend("force", out, note.metadata)
        end
        if out.title == nil then
          out.title = note.id
        end
        if out.date == nil then
          out.date = os.date("%Y-%m-%d")
        end
        -- check if the length of out.aliases is 0, if so, remove it from the frontmatter
        if #out.aliases == 0 then
          out.aliases = nil
        end
        return out
      end,
      note_id_func = function(title)
        return title
      end,
    },
    keys = {
      -- obsidian.nvim functionality
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      -- stylua: ignore
      { "gf", function() return require("obsidian").util.gf_passthrough() end, noremap = false, expr = true, buffer = true, ft = "markdown" },
      -- stylua: ignore
      { "<leader>oc", function() return require("obsidian").util.toggle_checkbox() end, desc = "Toggle checkbox", buffer = true, ft = "markdown" },

      -- command binds, <leader>o.
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "View backlinks", ft = "markdown" },
      { "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Open daily note", ft = "markdown" },
      { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find file by name", ft = "markdown" },
      { "<leader>og", "<cmd>ObsidianSearch<cr>", desc = "Grep vault", ft = "markdown" },
      { "<leader>ol", "<cmd>ObsidianLink<cr>", desc = "Create link from selection", mode = "v", ft = "markdown" },
      { "<leader>oL", "<cmd>ObsidianLinks<cr>", desc = "See all links in file", ft = "markdown" },
      { "<leader>on", ":ObsidianNew ", desc = "New note", ft = "markdown" },
      { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open current note in Obsidian", ft = "markdown" },
      { "<leader>op", "<cmd>ObsidianPasteImg<cr>", desc = "Paste image", ft = "markdown" },
      { "<leader>or", ":ObsidianRename ", desc = "Rename [--dry-run]", ft = "markdown" },
      { "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Insert template", ft = "markdown" },
      { "<leader>ow", ":ObsidianWorkspace ", desc = "Switch workspace", ft = "markdown" },
      { "<leader>ox", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link under cursor", ft = "markdown" },
    },
  },

  -- name the which-key group
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>o", group = "obsidian" },
      },
    },
  },
}
