-- Neovim config - Lua rewrite

-- Include packer config and plugin list from lua/plugins.lua
require("opts")
require("keybinds")
require("plugins.packer")
require("plugins.filetype")
require("plugins.impatient")
require("plugins.cmp")
require("plugins.autopairs")
require("plugins.treesitter")
require("plugins.indent-blankline")
require("plugins.lsp")
require("plugins.null-ls")
require("plugins.telescope")
require("plugins.gitsigns")
require("plugins.neorg")
require("plugins.lualine")
require("plugins.bufferline")
require("plugins.whichkey")
require("plugins.tabout")
require("plugins.dashboard")
require("plugins.nvim-tree")
require("plugins.toggleterm")
require("codestatsapi") -- will need to create this

-- LuaSnip setup

-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
