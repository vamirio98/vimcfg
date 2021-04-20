"=======================================================
" indent.vim - configure indent
"
" Created by Haoyuan Li on 2021/02/15
" Last Modified: 2021/04/20 10:42:31
"=======================================================


"-------------------------------------------------------
" round indent to multiple of 'shiftwidth'
" (default 8, length of a tab)
"-------------------------------------------------------
set shiftround


"=======================================================
" Vim
"=======================================================
augroup Vim
	autocmd!
	autocmd FileType vim setlocal shiftwidth=4
	autocmd FileType vim setlocal tabstop=4
	autocmd FileType vim setlocal softtabstop=4


"=======================================================
" json
"=======================================================
augroup json
	autocmd!
	autocmd FileType json setlocal shiftwidth=4
	autocmd FileType json setlocal tabstop=4
	autocmd FileType json setlocal softtabstop=4
augroup END

"=======================================================
" html
"=======================================================
augroup html
	autocmd!
	" set indent
	autocmd FileType html setlocal shiftwidth=4
	autocmd FileType html setlocal tabstop=4
	autocmd FileType html setlocal softtabstop=4
augroup END
