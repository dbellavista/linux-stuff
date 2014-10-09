" Vim syntax file
" Language:	Gentoo package.use files
" Author:	Ciaran McCreesh <ciaranm@gentoo.org>
" Copyright:	Copyright (c) 2004-2005 Ciaran McCreesh
" Licence:	You may redistribute this under the same terms as Vim itself
"
" Syntax highlighting for Gentoo package.env files. Requires vim 6.3 or
" later.
"

if &compatible || v:version < 603
    finish
endif

if exists("b:current_syntax")
  finish
endif

runtime syntax/gentoo-common.vim

syn region GentooPackageEnvComment start=/#/ end=/$/
	    \ contains=GentooPackageEnvEmail,GentooPackageUseDate,GentooBug

syn match  GentooPackageEnvEmail contained /<[a-zA-Z0-9\-\_]\+@[a-zA-Z0-9\-\_\.]\+>/
syn match  GentooPackageEnvDate  contained /(\(\d\d\?\s\w\+\|\w\+\s\d\d\?\)\s\d\{4\})/

syn match  GentooPackageEnvAtom /^[^ \t\n#]\+\S\+\/\S\+/
	    \ nextgroup=GentooPackageEnvConf skipwhite
syn match  GentooPackageEnvConf contained /[a-zA-Z0-9][a-zA-Z0-9\-_]*\.conf/
	    \ nextgroup=GentooPackageEnvConf skipwhite

hi def link GentooPackageEnvComment          Comment
hi def link GentooPackageEnvEmail            Special
hi def link GentooPackageEnvDate             Number
hi def link GentooPackageEnvAtom             Identifier
hi def link GentooPackageEnvConf             Special

let b:current_syntax = "gentoo-package-env"

