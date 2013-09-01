"
" Title: Key mapping
" Author: Daniele Bellavista
"
"

" Section: Editing {{{
noremap <leader>o <Esc>i<Enter><Esc>
noremap <leader>O <Esc>i<Enter><Esc>-$
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

" Section: Tabs {{{
noremap <left> :tabprev<CR>
noremap <right> :tabnext<CR>
noremap <up> :tabfirst<CR>
noremap <down> :tablast<CR>
noremap c :tabclose<CR>
noremap t :tabnew %<CR>
noremap <Tab> <C-w><C-w>
" }}}
