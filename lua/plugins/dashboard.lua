-- dashboard config

-- local g = vim.g

-- g.dashboard_disable_at_vimenter = 0
-- g.dashboard_disable_statusline = 1
-- g.dashboard_default_executive = "telescope"

-- g.dashboard_custom_section = {
--    a = { description = { "  > Find File                 SPC f f" }, command = "Telescope find_files" },
--    b = { description = { "  > Recents                   SPC f o" }, command = "Telescope oldfiles" },
--    d = { description = { "洛 > New File                  SPC f n" }, command = "DashboardNewFile" },
--    f = { description = { "  > Load Last Session         SPC l  " }, command = "SessionLoad" },
-- }

local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[                               __                ]],
	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

-- local num_plugins_loaded = #vim.fn.globpath("/usr/share/nvim" .. "/site/pack/packer/start", "*", 0, 1)

-- local footer = {
--    "neovim: loaded " .. num_plugins_loaded .. " plugins",
-- }

-- dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
