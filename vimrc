set encoding=utf-8
set nocompatible
syntax on
set background=dark
colorscheme solarized

" Indentation
set autoindent
set copyindent
set smartindent
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set smarttab

set backspace=indent,eol,start
set number
set ruler
set showcmd
set showmode
set textwidth=72
set showmatch

set scrolloff=7

set autoread
set noswapfile
set nobackup
set nowb

nmap <space> /
nmap <c-space> ?
nmap <silent> <space><cr> :nohlsearch<cr>
set ignorecase
set smartcase
set incsearch
set hlsearch

set clipboard=unnamed

map <F3> :set spell! spelllang=en_us<CR>
set pastetoggle=<F2>
syntax spell toplevel

syntax on
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

if has('autocmd')
  au FileType c,cpp set ts=4 sw=4 textwidth=80
  au FileType python set ts=2 sw=2
  au BufRead,BufNewFile *.xpc set filetype=c
endif

set tags=tags;/
source ~/.vim/cscope_maps.vim
