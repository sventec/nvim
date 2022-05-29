# neovim config

Another Lua neovim config, requires nvim 0.7.0+  
Version 2 - lazier edition

The plugin list is pretty bloated with random stuff I am, or at one point was, testing, so
at least go through and remove the plugins you won't use to improve performance.
They all have short descriptions in [plugins/init.lua](./lua/plugins/init.lua), but the
plugin identifier in that file can always be appended to `github.com/` to access a
detailed README. Make sure to `:PackerSync` after changing the plugin config.

**Breaking changes will happen without notice** -- This config is always
changing. Pull with caution.

Note: There are large chunks of this config that are copied from, or modified versions
of, the [Neovim from scratch](https://github.com/LunarVim/Neovim-from-scratch) repo.
Check out the related video series
[here](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ).
Additionally, the cool format for modular plugin configurations is based on the framework
used in [NvChad](https://github.com/NvChad/NvChad/).

## Installation Requirements

_Don't forget to see what you're missing with `:checkhealth`!_

A non-exhaustive list of the dependencies needed to make full use of this config:

- nvim 0.7.0+
- [Nerd Font](https://github.com/ryanoasis/nerd-fonts) for terminal
- fzf
- ripgrep
- python 3.8+ (tested on 3.10)
- python3-pip
- pynvim (pip package)
- Clipboard utility
  - Windows: win32yank
  - Linux: xsel
- Optional (Recommended):
  - fd-find
  - npm (for lsp-installer)

### Packer Install

**This step is now optional.** Packer will be automatically downloaded and installed if
not present on startup. See how [here](./lua/core/packer.lua) in `bootstrap()`.

Before any plugins can be installed, packer must first be installed by following
the instructions on their [GitHub page](https://github.com/wbthomason/packer.nvim).

Then, start neovim (ignore errors) and run `:PackerSync`.

### Treesitter

The tree-sitter executable is _not_ required unless parsers are being generated, which
won't happen during normal use. After first installation, update and install parsers with
`:TSUpdate`, or install all maintained parsers with `:TSInstall all`.

As of 2022-05-27, `markdown` isn't in the list of maintained parsers, so you can
install that parser as well with `:TSInstall markdown`.

### null-ls

The included null-ls config requires the following tools in your `PATH` as of 2022-05-27.
If any tools aren't installed, it will complain but everything else will still work.
Any/all of these can be disabled by commenting out the relevant lines in
[`lua/plugins/null-ls.lua`](./lua/plugins/null-ls.lua):

- General
  - write-good
  - proselint
  - prettier
- Lua
  - stylua
- Python
  - pylint
  - black
  - [reorder_python_imports](https://github.com/asottile/reorder_python_imports)
- Markdown
  - markdownlint
- Shell script
  - shellcheck
  - shfmt
- Go
  - gofmt
  - goimports

## codestatsapi

To use the codestats.net plugin, create the `lua/codestatsapi.lua` file with the following contents:

```lua
vim.g.codestats_api_key = "<API KEY HERE>"
```

If that file doesn't exist, the plugin will not be loaded or installed. After
creating the file, you may need to run `:PackerSync` for installation to trigger.
