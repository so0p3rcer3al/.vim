
git pull origin master

mkdir -p ~/.vim/autoload ~/.vim/bundle; \
	curl -Sso ~/.vim/autoload/pathogen.vim \
	    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

git submodule foreach git pull origin master
