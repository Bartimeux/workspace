set nocompatible
filetype off " required for vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'marijnh/tern_for_vim'
Bundle 'Syntastic'
Bundle 'Solarized'
Bundle 'flazz/vim-colorschemes'
Bundle "tomasr/molokai"
"Bundle 'pangloss/vim-javascript'
Bundle 'plasticboy/vim-markdown'
Bundle 'kchmck/vim-coffee-script'
Bundle 'othree/html5.vim'
Bundle 'ap/vim-css-color'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'wavded/vim-stylus'
Bundle 'Lokaltog/vim-powerline'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'
" All of your Plugins must be added before the following line
call vundle#end() " required
" Load the plugin
filetype plugin indent on
let g:vim_markdown_folding_disabled=1
au BufRead,BufNewFile *.json set filetype=json
" Color
set t_Co=256
let g:syntastic_ruby_checkers = ['rubocop', 'mri', 'rubylint']
" Syntax highlightment
syntax enable
" PowerLine bar
set laststatus=2
" Indentation
set expandtab
set ts=2
set sw=2
" show line numbers
set number
" obvious
set encoding=utf8
" searching highlighting
set hlsearch
set incsearch
set ignorecase
set smartcase
" enter :so % to try your .vimrc
