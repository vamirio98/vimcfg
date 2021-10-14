"-------------------------------------------------------
" base.vim - some base function
" 
" Created by Vamirio on 2021 Oct 14
" Last Modified: 2021 Oct 14 11:07:20
"-------------------------------------------------------

"-------------------------------------------------------
" auto modify the Last Modified Time
"-------------------------------------------------------
function! g:base#ModifyTime(prefix, suffix)
	let l:cur_pos = getcurpos()
	call cursor(1, 1)
	let l:b = searchpos(a:prefix, 'c')
	let l:e = searchpos(a:suffix, 'n')
	let l:t = search('Last Modified:')
	if l:b[0] < 5 && l:t < l:e[0]
		echom "ha"
		execute l:b[0] . "," . l:t . "g/Last Modified:/s/Last Modified:.*/"
					\ . "Last Modified: " . strftime("%Y %b %d %T")
	endif
	call cursor(l:cur_pos[1], l:cur_pos[2])
endfunction

"-------------------------------------------------------
" jump to comment
"-------------------------------------------------------
function! g:base#JumpToComment(mode, dir, id)
    let l:cur_pos = getcurpos()[1]
    let l:next_pos = search(a:id, a:dir . 'cn')
    if l:next_pos == 0
        call s:RestoreMode(a:mode)
        return
    endif

    if (a:dir ==# '' && l:cur_pos > l:next_pos) ||
                \ (a:dir ==# 'b' && l:cur_pos < l:next_pos)
        call s:RestoreMode(a:mode)
        return
    endif

    call cursor(l:next_pos, 0)
    if a:dir ==# 'b'
        let l:op = 'k'
    elseif a:dir ==# ''
        let l:op = 'j'
    endif
    execute "normal! " . l:op
    call s:RestoreMode(a:mode)
endfunction

function! s:RestoreMode(mode)
    if a:mode ==? 'i'
        startinsert!
    endif
endfunction
