


# updates all plugins in bundle folder
git submodule foreach git pull origin master

# create symlink for .vimrc
ln -s ~/.vim/vimrc ~/.vimrc

# update font cache 
fc-cache -vf ~/.vim/fonts

