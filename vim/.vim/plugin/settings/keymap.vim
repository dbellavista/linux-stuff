"
" Title: Key mapping
" Author: Daniele Bellavista
"
"

" Section: Editing {{{
noremap <leader>o <Esc>i<CR><Esc>
noremap <leader>O <Esc>i<CR><Esc>-$
inoremap <leader>r <Esc>:s/;/\r{\r\t<+type+> ret;\r\t<+body+>\r\treturn ret;\r}i<CR>
" }}}

" Section: Search settings {{{
nnoremap <F3> :set hlsearch!<CR>
" }}}

" Section: Copy&Paste configuration {{{

set pastetoggle=<F2> " avoid auto-indent while pastings
nnoremap Y y$

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
" }}}

" Section: Split windows {{{

inoremap <C-h> <C-w>

noremap <C-left> <C-W><
noremap <C-right> <C-W>>
noremap <C-up> <C-W>+
noremap <C-down> <C-W>-

" }}}

" Section: Movement {{{
nnoremap <up> gk
nnoremap <down> gj
" }}}

" Section: Formatting {{{
nnoremap Q gqq
" }}}

" Section: Compiling {{{
inoremap <F7> <Esc>:w<CR>:silent make \|redraw!\|cw<CR>
nnoremap <F7> :silent make \|redraw!\|cw<CR>
inoremap <F5> <Esc>:w<CR>:silent make -- install\|redraw!\|cw<CR>
nnoremap <F5> :silent make -- install\|redraw!\|cw<CR>
inoremap <F6> <Esc>:w<CR>:CMake<CR>i
nnoremap <F6> :CMake<CR>
" }}}

" Section: Tabs {{{
noremap <left> :tabprev<CR>
noremap <right> :tabnext<CR>
noremap <up> :tabfirst<CR>
noremap <down> :tablast<CR>
noremap c :tabclose<CR>
noremap t :tabnew %<CR>
noremap <Tab> <C-w><C-w>
" }}}
