" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1

let mapleader=" " 
let maplocalleader = ","
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'mboughaba/i3config.vim'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'lervag/vimtex'
Plugin 'scrooloose/nerdtree'
Plugin 'ebranlard/vim-matlab-behave'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'mkitt/tabline.vim'

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
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Set hybrid line numbers
set relativenumber
set number

syntax on

aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

set mouse=a
set tabstop=4
set shiftwidth=4


" vimtex stuffs
let g:vimtex_view_general_viewer = 'evince'

" Markdown mappings
autocmd FileType markdown nnoremap <Leader>p :Pandoc pdf <CR>
autocmd FileType markdown nnoremap <Leader>b :Pandoc beamer <CR>
autocmd FileType markdown nnoremap <Leader>h :! pandoc % --toc -s --mathjax -o %:r.html <CR>

" autocmd BufwritePost *.md :Pandoc pdf


" Colors
highlight Folded ctermfg=4 ctermbg=8
highlight SpellBad ctermfg=7 ctermbg=9


" NerdTree stuff
nnoremap <C-n> :NERDTreeToggle <CR>
" Auto close when tree is only open window
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Tab switching
no <C-j> <C-w>j | "Switching Below tab
no <C-k> <C-w>k | "Switching Above tab
no <C-l> <C-w>l | "Switching Right tab
no <C-h> <C-w>h | "Switching Left tab
