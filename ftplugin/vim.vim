"-
" vim.vim
" 
" Created by Vamirio on 2021 Oct 14
" Last Modified: 2021 Nov 08 16:49:29
"-

let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", "`":"`", '```':'```',
			\ '"""':'"""', "'''":"'''"}


if line('$') == 1 && getline(1) == ''
	call base#AddFileHead('"-', '"', '"-', 1)
endif

"-
" add comment
"-
nnoremap <buffer> <M-c> :call base#AddComment('n', ['"-', '" ', '"-'])<CR>
inoremap <buffer> <M-c> <ESC>:call base#AddComment('i', ['"-', '" ', '"-'])<CR>

augroup VIM
	autocmd!
	autocmd BufWritePre,FileWritePre *.vim call base#ModifyTime('"-', '"-')
augroup END


"-
" jump out comments
"-
nnoremap <buffer> <silent> <M-g> :call base#JumpToComment('n', '', '"-')<CR>
nnoremap <buffer> <silent> <M-G> :call base#JumpToComment('n', 'b', '"-')<CR>
inoremap <buffer> <silent> <M-g> <ESC>:call base#JumpToComment('i', '', '"-')<CR>
inoremap <buffer> <silent> <M-G> <ESC>:call base#JumpToComment('i', 'b',-'"-')<CR>
