cd $HOME
git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME checkout -- .gitignore
cd -
echo "Run 'dot status' to determine if any changes will be lost"
echo "Run 'dot checkout -- .' to reset dotfiles"
echo "Then log out and back in again!"