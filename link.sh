DOTPATH=$( cd $(dirname $0) ; pwd -P )
ln -s -f $DOTPATH/link/home/{.??,}* $HOME
ln -s -f $DOTPATH/link/init.vim $HOME/.config/nvim/init.vim
