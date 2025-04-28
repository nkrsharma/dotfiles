" Enable other vim features
set nocompatible
set noeb vb t_vb=

" Configure encoding
set encoding=utf-8

" Configure Vundle and add plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
if isdirectory(expand('$HOME/.vim/bundle/Vundle.vim'))
  call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'google/vim-maktaba'
  Plugin 'google/vim-codefmt'
  Plugin 'google/vim-glaive'
  Plugin 'ycm-core/YouCompleteMe'
  Plugin 'vim-syntastic/syntastic'
  call vundle#end()
else
  echomsg 'Vundle not installed'
endif

filetype plugin indent on

" Automatically change the working path to the path of the current file.
autocmd BufNewFile,BufEnter * silent! lcd %:p:h

augroup autoformat_settings
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
augroup END

" Syntax and coloring
syntax on
set background=dark
colorscheme gruvbox

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
set colorcolumn=+1
set cursorline
set nomore
set number
set ruler
set scrolloff=7
set showcmd
set showmatch
set showmode
set showtabline=2
set splitbelow
set splitright
set textwidth=80

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

" Tab shortcuts
noremap <C-m> <Esc>:tabnew<CR>
noremap <C-b> <Esc>:tabp<CR>
noremap <C-n> <Esc>:tabn<CR>

" Pane shortcuts
noremap <C-_> <Esc>:new<CR>
noremap <C-\> <Esc>:vnew<CR>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Copy paste to system clipboard
nmap <C-c> "+y
nmap <C-p> "+p

" Show whitespace characters on <F9>
set listchars=eol:$,tab:->,trail:~,extends:>,precedes:<

" Shortcuts
map <F9>  :set list!<CR>
set pastetoggle=<F10>
map <F12> :set spell! spelllang=en_us<CR>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
