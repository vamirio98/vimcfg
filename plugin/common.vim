"=======================================================
" common.vim - some common functions
" 
" Created by Haoyuan Li on 2021/07/05
" Last Modified: 2021/07/05 16:30:35
"=======================================================


"-------------------------------------------------------
" jump to comment titles
"-------------------------------------------------------
function! JumpToCommentTitle(mode, dir, id)
    let l:cur_pos = getcurpos()[1]
    let l:next_pos = search(a:id, a:dir . 'cn')
    echom l:next_pos
    if l:next_pos == 0
        return
    endif

    if a:dir ==# 'b' && l:cur_pos < l:next_pos
        return
    elseif a:dir ==# '' && l:cur_pos > l:next_pos
        return
    endif

    call cursor(l:next_pos, 0)
    if a:dir ==# 'b'
        let l:op = 'k'
    elseif a:dir ==# ''
        let l:op = 'j'
    endif
    execute "normal! " . l:op
    if a:mode ==? 'i'
        startinsert!
    endif
endfunction
