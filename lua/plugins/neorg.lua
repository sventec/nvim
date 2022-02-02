-- neorg config

neorg = require("neorg")

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
