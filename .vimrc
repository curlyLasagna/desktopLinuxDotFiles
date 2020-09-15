call plug#begin('~/.vim/plugged')

" Linting
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf.vim'
" Cool status line 
Plug 'itchyny/lightline.vim'
" YouCompleteMe
Plug 'valloric/youcompleteme'
" Directory listing
Plug 'scrooloose/nerdtree'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Add, remove, or replace surrounding pairs around a word
Plug 'tpope/vim-surround'
" Emmet support
Plug 'mattn/emmet-vim'
" Opening and closing tag highlighting
Plug 'gregsexton/MatchTag'
" Automatic closing of quotes, paranthesis, brackets, etc
Plug 'Raimondi/delimitMate'
"Lens + Animate
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
" Vertical lines for indent levels
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
" Distraction-less vim
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" Prettier formatting
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" ctrl + / like commenting from IDE's
Plug 'preservim/nerdcommenter'
" Bunch of colorschemes
Plug 'flazz/vim-colorschemes'
" CSS color
Plug 'ap/vim-css-color'

call plug#end()            

"*************************"
	"Plugin configurations"
"*************************"

" Autostart NerdTree when creating new file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeWinSize=25

set completeopt-=preview

" lightline options
set laststatus=2
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'seoul256',
	\ }

" Set indent char 
let g:indentLine_char = '|'

" Prettier leader key trigger
nmap <Leader>py <Plug>(Prettier)
let g:prettier#autoformat_require_pragma = 0

"*************************"
			"gvim settings"
"*************************"
if has("gui_running")
" Gui colorscheme
	colo mountaineer
	set guioptions -=m
	set guioptions -=T
else 
	" Terminal colorscheme
	colo woju
endif

"*************************"
			"Custom keymaps "
"*************************"

"*************************"
			"Custom Commands"
"*************************"

" CDC = Change to Directory of Current file
command CDC cd %:p:h
 
"*************************"
	"Vim user configurations"
"*************************"

" Line numbers
set number

" allow clipboard
set clipboard=unnamed

" Mouse emulation within vim 
set mouse=a
syntax enable

" Tabbing options
set shiftwidth=2 
set tabstop=2
set smarttab
" Set leader key
let mapleader=";"
set timeoutlen=2000
" Leader Keys	
" Vim mappings tl;dr
" :map - root of all recursive mapping commands
" Map that works in all modes
" :remap - works recursively 
" :noremap - non-recursive
" Normal mode mappings
" :nmap  
" :nnoremap
" Visual mode
" :vmap
" :vnoremap
nnoremap <leader>j :terminal <Return>
nnoremap <leader>; <Esc>
nnoremap <leader>w :w <Return>
nnoremap <leader>q :q <Return>
nnoremap <leader>x :x <Return>
noremap <leader>W :w !sudo tee % > /dev/null 

" vim-Terminal configuration
set termwinsize=30*0
" new split panes start at the bottom. Default top
set splitbelow

set encoding=utf-8
set termguicolors

" .rasi syntax highlighting
au BufNewFile,BufRead /*.rasi setf css
