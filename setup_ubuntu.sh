#!/bin/bash

# set up configuration
cp bashrc ~/.bashrc
cp tmux.conf ~/.tmux.conf
cp profile ~/.profile
cp emacs ~/.emacs

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install 20.12.0
nvm use v20.12.0

# install anaconda
ANACONDA_VERSION="2024.06-1"
INSTALLER="Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh"
wget https://repo.anaconda.com/archive/$INSTALLER -O /tmp/$INSTALLER

# Run the installer
sha256sum  /tmp/$INSTALLER
echo "Running Anaconda installer..."
rm -rf ~/anaconda 2>/dev/null
bash /tmp/$INSTALLER -b -p ~/anaconda

# Initialize Conda
echo "Initializing Conda..."
eval "$($HOME/anaconda3/bin/conda shell.bash hook)"
conda init

# Clean up the installer
rm /tmp/$INSTALLER
echo "Anaconda installation is complete. Please restart your terminal or run 'source ~/.bashrc'."
