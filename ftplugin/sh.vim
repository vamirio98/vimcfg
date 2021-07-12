"=======================================================
" sh.vim -
" 
" Created by Haoyuan Li on 2021/07/04
" Last Modified: 2021/07/12 09:14:23
"=======================================================

"-------------------------------------------------------
" add file head
"-------------------------------------------------------
function! s:AddFileHead()
	call setline(1, "#!/bin/bash")
	call setline(2, "")
	call setline(3, "#-------------------------------------------------------")
	call setline(4, "# " . expand("%:t") . " -")
	call setline(5, "#")
	call setline(6, "# Created by hyl on " . strftime("%Y/%m/%d"))
	call setline(7, "# Last Modified: " . strftime("%Y/%m/%d %T"))
	call setline(8, "#-------------------------------------------------------")
	execute "normal! 3j"
	execute "startinsert!"
endfunction

if line('$') == 1
        call s:AddFileHead()
endif


"-------------------------------------------------------
" auto modify the Last Modified Time
"-------------------------------------------------------
function! s:ModifyTime()
	let l:cur_pos = getcurpos()
    call cursor(1, 1)
    let l:b = searchpos('#=', 'c')
    let l:e = searchpos('#=', 'n')
    let l:t = search('Last Modified:')
    if l:b[0] < 5 && l:t < l:e[0] && l:b[1] == 1 && l:e[1] == 1
        execute l:b[0] . "," . l:t . "g/Last Modified:/s/Last Modified:.*/"
                    \ . "Last Modified: " . strftime("%Y\\/%m\\/%d %T")
    endif
	call cursor(l:cur_pos[1], l:cur_pos[2])
endfunction

augroup SHELL
    autocmd!
    autocmd BufWritePre,FileWritePre *.sh call s:ModifyTime()
augroup END


"-------------------------------------------------------
" jump out comments
"-------------------------------------------------------
nnoremap <buffer> <silent> <M-g> :call JumpToComment('n', '', '#-')<CR>
nnoremap <buffer> <silent> <M-G> :call JumpToComment('n', 'b', '#-')<CR>
inoremap <buffer> <silent> <M-g> <ESC>:call JumpToComment('i', '', '#-')<CR>
inoremap <buffer> <silent> <M-G> <ESC>:call JumpToComment('i', 'b', '#-')<CR>
