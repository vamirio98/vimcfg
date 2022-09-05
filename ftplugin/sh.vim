"-
" sh.vim
" 
" Created by vamirio on 2021 Oct 14
"-

if line('$') == 1 && getline(1) == ''
	call setline(1, "#!/bin/bash")
	call append(1, "")
	call base#add_file_head('#-', '#', '#-', 3)
endif

"-
" Jump out comments.
"-
nnoremap <silent><buffer> <M-g>
			\ :call base#jump_out_comment('n', '', '#-')<CR>
nnoremap <silent><buffer> <M-G>
			\ :call base#jump_out_comment('n', 'b', '#-')<CR>
inoremap <silent><buffer> <M-g>
			\ <ESC>:call base#jump_out_comment('i', '', '#-')<CR>
inoremap <silent><buffer> <M-G>
			\ <ESC>:call base#jump_out_comment('i', 'b', '#-')<CR>
