# **OLD ARCHIVE** - neovim config

**DO NOT USE THIS CONFIG, it's saved purely for archival purposes.**

Another Lua neovim config, requires nvim 0.7.0+

These dots are pretty jank and will *probably* not work on your system, but good luck!
The plugin list is pretty bloated with random stuff I was/am testing, so at the
very least go through and remove the plugins you won't use to improve performance.

Note: There are large chunks of this config that are copied from, or modified versions
of, the [Neovim from scratch](https://github.com/LunarVim/Neovim-from-scratch) repo.
Check out the related video series
[here](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ).

## Installation Requirements

*Don't forget to see what you're missing with `:checkhealth`!*

A non-exhaustive list of the programs needed to make full use of this config:

- nvim 0.7.0+
- [Nerd Font](https://github.com/ryanoasis/nerd-fonts) for terminal
- fzf
- ripgrep
- python 3.8+ (tested on 3.10)
- python3-pip
- pynvim (pip package)
- Optional:
  - fd-find

### Packer Install

**This step is now optional.** Packer will be automatically downloaded and installed on first run.

Before any plugins can be installed, packer must first be installed by following
the instructions on their [GitHub page](https://github.com/wbthomason/packer.nvim).

Then, start neovim (ignore errors) and run `:PackerSync`.

### Treesitter

The tree-sitter executable is *not* required unless parsers are being generated.
After first installation, update and install parsers with `:TSUpdate`, or
install all maintained parsers with `:TSInstall maintained`.

As of 2022-02-02, `markdown` isn't in the list of maintained parsers, so you can
install that parser as well with `:TSInstall markdown`.

### null-ls

The included null-ls config requires the following tools in your `PATH` as of 2022-02-02.
Any/all of these can be disabled by commenting out the relevant lines in
[`lua/plugins/null-ls.lua`](lua/plugins/null-ls.lua):

- General
  - write-good
  - proselint
  - prettier
- Lua
  - stylua
- Python
  - pylint
  - black
  - isort
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

If that file doesn't exist, the plugin will not be loaded or installed.
