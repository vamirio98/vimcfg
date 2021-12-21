"-
" vim.vim
" 
" Created by Vamirio on 2021 Oct 14
" Last Modified: 2021 Dec 21 12:12:22
"-

let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", "`":"`", '```':'```',
			\ '"""':'"""', "'''":"'''"}

if line('$') == 1 && getline(1) == ''
	call base#AddFileHead('"-', '"', '"-', 1)
endif

"-
" Add comment.
"-
nnoremap <silent><buffer> <M-c>
			\ :call base#AddComment('n', ['"-', '" ', '"-'])<CR>
inoremap <silent><buffer> <M-c>
			\ <ESC>:call base#AddComment('i', ['"-', '" ', '"-'])<CR>

augroup MyVim
	au!
	au BufEnter *.vim call base#SetBufChangedFlag(0)
	au BufWritePre,FileWritePre *.vim call base#SetBufChangedFlag(1)
	au BufLeave,BufUnload *.vim call base#UpdateLastModifiedAndSave('"-', '"-')
augroup END

"-
" Jump out comments.
"-
nnoremap <silent><buffer> <M-g>
			\ :call base#JumpToComment('n', '', '"-')<CR>
nnoremap <silent><buffer> <M-G>
			\ :call base#JumpToComment('n', 'b', '"-')<CR>
inoremap <silent><buffer> <M-g>
			\ <ESC>:call base#JumpToComment('i', '', '"-')<CR>
inoremap <silent><buffer> <M-G>
			\ <ESC>:call base#JumpToComment('i', 'b',-'"-')<CR>
