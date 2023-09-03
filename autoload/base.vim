" base.vim - Some base function.
" Author: vamirio

"-
" Add file header.
"-
function! g:base#addFileHead(commentSymbol, line)
	call setline(a:line, a:commentSymbol . ' ' . expand('%t'))
	call append(a:line, a:commentSymbol . ' Author: vamirio')
	call cursor(a:line, 1000)
	execute "startinsert!"
endfunction
