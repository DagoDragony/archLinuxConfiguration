set nocompatible

set history=1000
set autoread
set hidden
set number
set relativenumber
set cursorline

set noswapfile
set nobackup
set nowb

set nowrap

set scrolloff=3
set sidescrolloff=5

set shell=/bin/bash


" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

"A low-contrast vim color scheme base on Seoul Colors
Plug 'junegunn/seoul256.vim'

Plug 'gabrielelana/vim-markdown'

" normal/insert/visual/replace colouring
Plug 'itchyny/lightline.vim'

" 
Plug 'junegunn/vim-easy-align'

" lsp client, idea stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" bundle for vim that builds off ot the initial scala plugin modules
Plug 'derekwyatt/vim-scala'

" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

autocmd FileType json syntax match Comment +\/\/.\+$+

" Initialize plugin system
call plug#end()
