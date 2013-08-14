
set rtp+=~/.vim/autoload " ensures loading
execute pathogen#infect()
syntax on
filetype plugin indent on

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'

" enable vim features, full colors
set nocompatible mouse=a encoding=utf8 t_Co=256
colorscheme molokai

" automatically cd into the directory that the file is in
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

" basic display settings. turn vim mode on, show line numbers, show partial commands
set ruler laststatus=2 showcmd noshowmode number wildmenu

" improves searching
set incsearch ignorecase smartcase hlsearch

" auto indents, for coding
set autoindent smartindent

" confirm instead of fail on invalid action (e.g. :q)
set confirm

" tabs are 4 spaces wide
set shiftwidth=4 tabstop=4

" j/k will start scrolling the page when its 7 away from top/bottom
set scrolloff=7
