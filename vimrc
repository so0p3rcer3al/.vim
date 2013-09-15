
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
" let g:airline_mode_map={
" 			\ '__' : '-',
" 			\ 'n'  : 'n',
" 			\ 'i'  : 'i',
" 			\ 'R'  : 'r',
" 			\ 'c'  : 'c',
" 			\ 'v'  : 'v',
" 			\ 'V'  : 'l',
" 			\ '' : 'b',
" 			\ }
let g:airline_mode_map={
			\ '__' : '-',
			\ 'n'  : 'ノー',
			\ 'i'  : 'イン',
			\ 'R'  : 'リプ',
			\ 'c'  : 'コマ',
			\ 'v'  : 'ヴィ',
			\ 'V'  : 'ライ',
			\ '' : 'ブロ',
			\ }
let g:airline_enable_branch=1
let g:airline_enable_syntastic=1

let g:sccr_additional_args=''
function SCCR()
	if ! empty(g:sccr_additional_args)
		execute 'SCCompileRunAF '.g:sccr_additional_args
	else
		SCCompileRun
	endif
	cwindow 4
endfunction

nmap <F7> :call SCCR()<CR><CR>
nmap <F8> :SCCompile<CR>
augroup LanguageSpecific
	autocmd!
	au FileType c nmap <F9> :! valgrind --leak-check=full '%:p:r.o'<CR>
	au BufReadPost quickfix let &winheight=min([max([4, line('$')+1]), 9])
augroup END

" let g:SingleCompile_showquickfixiferror = 1
" let g:SingleCompile_showquickfixifwarning = 1
let g:SingleCompile_silentcompileifshowquickfix=1
let g:SingleCompile_usequickfix=1
let g:SingleCompile_usetee=0

call SingleCompile#SetCompilerTemplate('c', 'gcc_d', 'gcc + gdb', 'gcc',
		\'-std=c11 -O0 -ggdb3 '.
			\'-pedantic -Wall -Wextra -Wno-sign-compare -Wshadow -Wcast-qual '.
			\'-Wswitch-default -Wswitch-enum -Wcast-align -Wbad-function-cast '.
			\'-Wstrict-prototypes -Winline -Wundef -Wnested-externs -Wunreachable-code '.
			\'-Wlogical-op -Wfloat-equal -Wredundant-decls -Winline '.
			\'-o $(FILE_TITLE)$.o',
		\'$(FILE_EXEC)$.o || ([[ $? -ne 0 ]] && gdb $(FILE_EXEC)$.o)')
call SingleCompile#ChooseCompiler('c', 'gcc_d')
call SingleCompile#ChooseCompiler('python', 'python3')

let g:file_template_default = {}
let g:file_template_default["default"] = 'default'

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
" indentation and cursor positioning
set autoindent smartindent nostartofline
" confirm on invalid action (e.g. :q)
set confirm
" tabs are 8 spaces wide
set shiftwidth=8 tabstop=8 noexpandtab
" j/k will start scrolling the page before cursor reaches edge
set scrolloff=7
" backspace over everything
set backspace=2
" use space to separate vertically split windows instead of |
set fillchars+=vert:\ "
" insecure?
set nomodeline


" augroup VimHardmode
" 	autocmd!
" 	au VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
" augroup END
