# neovim config

Another Lua neovim config, requires nvim 0.6.1+

These dots are pretty jank and will *probably* not work on your system, but good luck!

Note: There are large chunks of this config that are copied from, or modified versions of, the
[Neovim from scratch](https://github.com/LunarVim/Neovim-from-scratch) repo.
Check out the related video series
[here](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ).

## codestatsapi

To use the codestats.net plugin, create the `lua/codestatsapi.lua` file with the following contents:

```lua
vim.g.codestats_api_key = "<API KEY HERE>"
```

To disable the plugin and remove errors about the missing file, change the following
line in [`lua/plugins/packer.lua`](./lua/plugins/packer.lua) by either deleting it
or commenting it out:

```lua
  use("https://gitlab.com/code-stats/code-stats-vim.git")
```
