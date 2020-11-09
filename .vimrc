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
" Synatax highlighting
Plug 'sheerun/vim-polyglot'
" Adds icons to plugins such as nerdtree
Plug 'ryanoasis/vim-devicons'
call plug#end()            

"****************************"
    "Plugin configurations"
"****************************"

" Autostart NerdTree and focus on file instead of NERDTree
autocmd VimEnter * NERDTree | wincmd p 
" Closes vim if the only window open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTree window starting size
let g:NERDTreeWinSize=25

" lightline options
set laststatus=2
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'seoul256',
	\ }

" Set indent char 
let g:indentLine_char = '|'

" Enables auto formatting without '@format'
let g:prettier#autoformat_require_pragma = 0

" YCM configuration
set completeopt-=preview
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_max_num_candidates = 25
let g:ycm_auto_hover = ''
let g:ycm_auto_trigger = 1

" Lens configuration
let g:lens#disabled_filetypes = ['nerdtree', 'fzf']
let g:lens#width_resize_min = 150
let g:lens#height_resize_min = 150

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
" Alternative tab navigation
nnoremap tl :tabnext<CR>
nnoremap th :tabprevious<CR>
nnoremap <M-.> :call MoveToNextTab()<CR>
nnoremap <M-,> :call MoveToPrevTab()<CR>

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"*************************"
    "Custom Commands"
"*************************"

"******************************"
	"Vim user configurations"
"******************************"

" Line numbers
set number

" allow clipboard
set clipboard=unnamed

" Mouse emulation within vim 
set mouse=a

" Tabbing options
set sw=4 ts=4 sta et

" Cursor jumps to the matching brace when inserted
set showmatch

" Sets the cursor to a line on insert
let &t_SI = "\e[6 q"
let &t_SI = "\e[2 q"

" Maintains VisualMode after indenting with < or >
vmap < <gv
vmap > >gv

" Set leader key
let mapleader=";"
" Leader timeout length
set timeoutlen=2000

" Leader key hotkeys
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
" Vim-Terminal configuration
set termwinsize=30*0
" New split panes start at the bottom and to the right.
set sb spr

set encoding=utf-8

" Back up directories
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" .rasi syntax highlighting
au BufNewFile,BufRead /*.rasi setf css

" Functions
function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
