set nocompatible

set history=1000
set autoread
set hidden
set number
set relativenumber
set cursorline

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

let mapleader=","
filetype plugin on
syntax on

set shell=/bin/bash

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" Search
" todo map Esc to execute :noh for highlight removal after search 
" todo optimize plug install?
" todo review Luke init.vim

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
"Plug 'tpope/vim-commentary' " minimalistic commentary tool

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

"Plug 'SirVer/ultisnips'

"Plug 'honza/vim-snippets'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"A low-contrast vim color scheme base on Seoul Colors
Plug 'junegunn/seoul256.vim'

" powerline normal/insert/visual/replace colouring
Plug 'itchyny/lightline.vim'

" lsp client, idea stuff
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" bundle for vim that builds off ot the initial scala plugin modules
"Plug 'derekwyatt/vim-scala'

Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
Plug 'chazy/dirsettings'
"Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

"nmap <leader><tab> <plug>(fzf-maps-n)
"xmap <leader><tab> <plug>(fzf-maps-x)
"omap <leader><tab> <plug>(fzf-maps-o)
"
nmap <leader>n :FZF<cr>
"
"" Configuration for vim-scala
"au BufRead,BufNewFile *.sbt set filetype=scala

"autocmd FileType json syntax match Comment +\/\/.\+$+

" Initialize plugin system
call plug#end()


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

"" Use tab for trigger completion with characters ahead and navigate.
"" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()
"
"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"" Or use `complete_info` if your vim support it, like:
"" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"
"" Use `[g` and `]g` to navigate diagnostics
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"
"" Use K to show documentation in preview window
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"
"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
"    call CocAction('doHover')
"  endif
"endfunction
"
"" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')
"
"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)
"
"" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
"
"augroup mygroup
"  autocmd!
"  " Setup formatexpr specified filetype(s).
"  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"  " Update signature help on jump placeholder
"  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end
"
"" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)
"
"" Remap for do codeAction of current line
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)
"
"" Create mappings for function text object, requires document symbols feature of languageserver.
"xmap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap if <Plug>(coc-funcobj-i)
"omap af <Plug>(coc-funcobj-a)
"
"" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)
"
"" Use `:Format` to format current buffer
"command! -nargs=0 Format :call CocAction('format')
"
"" Use `:Fold` to fold current buffer
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
"" use `:OR` for organize import of current buffer
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"
"" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
"" Using CocList
"" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"
"silent! nmap <C-p> :NERDTreeToggle<CR>
"silent! map <F2> :NERDTreeToggle<CR>
"silent! map <F3> :NERDTreeFind<CR>
"let g:NERDTreeToggle="<F2>"
"let g:NERDTreeMapActivateNode="<F3>"
"let g:NERDTreeMapPreview="<F4>"

" vim wiki
"let itWiki = {
"	'path': '~/Documents/itwiki/',
"	'syntax': 'markdown',
"	'ext': '.md'
"}


let itWiki = {}
let itWiki.path = '~/Documents/itwiki/'
let itWiki.syntax = 'markdown'
let itWiki.ext = '.md'

let pWiki = {}
let pWiki.path = '~/Documents/pwiki/'
let pWiki.syntax = 'markdown'
let pWiki.ext = '.md'

let dicWiki = {}
let dicWiki.path = '~/Documents/dicwiki/'
let dicWiki.syntax = 'markdown'
let dicWiki.ext = '.md'

let keysWiki = {}
let keysWiki.path = '~/Documents/keyswiki/'
let keysWiki.syntax = 'markdown'
let keysWiki.ext = '.md'

let g:vimwiki_list = [itWiki, pWiki, dicWiki, keysWiki]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown'}


let g:instant_markdown_autostart = 0	" disable autostart
map <leader>md :InstantMarkdownPreview<CR>


