

# create symlink for .vimrc
rm -i ~/.vimrc
ln -s ~/.vim/vimrc ~/.vimrc

# pulls all plugins in bundle folder
git submodule init
git submodule update

# copy fonts and update font cache 
mkdir -p ~/.fonts
cp ~/.vim/.fonts/* ~/.fonts
fc-cache -vf ~/.fonts

