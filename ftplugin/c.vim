"-
" c.vim
" 
" Created by Vamirio on 2021 Oct 14
" Last Modified: 2021 Nov 08 16:48:37
"-

" quickly comment single line
nnoremap <buffer> <localleader>/ I//<ESC>

" abbreviation for C/C++
iabbrev <buffer> reutrn return
iabbrev <buffer> incldue include
iabbrev <buffer> inculde include


"-
" add comment
"-
nnoremap <buffer> <silent> <M-c> :call base#AddComment('n',
			\ ['/**', ' * ', ' */'])<CR>
inoremap <buffer> <silent> <M-c> <ESC>:call base#AddComment('i',
			\ ['/**', ' * ', ' */'])<CR>


" add file head
if line('$') == 1 && getline(1) == ''
	call base#AddFileHead('/**', ' *', ' */', 1)
endif


augroup C
	autocmd!
	autocmd BufWritePre,FileWritePre *.c{,c,pp},*.h{,pp} call base#ModifyTime('/*', '*/')
augroup END


"-
" jump to comments
"-
nnoremap <buffer> <silent> <M-g> :call base#JumpToComment('n', '', '\(\/\*\\|\*\/\)')<CR>
nnoremap <buffer> <silent> <M-G> :call base#JumpToComment('n', 'b', '\(\/\*\\|\*\/\)')<CR>
inoremap <buffer> <silent> <M-g> <ESC>:call base#JumpToComment('i', '', '\(\/\*\\|\*\/\)')<CR>
inoremap <buffer> <silent> <M-G> <ESC>:call base#JumpToComment('i', 'b', '\(\/\*\\|\*\/\)')<CR>
