"""""""""""""""""""""
"	Vim RC file		"
" Daniel Bellavista "
" 					"
"""""""""""""""""""""
set nocompatible " Use vim settings instead of vi
filetype on  " Automatically detect file types.

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

" Add recently accessed projects menu (project plugin)
filetype plugin on
set viminfo^=\!

set number " Enabled line number
" Autoindentation
set autoindent
set copyindent
" Tab spacing
set tabstop=2
set shiftwidth=2
set expandtab
set shiftround
" Coordinate bottom right
set ruler
" Mouse managment
set mouse -=a
" Let buffers opened when opening new file
set hidden

set smartcase

set laststatus=2  " Always show status line.
set clipboard+=unnamed  " Yanks go on clipboard instead.

set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set incsearch     " show search matches as you typei

set hlsearch!

set pastetoggle=<F2> " avoid auto-indent while pastings
nnoremap <F3> :set hlsearch!<CR>

set list listchars=tab:\ \ ,trail:~,extends:>,precedes:<

inoremap <C-h> <C-w>

nnoremap <up> gk
nnoremap <down> gj
nnoremap Y y$
nnoremap Q gqq
vnoremap <LocalLeader>v "+p
nnoremap <LocalLeader>v "+p
vnoremap <LocalLeader>c "+y
vnoremap <LocalLeader>V "+y$
vnoremap <LocalLeader>x "+d
vnoremap <LocalLeader>X "+dd

nnoremap <LocalLeader>p "*p
vnoremap <LocalLeader>y "*y
nnoremap <LocalLeader>Y "*y$
vnoremap <LocalLeader>d "*d
nnoremap <LocalLeader>dd "*dd

" TABS "{{{2
" ---------------------------------

" CREATE A NEW TAB {{{3
map <LocalLeader>tc :tabnew %<CR>

" LAST TAB {{{3
map <LocalLeader>t<Space> :tablast<CR>

" CLOSE A TAB {{{3
map <LocalLeader>tk :tabclose<CR>

" NEXT TAB {{{3
map <LocalLeader>tn :tabnext<CR>

" PREVIOUS TAB {{{3
map <LocalLeader>tp :tabprev<CR>

filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

let g:SuperTabDefaultCompletionType = "context"

noremap <leader>e <Esc>:CommandT<CR>
noremap <leader>E <Esc>:CommandTFlush<CR>
noremap <leader>b <Esc>:CommandTBuffer<CR>

let g:tagbar_usearrows = 1

let g:tex_verbspell = 1

nnoremap <leader>l :TagbarToggle<CR>

noremap <leader>o <Esc>i<Enter><Esc>
noremap <leader>O <Esc>i<Enter><Esc>-$

noremap <Tab> <C-w><C-w>

" Section: Compiling {{{
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_CompileRule_pdf='pdflatex -shell-escape -output-directory tmp/ $*.tex && mv ./tmp/*.pdf ./'
" let g:Tex_BIBINPUTS="bib"
let g:Tex_BibtexFlavor = "bibtex"
let g:Tex_CompileRule_bib = g:Tex_BibtexFlavor . ' tmp/$*'
" }}}

" Section: VimOrganizer {{{
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
au BufEnter *.org 	call org#SetOrgFileType()
" }}}
