" Enable other vim features
set nocompatible

" Use utf8 display
set encoding=utf-8

" Syntax and coloring
syntax on
set background=dark
colorscheme solarized

" Indenting and tabs
set autoindent
set copyindent
set smartindent
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set smarttab
set backspace=indent,eol,start

" Interface options
set cursorline
set number
set ruler
set showcmd
set showmode
set showmatch
set scrolloff=7
set textwidth=80
set colorcolumn=+1

" File related options
set autoread
set nobackup
set noswapfile
set nowb

" Search and highlighting
nmap <space> /
nmap <c-space> ?
nmap <silent> <space><cr> :nohlsearch<cr>
set ignorecase
set smartcase
set incsearch
set hlsearch

" Copy pasting across vim
vmap <C-c> "+y
nmap <C-p> "+p

" Show whitespace characters on <F9>
set listchars=eol:$,tab:->,trail:~,extends:>,precedes:<

" Shortcuts
map <F9>  :set list!<CR>
set pastetoggle=<F10>
map <F12> :set spell! spelllang=en_us<CR>
