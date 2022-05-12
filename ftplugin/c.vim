"-
" c.vim
" 
" Created by vamirio on 2021 Oct 14
"-

" Quickly comment single line.
nnoremap <buffer> <localleader>/ I//<ESC>

" Abbreviation for C/C++.
iabbrev <buffer> reutrn return
iabbrev <buffer> incldue include
iabbrev <buffer> inculde include

"-
" Add comment.
"-
nnoremap <silent><buffer> <M-c>
			\ :call base#AddComment('n', ['/**', ' * ', ' */'])<CR>
inoremap <silent><buffer> <M-c>
			\ <ESC>:call base#AddComment('i', ['/**', ' * ', ' */'])<CR>

" Add file head.
if line('$') == 1 && getline(1) == ''
	call base#AddFileHead('/**', ' *', ' */', 1)
endif

"-
" Jump to comments.
"-
nnoremap <silent><buffer> <M-g>
			\ :call base#JumpToComment('n', '', '\(\/\*\\|\*\/\)')<CR>
nnoremap <silent><buffer> <M-G>
			\ :call base#JumpToComment('n', 'b', '\(\/\*\\|\*\/\)')<CR>
inoremap <silent><buffer> <M-g>
			\ <ESC>:call base#JumpToComment('i', '', '\(\/\*\\|\*\/\)')<CR>
inoremap <silent><buffer> <M-G>
			\ <ESC>:call base#JumpToComment('i', 'b', '\(\/\*\\|\*\/\)')<CR>
