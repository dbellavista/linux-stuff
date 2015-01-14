"
" Title: Configuration for "vim as IDE"
" Author: Daniele Bellavista
"
"
let rtpath = split(&runtimepath, ",")[0]

" Section: Vim IDE mode {{{ 
if argc() == 0
  autocmd vimenter * NERDTree
  autocmd vimenter * NERDTree
  autocmd vimenter * Tagbar
endif
" }}}

" Section: compiling {{{
"function GuessCompiler(...)
  "let g:makeprg = "echo no make program setted"
  "let s:res = execute "CMake"
  "if (s:res == 1)
    "echo "CMake detected!"
  "elseif (&ft == 'cpp')
    "g:makeprg = "make"
  "elseif (&ft == 'c')
    "g:makeprg = "make"
  "endif
"endfunction

" }}}

" Section: youcompleteme {{{

let g:ycm_filetype_specific_completion_to_disable = "javascript"

" }}}

" Section: latexsuite {{{
let g:tex_flavor = "luatex"

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_CompileRule_pdf='lualatex -shell-escape -output-directory tmp/ $*.tex && mv ./tmp/*.pdf ./'
" let g:Tex_BIBINPUTS="bib"
let g:Tex_BibtexFlavor = "bibtex"
let g:Tex_CompileRule_bib = g:Tex_BibtexFlavor . ' tmp/$*'
let g:tex_verbspell = 1
" }}}

" Section: c-support {{{

"let g:C_LocalTemplateFile = rtpath . "/templates/csupport/Templates"
"let g:C_CodeSnippets =  rtpath . "/templates/codesnippets"
let g:C_IndentArguments = "-nbad -bap -nbc -bbo -hnl -br -brs -c33 -cd33 -ncdb -ce -ci4 -cli0 -d0 -di1 -nfc1 -i8 -ip0 -l80 -lp -npcs -nprs -npsl -sai -saf -saw -ncs -nsc -sob -nfca -cp33 -ss -ts8 -il1"

" }}}

" Section: cpp11 {{{
au BufNewFile,BufRead *.cpp set syntax=cpp11
" }}}

" Section: VimTemplate {{{
let g:templates_no_autocmd = 0
let g:template_dir = rtpath . "/templates"
" }}}

" Section: NERDTree {{{
nnoremap <leader>t :NERDTreeToggle<CR>
" }}}

" Section: TagBar {{{
nnoremap <leader>l :TagbarToggle<CR>
let g:tagbar_usearrows = 1
" }}}

" Section: Closetag {{{
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim
" }}}

" Section: Syntastic {{{
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_always_populate_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active',
														\ 'active_filetypes': [],
                            \ 'passive_filetypes': [] }
let g:syntastic_c_checkers = ['ycm']
let g:syntastic_cpp_checkers = ['ycm']
let g:syntastic_cpp_check_header = 1
let g:syntastic_python_checkers = ['pep8']
let g:syntastic_html_checkers = ['tidy']
" }}}

" Section: Underline section {{{

function! ToggleHighlight(...)
  if a:0 == 1 "toggle behaviour
    let g:toggleHighlight = 1 - g:toggleHighlight
  endif

  if g:toggleHighlight == 1 "normal action, do the hi
    silent! exe printf('match Underlined /\<%s\>/', expand('<cword>'))
  else
    "do whatever you need to clear the matches
    "or nothing at all, since you are not printing the matches
    call clearmatches()
  endif
endfunction

let g:toggleHighlight = 0
autocmd CursorMoved * call ToggleHighlight()

" }}}

" Section: Tabs {{{
function TabToggle()
  if &expandtab
    set noexpandtab
  else
    set expandtab
  endif
endfunction
" }}}

" Section: CAPS mode {{{
set imsearch=-1
set keymap=insert-only_capslock
set iminsert=0
"set statusline^=%k
" }}}

" Section: Status Lne {{{
hi User1	ctermfg=111		cterm=none		guifg=#88b8f6	gui=none
hi User2	ctermfg=173		cterm=none		guifg=#88b8f6	gui=none
hi User3	ctermfg=192		cterm=none		guifg=#e5786d	gui=none
hi User4	ctermfg=186		cterm=none		guifg=#e5786d	gui=none
hi User5	ctermfg=230		cterm=none		guifg=#e5786d	gui=none
hi User6	ctermfg=167		cterm=none		guifg=#e5786d	gui=none

set statusline=
set statusline+=%3*
set statusline+=%m      "modified flag
set statusline+=%4*
set statusline+=%f\ 
set statusline+=%1*
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%2*
set statusline+=\ %y      "filetype
set statusline+=%3*
set statusline+=%h      "help file flag
set statusline+=%r      "read only flag
set statusline+=%=      "left/right separator
set statusline+=%6*
set statusline+=%k\     " Flag
set statusline+=%5*
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
" }}}

" Section: folding {{{
set foldmethod=marker
" }}}

" Section: javascript {{{
" javascript_enable_domhtmlcss
" }}}

" Section: CtrlP {{{
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](frontend/libs|node_modules|target|dist|bin)|(\.(git|hg|svn))$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" }}}
