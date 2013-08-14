
let g:Powerline_symbols = 'fancy'
execute pathogen#infect()
syntax on
filetype plugin indent on
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim


" enable vim features, full colors
set nocompatible encoding=utf8 t_Co=256
colorscheme molokai

" automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Commenting blocks of code.
" http://stackoverflow.com/questions/1676632/whats-a-quick-way-to-comment-uncomment-lines-in-vim
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" basic display settings. turn vim mode on, show line numbers, show partial commands
set ruler laststatus=2 showcmd showmode number wildmenu

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
