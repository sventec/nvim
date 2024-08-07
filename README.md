# Neovim Dots, 💤 Lazy Edition

A port, with lots of unused features removed, of my 'pure' neovim config to one
built off of [LazyVim](https://www.lazyvim.org/).

## Installation

Refer to the [LazyVim docs](https://www.lazyvim.org/) for setup
particularities. Otherwise, clone this config to `~/.config/nvim/`, start
`nvim`, and `:checkhealth`. The plugin manager `lazy.nvim` should be
automatically bootstrapped on first start.

### Requirements

The following is required for use of the features in this config:

- Basic tools, e.g. `git`, `curl`, `unzip`, etc.
- Neovim packages: `neovim`, `python-pynvim`
  - Neovim version **must be >= 0.10.0**
  - Use of 0.10.0 allows for LSP inlay hints, native snippets, native commenting, and more. The plugins providing these functions for versions >= 0.9 have been removed, and thus this config won't be fully functional without 0.10.0.
- [Nerd Font](https://github.com/ryanoasis/nerd-fonts) as terminal font, version >= 3 (I use JetBrains Mono)
- Packages for use by plugins
  - For Mason (installs formatters, linters, LSPs): `npm`, `cargo`
  - For Telescope (fuzzy finders, etc.): `rg`, `fd`
    - `rg`: [ripgrep](https://github.com/BurntSushi/ripgrep)
    - `fd`: [fd-find](https://github.com/sharkdp/fd)
- Optional packages
  - [lazygit](https://github.com/jesseduffield/lazygit) (for embedded `lazygit` window)

### Setup Config

Once the requirements have been installed, prepare the configuration on your system.

#### Backing Up Existing Config

If you have an existing Neovim configuration, it can be backed up and restored if you wish to change back at any point in the future.

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

#### Cloning Dotflies

Once any existing Neovim configuration has been backed up, clone this
repository into `~/.config/nvim/`. If an existing Neovim configuration exists,
but does not need to be preserved, remove `~/.local/share/nvim/` prior to
starting Neovim for the first time.

```bash
git clone https://github.com/sventec/nvim.git ~/.config/nvim
```

#### Post-Installation

Once the dotfiles have been cloned, start `nvim` for the first time, and allow
all plugins to install. Once all plugins have installed, quit Neovim and reopen it.

If, after reopening Neovim, there are still missing tools or errors are being
generated, run `:LazyHealth` to load all plugins and open the check health
window. Troubleshoot the installation (e.g. look for missing binaries) using this.

## Disclaimer

This is a personal config that is often modified. There may be aspects that
will not work on other systems without some tweaking, and breaking changes may
be made without notice at any time. Please be careful if you wish to use this
config yourself, as some modification will likely be required.
