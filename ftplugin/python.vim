"-
" python.vim
" 
" Created by vamirio on 2021 Nov 08
"-

if line('$') == 1 && getline(1) == ''
	call setline(1, '#!/usr/bin/env python3')
	call setline(2, '# -*- coding: utf-8 -*-')
	call setline(3, '')
	call base#add_file_head('#-', '#', '#-', 4)
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
