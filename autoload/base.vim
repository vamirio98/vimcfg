"-
" base.vim - some base function
" 
" Created by vamirio on 2021 Oct 14
"-

"-
" Add file header.
"-
function! g:base#add_file_head(head, suffix, tail, line)
	call setline(a:line, a:head)
	call cursor(a:line, 0)
	call append(a:line, a:suffix . ' ' . expand("%:t"))
	call append(a:line + 1, a:suffix)
	call append(a:line + 2, a:suffix .
				\ ' Created by vamirio on ' . strftime("%Y %b %d"))
	call append(a:line + 3, a:tail)
	execute "normal! j"
	execute "startinsert!"
endfunction

"-
" Jump to comment.
"-
function! g:base#jump_out_comment(mode, dir, id)
	let cur_pos = getcurpos()[1 : 2]
	call cursor(cur_pos[0], a:dir ==# '' ? 1000 : 1)
	let next_line = search(a:id, a:dir . 'cn')
	if next_line == 0 ||
			\ (a:dir ==# '' && cur_pos[0] > next_line) ||
			\ (a:dir ==# 'b' && cur_pos[0] < next_line)
		call cursor(cur_pos)
		call s:RestoreMode(a:mode)
		return
	endif

	call cursor(next_line, 1000)
	call s:RestoreMode(a:mode)
endfunction

function! s:RestoreMode(mode)
	if a:mode ==? 'i'
		startinsert!
	endif
endfunction
