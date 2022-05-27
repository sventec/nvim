-- Neovim config
-- https://github.com/sventec/nvim

-- speeds up loading of lua modules
local p, impatient = pcall(require, "impatient")

if p then
  impatient.enable_profile()
end

require("core")
require("core.opts")

require("core.keybinds")

-- setup packer
require("core.packer").bootstrap()
require("plugins")

-- set base colorscheme, if any
require("plugins.colors").base()
