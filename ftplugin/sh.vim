"-------------------------------------------------------
" sh.vim -
" 
" Created by Vamirio on 2021 Oct 14
" Last Modified: 2021 Oct 14 11:11:08
"-------------------------------------------------------

"-------------------------------------------------------
" add file head
"-------------------------------------------------------
function! s:AddFileHead()
	call setline(1, "#!/bin/bash")
	call setline(2, "")
	call setline(3, "#-------------------------------------------------------")
	call setline(4, "# " . expand("%:t") . " -")
	call setline(5, "#")
	call setline(6, "# Created by Vamirio on " . strftime("%Y %b %d"))
	call setline(7, "# Last Modified: " . strftime("%Y %b %d %T"))
	call setline(8, "#-------------------------------------------------------")
	execute "normal! 3j"
	execute "startinsert!"
endfunction

if line('$') == 1
	call s:AddFileHead()
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
