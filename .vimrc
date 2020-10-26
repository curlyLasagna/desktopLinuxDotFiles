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
" Easy Motion
Plug 'easymotion/vim-easymotion'
" Js syntax highlighting
Plug 'pangloss/vim-javascript'

call plug#end()            

"*************************"
	"Plugin configurations"
"*************************"

" Autostart NerdTree when creating new file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeWinSize=25


" lightline options
set laststatus=2
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'seoul256',
	\ }

" Set indent char 
let g:indentLine_char = '|'

" Prettier leader key trigger
let g:prettier#autoformat_require_pragma = 0

" YCM configuration
set completeopt-=preview
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_max_num_candidates = 15
let g:ycm_auto_hover = ''
let g:ycm_auto_trigger = 1

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
	syntax on
endif

"*************************"
			"Custom keymaps "
"*************************"

"*************************"
			"Custom Commands"
"*************************"

"*************************"
	"Vim user configurations"
"*************************"

" Line numbers
set number

" allow clipboard
set clipboard=unnamed

" Mouse emulation within vim 
set mouse=a

" Tabbing options
set sw=2 ts=2 sta et

" Set leader key
let mapleader=";"
set timeoutlen=2000

" Remaps
" Yank to system clipboard
nnoremap <leader>y :"+y
nnoremap <leader>w :w <Return>
nnoremap <leader>q :q <Return>
nnoremap <leader>wq :x <Return>
" cd to file's current directory 
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" save file with admin rights
noremap <leader>W :w !sudo tee % > /dev/null 
" Plugin leader keys
nmap <leader>D <plug>(YCMHover)
nmap <Leader>py <Plug>(Prettier)
" hjkl motions
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
" vim-Terminal configuration
set termwinsize=30*0
" new split panes start at the bottom. Default top
set splitbelow

set encoding=utf-8
set termguicolors

" Back up directories
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" .rasi syntax highlighting
au BufNewFile,BufRead /*.rasi setf css
