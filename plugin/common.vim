"=======================================================
" common.vim - some common functions
" 
" Created by Haoyuan Li on 2021/07/05
" Last Modified: 2021/07/12 09:25:13
"=======================================================


"-------------------------------------------------------
" jump to comment
"-------------------------------------------------------
function! JumpToComment(mode, dir, id)
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
