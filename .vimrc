set encoding=utf-8
set nocompatible
syntax on

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

set ignorecase
set smartcase
set incsearch
set hlsearch

set autoread
set showmode
set scrolloff=8

map <silent> /<cr> :nohlsearch<cr>

set pastetoggle=<F2>
syntax spell toplevel
map <F12> :set spell! spelllang=en_us<CR>

filetype plugin indent on

if has('autocmd')
  au FileType c,cpp set ts=4 sw=4
endif
