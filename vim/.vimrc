"
" Title:  Vimrc file
" Author: Daniele Bellavista
" Note: some configuration is stored in $VIM_DIR/plugin/settings
"

set nocompatible " Use vim settings instead of vi
filetype on  " Automatically detect file types.
filetype plugin on
filetype indent on
set viminfo^=\!
set grepprg=grep\ -nH\ $*
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

" Section: Coloring {{{
syn on

if has('gui_running')
	colorscheme slate
	set guioptions-=m  "remove menu bar
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar
else
	"colorscheme my_theme
	colorscheme wombat256mod
	"colorscheme default
	"colorscheme anotherdark
	"colorscheme BusyBee
	hi clear SpellBad
	hi SpellBad cterm=underline ctermfg=red
endif
" }}}

" Section: visualization {{{
set number " Enabled line number
set laststatus=2        " Always show status line.
set title               " change the terminal's title
set ruler " Coordinate bottom right
set mouse -=a " Mouse managment
set list listchars=tab:\ \ ,trail:~,extends:>,precedes:<
" }}}

" Section: movement {{{
set iskeyword-=_
" }}}

" Section: Indentation {{{
set autoindent
set copyindent
set tabstop=2
set shiftwidth=2
set expandtab
set shiftround
" }}}

" Section: Vim undo {{{
set undolevels=1000
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile
" }}}

" Section: Vim buffers {{{
set hidden
set autoread
" }}}

" Section: Vim behavior {{{
set visualbell
set noerrorbells
set history=1000
set scrolloff=10
set sidescroll=1
" }}}

" Section: Search settings {{{
set smartcase
set incsearch
set hlsearch!
" }}}

" Section: Pathogen {{{
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" }}}
