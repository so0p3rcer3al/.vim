
" set rtp+=~/.vim/autoload " ensures loading. try uncommenting if pathogen
" fails to load.
execute pathogen#infect()
syntax on
filetype plugin indent on

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'

" enable vim features, full colors
set nocompatible mouse=a encoding=utf8 t_Co=256
colorscheme molokai

" automatically cd into the directory that the file is in
" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" no delay when escaping from insert mode
" https://powerline.readthedocs.org/en/latest/tipstricks.html#vim
if ! has('gui_running')
	set ttimeoutlen=10
	augroup FastEscape
		autocmd!
		au InsertEnter * set timeoutlen=0
		au InsertLeave * set timeoutlen=1000
	augroup END
endif

" basic display settings: line number, status, autocomplete
set ruler laststatus=2 showcmd noshowmode number wildmenu

" search
set incsearch ignorecase smartcase hlsearch

" indentation
set autoindent smartindent

" confirm on invalid action (e.g. :q)
set confirm

" tabs are 4 spaces wide
set shiftwidth=4 tabstop=4

" j/k will start scrolling the page before cursor reaches edge
set scrolloff=7
