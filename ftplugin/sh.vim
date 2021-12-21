"-
" sh.vim
" 
" Created by Vamirio on 2021 Oct 14
" Last Modified: 2021 Dec 21 12:12:07
"-

if line('$') == 1 && getline(1) == ''
	call setline(1, "#!/bin/bash")
	call append(1, "")
	call base#AddFileHead('#-', '#', '#-', 3)
endif

augroup MyShell
	au!
	au BufEnter *.sh call base#SetBufChangedFlag(0)
	au BufWritePre,FileWritePre *.sh call base#SetBufChangedFlag(1)
	au BufLeave,BufUnload *.sh call base#UpdateLastModifiedAndSave('#-', '#-')
augroup END

"-
" Jump out comments.
"-
nnoremap <silent><buffer> <M-g>
			\ :call base#JumpToComment('n', '', '#-')<CR>
nnoremap <silent><buffer> <M-G>
			\ :call base#JumpToComment('n', 'b', '#-')<CR>
inoremap <silent><buffer> <M-g>
			\ <ESC>:call base#JumpToComment('i', '', '#-')<CR>
inoremap <silent><buffer> <M-G>
			\ <ESC>:call base#JumpToComment('i', 'b', '#-')<CR>
