#!/usr/bin/env bash
# 
# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times.
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
#
# - Twitter (app store)
# - Postgres.app (http://postgresapp.com/)
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew tap homebrew/dupes
brew install coreutils
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-which --with-default-names
brew install gnu-grep --with-default-names

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install ZSH
brew install zsh
brew install zsh-completions
chsh -s $(which zsh)

PACKAGES=(
  ack
  autoconf
  automake
  ffmpeg
  gettext
  git
  graphviz
  hub
  imagemagick
  jq
  libjpeg
  libmemcached 
  lynx
  markdown
  memcached
  neovim
  npm
  nvm
  pkg-config
  postgresql
  pypy
  python
  python3
  rabbitmq
  rename
  ssh-copy-id
  terminal-notifier
  the_silver_searcher
  tmux
  tree
  wget
  rbenv
  ruby-build
  ripgrep
  yarn --without-node
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install caskroom/cask/brew-cask

CASKS=(
  firefox
  flux
  google-chrome
  google-drive
  slack
  virtualbox
  vlc
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Installing fonts..."
brew tap caskroom/fonts
FONTS=(
  font-source-code-pro
  font-inconsolidata
  font-roboto
  font-clear-sans
)
brew cask install ${FONTS[@]}

# echo "Installing Python packages..."
# PYTHON_PACKAGES=(
#   ipython
#   virtualenv
#   virtualenvwrapper
# )
# pip install ${PYTHON_PACKAGES[@]}

echo "Installing Ruby and gems"+
RUBY_VERSIONS=(
  2.5.1
)
RUBY_GEMS=(
  bundler
  tmuxinator
)
rbenv init
rbenv install ${RUBY_VERSIONS[@]}
gem install ${RUBY_GEMS[@]}

echo "Installing node and global npm packages..."
nvm install node
nvm use node
NPM_PACKAGES=(
)

echo "Configuring OSX..."

# # Set fast key repeat rate
# defaults write NSGlobalDomain KeyRepeat -int 0
#
# # Require password as soon as screensaver or sleep mode starts
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0
#
# # Show filename extensions by default
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true
#
# # Enable tap-to-click
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
#
# # Disable "natural" scroll
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
#
# echo "Creating folder structure..."
# [[ ! -d Wiki ]] && mkdir Wiki
# [[ ! -d Workspace ]] && mkdir Workspace

echo "Bootstrapping complete"
