cd $HOME

# Install ZShell to use dotfiles scripts
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Set dotfiles
git --git-dir=$HOME/repos/dotfiles/.git --work-tree=$HOME checkout -- .gitignore

# Notify user of backups
echo
echo "Please run 'dot-checkout' to get new configs"

cd -
