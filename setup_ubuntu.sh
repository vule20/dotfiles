#!/bin/bash

# set up configuration
cp bashrc ~/.bashrc
cp tmux.conf ~/.tmux.conf
cp profile ~/.profile
cp emacs ~/.emacs


# # install anaconda
# ANACONDA_VERSION="2024.06-1"
# INSTALLER="Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh"
# wget https://repo.anaconda.com/archive/$INSTALLER -O /tmp/$INSTALLER

# # Run the installer
# sha256sum  /tmp/$INSTALLER
# echo "Running Anaconda installer..."
# rm -rf ~/anaconda 2>/dev/null
# bash /tmp/$INSTALLER -b -p ~/anaconda

# # Initialize Conda
# echo "Initializing Conda..."
# eval "$($HOME/anaconda3/bin/conda shell.bash hook)"
# conda init

# # Clean up the installer
# rm /tmp/$INSTALLER
# echo "Anaconda installation is complete. Please restart your terminal or run 'source ~/.bashrc'."
