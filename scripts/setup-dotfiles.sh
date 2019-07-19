cd $HOME
git --git-dir=$HOME/repos/dotfiles/.git --work-tree=$HOME checkout -- .gitignore
echo "Please run:"
echo "source ~/repos/dotfiles/.aliases"
cd -
