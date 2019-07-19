cd $HOME
git --git-dir=$HOME/repos/dotfiles/.git --work-tree=$HOME checkout -- .gitignore
echo "Please restart your terminal and run 'dot-checkout' to get new configs"
cd -
