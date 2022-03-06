"-
" python.vim
" 
" Created by vamirio on 2021 Nov 08
" Last Modified: 2021 Dec 21 12:11:50
"-

if line('$') == 1 && getline(1) == ''
	call setline(1, '#!/usr/bin/env python3')
	call setline(2, '# -*- coding: utf-8 -*-')
	call setline(3, '')
	call base#AddFileHead('#-', '#', '#-', 4)
endif

augroup MyPython
	au!
	au BufEnter *.py call base#SetBufChangedFlag(0)
	au BufWritePre,FileWritePre *.py
				\ call base#SetBufChangedFlag(1) |
				\ call base#SetLastModifiedTimeStr()
	au BufLeave,BufUnload *.py call base#UpdateLastModifiedAndSave('/*', '*/')
augroup END

"-
" Jump out comments.
"-
nnoremap <silent><buffer> <M-g>
			\ :call base#JumpToComment('n', '', '#-')<CR>
nnoremap <silent><buffer> <M-G>
			\ :call base#JumpToComment('n', 'b', '#-')<CR>
inoremap <silent><buffer> <M-g>
			\ <ESC>:call base#JumpToComment('i', '', '#-')<CR>
inoremap <silent><buffer> <M-G>
			\ <ESC>:call base#JumpToComment('i', 'b', '#-')<CR>
