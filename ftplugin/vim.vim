" vim.vim
" Author: vamirio

let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", "`":"`", '```':'```',
			\ '"""':'"""', "'''":"'''"}

if line('$') == 1 && getline(1) == ''
	call base#addFileHead('"', 1)
endif
