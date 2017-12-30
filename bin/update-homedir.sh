# no shebang because we want . .bashrc to work in the calling shell
set -e
dir=$HOME/dots
if [ -d $dir ]; then
    cd $dir
    git pull
    eval $(make DOTDIR=$dir)
fi
