
" test startup time
" https://github.com/yonchu/dotfiles/blob/master/.vimrc
if has('vim_starting') && has('reltime')
	let g:startuptime = reltime()
	augroup StartupTimer
		" can check units of reltime() by using :sleep <nn>m
		autocmd! VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
					\ | echomsg 'startup: ' . reltimestr(g:startuptime) . ' s'
	augroup END
endif

" enable vim features, full colors
set nocompatible mouse=n encoding=utf8 t_Co=256
colorscheme defaulttheme

" set rtp+=~/.vim/autoload " try uncommenting if pathogen fails to load.
execute pathogen#infect()
Helptags
syntax on
filetype plugin indent on

let g:EasyMotion_leader_key = '<Leader>'

let g:airline_detect_whitespace=0
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts=1
let g:airline_mode_map={
			\ '__' : '-',
			\ 'n'  : 'ノマ',
			\ 'i'  : 'イン',
			\ 'R'  : 'リプ',
			\ 'c'  : 'コマ',
			\ 'v'  : 'ヴィ',
			\ 'V'  : 'ライ',
			\ '' : 'ブロ',
			\ }
let g:airline_enable_branch=1
let g:airline_enable_syntastic=1

" nmap <> :SCCompile<CR>
nmap <F9> :SCCompileRun<CR>
call SingleCompile#ChooseCompiler('c', 'gcc')
call SingleCompile#ChooseCompiler('python', 'python3')

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
" use space to separate vertically split windows instead of |
set fillchars+=vert:\ 


augroup VimHardmode
	autocmd!
	au VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
augroup END
