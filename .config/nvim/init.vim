"**********************************************************************************
"
" init.vim
"
"**********************************************************************************

let mapleader=" " 
let maplocalleader = ","
set nocompatible              " be iMproved, required
filetype off                  " required

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.nvim/plugged')


Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-fugitive'
Plug 'git://git.wincent.com/command-t.git'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'mboughaba/i3config.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'
Plug 'ebranlard/vim-matlab-behave'
Plug 'justinmk/vim-syntax-extra'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mkitt/tabline.vim'
Plug 'itchyny/lightline.vim'
Plug 'dracula/vim', {'name':'dracula'}
Plug 'ap/vim-css-color'
Plug 'jreybert/vimagit'
Plug 'vim-python/python-syntax'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Load vim-devicons last
Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()

" Set hybrid line numbers
set relativenumber
set number

syntax on
set encoding=UTF-8

set mouse=a
set tabstop=4
set shiftwidth=4

" Reload file when changed externally
set autoread


" vimtex stuffs
let g:vimtex_view_general_viewer = 'evince'
let g:tex_flavor = 'latex'

" Markdown mappings
autocmd FileType markdown nnoremap <Leader>p :Pandoc pdf <CR>
autocmd FileType markdown nnoremap <Leader>b :Pandoc beamer <CR>
autocmd FileType markdown nnoremap <Leader>h :! pandoc % --toc -s --mathjax -o %:r.html <CR>


" Colors
highlight Folded ctermfg=4 ctermbg=8
highlight SpellBad ctermfg=7 ctermbg=9
highlight Search ctermfg=grey ctermbg=yellow

" Tab switching
no <C-j> <C-w>j | "Switching Below tab
no <C-k> <C-w>k | "Switching Above tab
no <C-l> <C-w>l | "Switching Right tab
no <C-h> <C-w>h | "Switching Left tab


let g:lightline = {
	\ 'colorscheme' : 'darcula',
    \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
	\ }

" Colors from Distro Tube (Dracula theme)
  highlight LineNr           ctermfg=8    ctermbg=none    cterm=none
  highlight CursorLineNr     ctermfg=7    ctermbg=8       cterm=none
  highlight VertSplit        ctermfg=0    ctermbg=8       cterm=none
  highlight Statement        ctermfg=2    ctermbg=none    cterm=none
  highlight Directory        ctermfg=4    ctermbg=none    cterm=none
  highlight StatusLine       ctermfg=7    ctermbg=8       cterm=none
  highlight StatusLineNC     ctermfg=7    ctermbg=8       cterm=none
  highlight NERDTreeClosable ctermfg=2
  highlight NERDTreeOpenable ctermfg=8
  highlight Comment          ctermfg=4    ctermbg=none    cterm=none
  highlight Constant         ctermfg=12   ctermbg=none    cterm=none
  highlight Special          ctermfg=4    ctermbg=none    cterm=none
  highlight Identifier       ctermfg=6    ctermbg=none    cterm=none
  highlight PreProc          ctermfg=5    ctermbg=none    cterm=none
  highlight String           ctermfg=12   ctermbg=none    cterm=none
  highlight Number           ctermfg=1    ctermbg=none    cterm=none
  highlight Function         ctermfg=1    ctermbg=none    cterm=none

" Remove pipe symbols from splits
set fillchars+=vert:\ 

" Splits and tabs
set splitbelow splitright

" Python syntax
let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0


" ------------------------------------------------------------------------
" Conquerer of Completion shizz
" ------------------------------------------------------------------------

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

 " Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif


" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add `:Header` command to switch between header and source
command! -nargs=0 Header :call 	CocAction('runCommand', 'clangd.switchSourceHeader')

" Coc explorer shizz
nmap <leader>e :CocCommand explorer<CR>

" Fzf 
nnoremap <C-p> :GFiles<CR>