set shell=/bin/zsh
set shiftwidth=4
set tabstop=4
set textwidth=0
set autoindent
set expandtab
set hlsearch
set number
set cursorline
set clipboard=unnamed
syntax on

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'ntk148v/vim-horizon'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

"NerdTree shortcut
"nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFind<CR>

let g:gitgutter_highlight_lines = 1


" if you don't set this option, this color might not correct
"set termguicolors
"colorscheme horizon
"let g:lightline = {}
"let g:lightline.colorscheme = 'horizon'

