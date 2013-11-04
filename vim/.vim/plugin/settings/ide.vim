"
" Title: Configuration for "vim as IDE"
" Author: Daniele Bellavista
"
"
let rtpath = split(&runtimepath, ",")[0]

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
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_html_checkers = ['tidy']
" }}}

" Section: Viske {{{
let g:ViskeDir="/mnt/shared/Schedule/"
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
