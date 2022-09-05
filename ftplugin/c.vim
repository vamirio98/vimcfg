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

" Add file head.
if line('$') == 1 && getline(1) == ''
	call base#add_file_head('/**', ' *', ' */', 1)
endif

"-
" Jump to comments.
"-
nnoremap <silent><buffer> <M-g>
			\ :call base#jump_out_comment('n', '', '\(\/\*\\|\*\/\)')<CR>
nnoremap <silent><buffer> <M-G>
			\ :call base#jump_out_comment('n', 'b', '\(\/\*\\|\*\/\)')<CR>
inoremap <silent><buffer> <M-g>
			\ <ESC>:call base#jump_out_comment('i', '', '\(\/\*\\|\*\/\)')<CR>
inoremap <silent><buffer> <M-G>
			\ <ESC>:call base#jump_out_comment('i', 'b', '\(\/\*\\|\*\/\)')<CR>
