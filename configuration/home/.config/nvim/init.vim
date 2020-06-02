let mapleader=","

set nocompatible

set history=1000
set autoread
set hidden
set number
set relativenumber
set cursorline
set clipboard=unnamedplus

set ignorecase
set smartcase

set noswapfile
set nobackup
set nowb

set nowrap

set scrolloff=3
set sidescrolloff=5

set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

syntax on

filetype on
filetype plugin on
filetype indent on

set shell=/bin/zsh

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')
	"! Make sure you use single quotes

	" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
	Plug 'junegunn/vim-easy-align'
	Plug 'tpope/vim-commentary' " minimalistic commentary tool

	" Any valid git URL is allowed
	"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

	Plug 'tpope/vim-surround'
	" acynchronous grep with some additions
	Plug 'mhinz/vim-grepper'

	" On-demand loading
	Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }

	" Plugin outside ~/.vim/plugged with post-update hook
	Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'

	"A low-contrast vim color scheme base on Seoul Colors
	Plug 'junegunn/seoul256.vim'

	" powerline normal/insert/visual/replace colouring
	Plug 'itchyny/lightline.vim'
	Plug 'tpope/vim-fugitive'

	" lsp client, idea stuff
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}

	" bundle for vim that builds off ot the initial scala plugin modules
	Plug 'derekwyatt/vim-scala'


	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	Plug 'vimwiki/vimwiki'
	Plug 'junegunn/goyo.vim'
	Plug 'chazy/dirsettings'

	"autocmd FileType json syntax match Comment +\/\/.\+$+

	" Initialize plugin system
call plug#end()


" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nmap <leader>n :FZF<cr>
nmap <leader>m :Rg<cr>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)

" Advanced customization using Vim function
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

nmap <esc> :noh<cr>

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Trigger for code actions
" Make sure `"codeLens.enable": true` is set in your coc config
nnoremap <leader>cl :<C-u>call CocActionAsync('codeLensAction')<CR>

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Notify coc.nvim that <enter> has been pressed.
" Currently used for the formatOnType feature.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Toggle panel with Tree Views
nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Reveal current current class (trait or object) in Tree View 'metalsBuild'
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsBuild<CR>

" had to remove <leader>ws mapping from VimwikiUISelect
" nunmap doesn't work
" if mapping to command already exist, tasklist won't register new mappings
nmap <leader><leader><leader> <Plug>VimwikiUISelect
nmap <leader>ws <Plug>(coc-metals-expand-decoration)


let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }


map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

silent! nmap <C-p> :NERDTreeToggle<CR>
silent! map <F2> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>
let g:NERDTreeToggle="<F2>"
let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"


let pWiki = {}
let pWiki.path = '~/Documents/vimwiki/pwiki'
let pWiki.syntax = 'markdown'
let pWiki.ext = '.md'

let itWiki = {}
let itWiki.path = '~/Documents/vimwiki/itwiki/it'
let itWiki.ext = '.md'
let itWiki.syntax = 'markdown'

let dicWiki = {}
let dicWiki.path = '~/Documents/vimwiki/itwiki/dic'
let dicWiki.syntax = 'markdown'
let dicWiki.ext = '.md'

let keysWiki = {}
let keysWiki.path = '~/Documents/vimwiki/itwiki/keys'
let keysWiki.syntax = 'markdown'
let keysWiki.ext = '.md'

let devWiki = {}
let devWiki.path = '~/Documents/vimwiki/itwiki/dev'
let devWiki.syntax = 'markdown'
let devWiki.ext = '.md'

let otherWiki = {}
let otherWiki.path = '~/Documents/vimwiki/other'
let otherWiki.syntax = 'markdown'
let otherWiki.ext = '.md'

let investWiki = {}
let investWiki.path = '~/Documents/vimwiki/investwiki'
let investWiki.syntax = 'markdown'
let investWiki.ext = '.md'


let g:vimwiki_list = [itWiki, pWiki, dicWiki, keysWiki, devWiki, otherWiki, investWiki]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown'}
" for snippets to work with tab
let g:vimwiki_table_mappings=0

let g:vimwiki_hl_headers = 1
let g:instant_markdown_autostart = 0	" disable autostart
map <leader>md :InstantMarkdownPreview<CR>

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"  " use <Tab> trigger autocompletion
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
let g:easy_align_delimiters = {
\ '#': { 'pattern': '#\+' },
\ '"': { 'pattern': '\"\+' },
\ }

let g:grepper = {}
let g:grepper.tools = ['grep', 'rg', 'git']
" Search for the current word
nnoremap <Leader>* :Grepper -cword -noprompt<CR>
nnoremap <Leader>F :Grepper<CR>
" Search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" Quickfix
nmap [q :cprevious<CR>
nmap ]q :cnext<CR>

