#!/bin/sh

# Requires pipx for pip instllations across environments
# FIXME: Command that exists has path output
# WARNING: Above currently breaks script

cmdexists() {
  # CMD_SUCCESS=$(command -v "$1" > /dev/null)
  # if $CMD_SUCCESS; then
  if command -v "$1" &> /dev/null; then
    return 1
  else
    return 0
  fi
}

if ! cmdexists "tetssetset"; then
  echo "it works"
fi

if cmdexists "pylint"; then
  echo "it works 2"
fi

exit

# Check if installation prereqs have been met
if ! cmdexists "npm" && ! cmdexists "pipx"; then
  echo "The npm and pipx commands must be available for null-ls source installation."
  exit 1
fi

# Prettier
if ! cmdexists "prettier"; then npm install --save-dev --save-exact prettier; fi

# Proselint
if ! cmdexists "proselint"; then pipx install proselint; fi

# Stylua (has a number of distro packages)
if ! cmdeists "stylua"; then
  ID=$(grep "^ID=" /etc/os-release | cut -d= -f2)
  ID_LIKE=$(grep "^ID_LIKE=" /etc/os-release | cut -d= -f2)
  if [ "$ID" = "arch" ] || [ "$ID_LIKE" = "arch" ]; then
    sudo pacman -S stylua
  else
    npm i @johnnymorganz/stylua
  fi
fi

if ! cmdexists "pylint"; then pipx install pylint; fi
if ! cmdexists "flake8"; then pipx install flake8; fi
if ! cmdexists "black"; then pipx install black; fi
if ! cmdexists "reorder-python-imports"; then pipx install reorder_python_imports; fi

# TODO: markdownlint (cli2), shellcheck, shfmt, gofmt (?), goimports (?), yamllint

