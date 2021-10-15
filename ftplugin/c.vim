"-------------------------------------------------------
" c.vim -
" 
" Created by Vamirio on 2021 Oct 14
" Last Modified: 2021 Oct 15 09:18:28
"-------------------------------------------------------

" quickly comment single line
nnoremap <buffer> <localleader>/ I//<ESC>

" snippets for C/C++
iabbrev <buffer> reutrn return
iabbrev <buffer> incldue include
iabbrev <buffer> inculde include


if line('$') == 1
	call base#AddFileHead('/**', ' *', ' */', 1)
endif

"-------------------------------------------------------
" add comment
"-------------------------------------------------------
nnoremap <buffer> <silent> <M-c> :call AddComment('n')<CR>
" insert i before entering normal mode to avoid plugin lessspace delete indent
inoremap <buffer> <silent> <M-c> i<ESC>:call AddComment('i')<CR>

function! AddComment(mode)
	let l:cur_indent = indent('.')
	let l:str = ''
	while l:cur_indent > 0
		let l:str = l:str . ' '
		let l:cur_indent -= 1
	endwhile
	let l:title = [l:str . '/**',
				\ l:str . ' *',
				\ l:str . ' */']
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

augroup C
	autocmd!
	autocmd BufWritePre,FileWritePre *.c{,c,pp},*h{,pp} call base#ModifyTime('/*', '*/')
augroup END


"-------------------------------------------------------
" jump to comments
"-------------------------------------------------------
nnoremap <buffer> <silent> <M-g> :call base#JumpToComment('n', '', '\(\/\*\\|\*\/\)')<CR>
nnoremap <buffer> <silent> <M-G> :call base#JumpToComment('n', 'b', '\(\/\*\\|\*\/\)')<CR>
inoremap <buffer> <silent> <M-g> <ESC>:call base#JumpToComment('i', '', '\(\/\*\\|\*\/\)')<CR>
inoremap <buffer> <silent> <M-G> <ESC>:call base#JumpToComment('i', 'b', '\(\/\*\\|\*\/\)')<CR>
