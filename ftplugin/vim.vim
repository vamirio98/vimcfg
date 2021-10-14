"-------------------------------------------------------
" vim.vim -
" 
" Created by Vamirio on 2021 Oct 14
" Last Modified: 2021 Oct 14 11:09:55
"-------------------------------------------------------

let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", "`":"`", '```':'```',
			\ '"""':'"""', "'''":"'''"}


"-------------------------------------------------------
" add file head
"-------------------------------------------------------
function! s:AddFileHead()
	call setline(1, '"-------------------------------------------------------')
	call setline(2, '" ' . expand("%:t") . ' -')
	call setline(3, '" ')
	call setline(4, '" Created by Vamirio on ' . strftime("%Y %b %d"))
	call setline(5, '" Last Modified: ' . strftime("%Y %b %d %T"))
	call setline(6, '"-------------------------------------------------------')
	execute "normal! j"
	execute "startinsert!"
endfunction

if line('$') == 1
	call s:AddFileHead()
endif

"-------------------------------------------------------
" add comment
"-------------------------------------------------------
nnoremap <buffer> <M-c> :call AddComment('n')<CR>
" insert i before entering normal mode to avoid plugin lessspace delete indent
inoremap <buffer> <M-c> i<ESC>:call AddComment('i')<CR>

function! AddComment(mode)
	let l:cur_indent = indent('.')
	let l:str = ""
	while l:cur_indent > 0
		let l:str = l:str . " "
		let l:cur_indent -= 1
	endwhile
	let l:title = [l:str . "\"-------------------------------------------------------",
				\ l:str . "\"",
				\ l:str . "\"-------------------------------------------------------"]
	if a:mode == 'n'	   " normal mode
		call append(line('.'), l:title)
		execute "normal! 2j"
		execute "startinsert!"
	elseif a:mode == 'i'   " insert mode
		call setline(line('.'), l:title[0])
		call append(line('.'), l:title[1:-1])
		execute "normal! j"
		execute "startinsert!"
	endif
endfunction

augroup VIM
	autocmd!
	autocmd BufWritePre,FileWritePre *.vim call base#ModifyTime('"-', '"-')
augroup END


"-------------------------------------------------------
" jump out comments
"-------------------------------------------------------
nnoremap <buffer> <silent> <M-g> :call base#JumpToComment('n', '', '"-')<CR>
nnoremap <buffer> <silent> <M-G> :call base#JumpToComment('n', 'b', '"-')<CR>
inoremap <buffer> <silent> <M-g> <ESC>:call base#JumpToComment('i', '', '"-')<CR>
inoremap <buffer> <silent> <M-G> <ESC>:call base#JumpToComment('i', 'b', '"-')<CR>
