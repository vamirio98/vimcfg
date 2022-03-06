"-
" base.vim - some base function
" 
" Created by vamirio on 2021 Oct 14
" Last Modified: 2022 Mar 06 21:55:05
"-

"-
" Auto modify the Last Modified Time.
"-
function! s:ModifyTime(prefix, suffix)
	let l:curr_pos = getcurpos()
	call cursor(1, 1)
	let l:prefix_pos = searchpos(a:prefix, 'c')
	let l:suffix_pos = searchpos(a:suffix, 'n')
	let l:time_pos = search('Last Modified:')
	if l:prefix_pos[0] < 5 && l:time_pos < l:suffix_pos[0]
		execute l:prefix_pos[0] . "," . l:time_pos
					\ . "g/Last Modified:/s/Last Modified:.*/"
					\ . "Last Modified: " . b:last_modified_time_str
	endif
	call cursor(l:curr_pos[1], l:curr_pos[2])
endfunction

"-
" Set Last Modified Time string.
"-
function! g:base#SetLastModifiedTimeStr()
	let b:last_modified_time_str = strftime("%Y %b %d %T")
endfunction

"-
" Set the buffer changed flag.
"-
function! g:base#SetBufChangedFlag(flag)
	let b:buf_changed = a:flag
endfunction

"-
"  Modify the Last Modify time and save file.
"-
function! g:base#UpdateLastModifiedAndSave(prefix, suffix)
	if !b:buf_changed
		return
	endif
	call s:ModifyTime(a:prefix, a:suffix)
	update
	let b:buf_changed = 0
endfunction

"-
" Add file header.
"-
function! g:base#AddFileHead(head, suffix, tail, line)
	call setline(a:line, a:head)
	call cursor(a:line, 0)
	call append(a:line, a:suffix . ' ' . expand("%:t"))
	call append(a:line + 1, a:suffix)
	call append(a:line + 2, a:suffix . ' Created by vamirio on ' . strftime("%Y %b %d"))
	call append(a:line + 3, a:suffix . ' Last Modified: ' . strftime("%Y %b %d %T"))
	call append(a:line + 4, a:tail)
	execute "normal! j"
	execute "startinsert!"
endfunction

"-
" Jump to comment.
"-
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

function! base#AddComment(mode, comment_mark)
	let l:cur_indent = indent('.')
	let l:str = ''

	let l:count = l:cur_indent / &tabstop
	while l:count > 0
		let l:str = l:str . "\t"
		let l:count -= 1
	endwhile
	let l:count = l:cur_indent % &tabstop
	while l:count > 0
		let l:str = l:str . " "
		let l:count -= 1
	endwhile

	let l:comment = [l:str . a:comment_mark[0],
				\ l:str . a:comment_mark[1],
				\ l:str . a:comment_mark[2]]
	if a:mode == 'n'      " normal mode
		call append(line('.'), l:comment)
		execute "normal! 2j"
	elseif a:mode == 'i'  " insert mode
		call setline(line('.'), l:comment[0])
		call append(line('.'), l:comment[1:-1])
		execute "normal! j"
	endif
	execute "startinsert!"
endfunction
