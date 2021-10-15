"-------------------------------------------------------
" sh.vim -
" 
" Created by Vamirio on 2021 Oct 14
" Last Modified: 2021 Oct 15 10:27:06
"-------------------------------------------------------

if line('$') == 1 && getline(1) == ''
	call setline(1, "#!/bin/bash")
	call append(1, "")
	call base#AddFileHead(
				\ "#-------------------------------------------------------",
				\ "#",
				\ "#-------------------------------------------------------",
				\ 3)
endif


augroup SHELL
	autocmd!
	autocmd BufWritePre,FileWritePre *.sh call base#ModifyTime('#-', '#-')
augroup END


"-------------------------------------------------------
" jump out comments
"-------------------------------------------------------
nnoremap <buffer> <silent> <M-g> :call base#JumpToComment('n', '', '#-')<CR>
nnoremap <buffer> <silent> <M-G> :call base#JumpToComment('n', 'b', '#-')<CR>
inoremap <buffer> <silent> <M-g> <ESC>:call base#JumpToComment('i', '', '#-')<CR>
inoremap <buffer> <silent> <M-G> <ESC>:call base#JumpToComment('i', 'b', '#-')<CR>
