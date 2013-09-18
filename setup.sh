

# create symlink for .vimrc and pathogen
mkdir -p ~/.vim/autoload
ln -sf ~/.vim/.pathogen/autoload/pathogen.vim ~/.vim/autoload

[ -f ~/.vimrc ] && [ $(readlink ~/.vimrc) != ~/.vim/vimrc ] && \
	rm -i ~/.vimrc
[ ! -f ~/.vimrc ] && \
	ln -s ~/.vim/vimrc ~/.vimrc

# pulls all plugins in bundle folder
git submodule init
git submodule update

# copy fonts and update font cache
mkdir -p ~/.fonts
cp -n ~/.vim/.fonts/* ~/.fonts
fc-cache -vf ~/.fonts

# install additional dependencies
sudo apt-get install exuberant-ctags   # taglist.vim
