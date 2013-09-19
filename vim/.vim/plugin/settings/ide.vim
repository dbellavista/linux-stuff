"
" Title: Configuration for "vim as IDE"
" Author: Daniele Bellavista
"
"
let rtpath = split(&runtimepath, ",")[0]

" Section: latexsuite {{{
let g:tex_flavor = "latex"

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_CompileRule_pdf='pdflatex -shell-escape -output-directory tmp/ $*.tex && mv ./tmp/*.pdf ./'
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
