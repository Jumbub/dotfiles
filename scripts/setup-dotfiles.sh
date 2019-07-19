cd $HOME
git --git-dir=$HOME/repos/dotfiles/.git --work-tree=$HOME checkout -- .gitignore
cd -
echo
echo "Please run 'dot status' to determine if any changes will be lost"
echo
echo "Followed by 'dot checkout -- .' to reset dotfiles"
echo
echo "Then log out and back in again!"