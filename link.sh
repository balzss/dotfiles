DOTPATH=$( cd $(dirname $0) ; pwd -P )
ln -s -f $DOTPATH/link/{.??,}* $HOME
ln -s -f $DOTPATH/init.vim $HOME/.config/nvim/init.vim
