# .dotfiles.d/

Handy directory to put all my dotfiles with a script to get started.

First clone this repo to the home directory

Assuming Homebrew is installed use `brew bundle` to install everything in the Brewfile:

```bash
cd ~/.dotfiles.d
brew tap homebrew/bundle
brew bundle
```

Then to symlink dotfiles to the home directory:

```bash
~/.dotfiles.d/link_dotfiles.sh
```
