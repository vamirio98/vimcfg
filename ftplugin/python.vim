"-------------------------------------------------------
"  python.vim -
" 
"  Created by Vamirio on 2021 Nov 08
"  Last Modified: 2021 Nov 08 12:13:17
"-------------------------------------------------------

if line('$') == 1 && getline(1) == ''
	call setline(1, '#!/usr/bin/env python3')
	call setline(2, '# -*- coding: utf-8 -*-')
	call setline(3, '')
	call base#AddFileHead('##', '#', '##', 4)
endif

augroup PYTHON
	autocmd!
	autocmd BufWritePre,FileWritePre *.py call base#ModifyTime('##', '##')
augroup END

""
" jump out comments
""
nnoremap <buffer> <silent> <M-g> :call base#JumpToComment('n', '', '##')<CR>
nnoremap <buffer> <silent> <M-G> :call base#JumpToComment('n', 'b', '##')<CR>
inoremap <buffer> <silent> <M-g> <ESC>:call base#JumpToComment('i', '', '##')<CR>
inoremap <buffer> <silent> <M-G> <ESC>:call base#JumpToComment('i', 'b', '##')<CR>
