au BufRead,BufNewFile .gitignore setfiletype gitignore
au BufRead,BufNewFile *.pcl setfiletype pcl
au BufRead,BufNewFile *.jade setfiletype jade
au BufRead,BufNewFile CMake*.txt setfiletype cmake
" package.env
au BufNewFile,BufRead {*/package.env,*/portage/package.env/*}
    \     set filetype=gentoo-package-env
