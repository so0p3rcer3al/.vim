


# pulls all plugins in bundle folder
git submodule init
git submodule update

# create symlink for .vimrc
ln -s ~/.vim/vimrc ~/.vimrc

# copy fonts and update font cache 
mkdir -p ~/.fonts
cp ~/.vim/fonts/* ~/.fonts
fc-cache -vf ~/.fonts

