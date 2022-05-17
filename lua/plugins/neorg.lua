-- neorg config

local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
  return
end

neorg.setup({
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
        neorg_leader = ";",
      },
    },
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          w = "~/.cloud/neorg",
        },
      },
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
  },
})
