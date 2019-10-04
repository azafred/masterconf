#!/bin/zsh
# Creating symlinks to maindir.
set +x
#shopt -s extglob
setopt extendedglob
echo "========= Setting up Shell environment =========="
# Bin dir
echo "-- linking ~/bin directory"
rm -rf ~/bin
ln -s ~/masterconf/bin ~/bin
export PATH=$PATH:~/bin

#######
# Zsh #
#######

echo "-- linking ~/.zsh directory and ~/.zshrc"
rm -rf ~/.zsh
rm -rf ~/.zshrc
ln -s ~/masterconf/DotFiles/zsh ~/.zsh
ln -s ~/masterconf/DotFiles/zsh/.zshrc ~/.zshrc

# Vim
echo "-- linking ~/.vim directory and ~/.vimrc"
rm -rf ~/.vimrc
ln -s ~/masterconf/DotFiles/vim/vimrc ~/.vimrc

# Tmux
echo "-- linking ~/.tmuxrc and ~/.tmux.conf"
rm -rf ~/.tmux.conf
rm -rf ~/.tmuxrc
ln -s ~/masterconf/DotFiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/masterconf/DotFiles/tmux/tmux.conf ~/.tmuxrc

# Git
echo "-- linking ~/.gitconfig and ~/.gitignore_global"
rm -rf ~/.gitconfig
rm -rf ~/.gitignore_global
ln -s ~/masterconf/DotFiles/git/gitconfig ~/.gitconfig
ln -s ~/masterconf/DotFiles/git/gitignore_global ~/.gitignore_global

# Boxes
echo "-- linking ~/.boxes"
rm -rf ~/.boxes
ln -s ~/masterconf/DotFiles/boxes/.boxes ~/.boxes

# SSH Confg
echo "-- Cleanup ~/.ssh"
# rm -rf ~/.ssh
if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

echo "-- Copying ~/.ssh/authorized_keys"
ln ~/masterconf/DotFiles/ssh/authorized_keys ~/.ssh/authorized_keys
ln ~/masterconf/DotFiles/ssh/authorized_keys ~/.ssh/authorized_keys2
chmod 600 ~/.ssh/authorized*
chmod 700 ~/.ssh

echo "-- Copying ~/.ssh/config to get a base config going"
ln ~/masterconf/DotFiles/ssh/config ~/.ssh/config

echo "-- Adding ~/.ssh/tmp for connection re-use"
if [ ! -d ~/.ssh/tmp ]; then
    mkdir ~/.ssh/tmp
fi
chmod 700 ~/.ssh/tmp

# # Iterm Shell integration
# echo "-- Setting up iterm integration"
# rm -rf ~/.iterm2_shell_integration.zsh
# ln -s ~/masterconf/DotFiles/zsh/lib/.iterm2_shell_integration.zsh ~/.iterm2_shell_integration.zsh
