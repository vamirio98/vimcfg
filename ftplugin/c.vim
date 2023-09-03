" c.vim
" Author: vamirio

" Quickly comment single line.
nnoremap <buffer> <localleader>/ I//<ESC>

" Abbreviation for C/C++.
iabbrev <buffer> reutrn return
iabbrev <buffer> incldue include
iabbrev <buffer> inculde include

" Add file head.
if line('$') == 1 && getline(1) == ''
	call base#addFileHead('//', 1)
endif
