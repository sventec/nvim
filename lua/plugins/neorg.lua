-- neorg config

local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
  return
end

neorg.setup({
  load = {
    ["core.defaults"] = {}, -- Enables defaults: https://github.com/nvim-neorg/neorg/wiki#default-modules=
    ["core.norg.concealer"] = { -- Conceals marks (italic/bold/etc.)
      config = {
        icon_preset = "varied",
        dim_code_blocks = true,
      },
    },
    ["core.keybinds"] = { -- Keybinds (default & remapping)
      config = {
        default_keybinds = true,
        neorg_leader = ";",
      },
    },
    ["core.norg.dirman"] = { -- Directory/workspace manager
      config = {
        workspaces = {
          w = "~/cloud/neorg",
          school = "~/school/neorg",
        },
      },
    },
    ["core.norg.completion"] = { -- Integration with completion engine(s)
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.integrations.telescope"] = {}, -- Integration with Telescope
    -- ["core.export"] = {}, -- Export to various formats
    ["core.gtd.base"] = { -- Use Getting Things Done methodology
      config = {
        workspace = "w",
      },
    },
    ["core.norg.qol.toc"] = {}, -- Enable TOC generation
  },
})
