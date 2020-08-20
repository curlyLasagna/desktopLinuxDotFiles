set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Linting
Plugin 'dense-analysis/ale'
Plugin 'junegunn/fzf.vim'
" Cool status line 
Plugin 'itchyny/lightline.vim'
" YouCompleteMe
Plugin 'valloric/youcompleteme'
" Directory listing
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
" HTML Plugins
Plugin 'mattn/emmet-vim'
" Highlights the respective
" opening tag with its
" closing tag
Plugin 'gregsexton/MatchTag'
" Automatic closing of quotes, 
" paranthesis, brackets, etc
Plugin 'Raimondi/delimitMate'
"Lens + Animate
Plugin 'camspiers/animate.vim'
Plugin 'camspiers/lens.vim'
" Vertical lines for indent levels
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-commentary'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

"Custom keymaps
cmap w!! w !sudo tee > /dev/null %

"Custom Commands
" CDC = Change to Directory of Current file
command CDC cd %:p:h

if has("gui_running")
	" Gui colorscheme
	colo afterglow
else 
	" Terminal colorscheme
	colo elflord
endif

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

" vim-Terminal configuration
set termwinsize=30*0
" new split panes start at the bottom. Default top
set splitbelow

set encoding=utf-8

" Autostart NerdTree when creating new file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
:let g:NERDTreeWinSize=25

"YCM global config
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion = 1
set completeopt-=preview
highlight YcmErrorLine ctermfg=red term=underline

" lightline options
set laststatus=2
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'seoul256',
	\ }

" .rasi syntax highlighting
au BufNewFile,BufRead /*.rasi setf css

" Colorizer startup
let g:colorizer_startup = 1
let g:colorizer_maxlines = 10

" lens settings

" Resize Max height
"let g:lens#height_resize_max = 50

" Resize Min Height
"let g:lens#height_resize_min = 25

" Resize Max Width
"let g:lens#width_resize_max = 50

" Resize Min Width
"let g:lens#width_resize_min = 20
