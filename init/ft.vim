"=======================================================
"
" ft.vim - config for specified file type
"
" Created by hyl on 2021/02/15
" Last Modified: 2021/02/17 11:09:19
"
"=======================================================


"=======================================================
" auto add title when create a new file
"=======================================================
let s:ft = ['*.vim', '*.c{,c,pp}', '*.sh']
execute "autocmd BufNewFile " . join(s:ft, ",") . " call CreateOn()"

function CreateOn()
	let l:ft = fnamemodify(bufname("%"), ":e")
	if l:ft == "vim"
		call CreateVimFile()
	elseif l:ft == "c" || l:ft == "cpp" || l:ft == "cc"
		call CreateCFile()
	elseif l:ft == "sh"
		call CreateShellFile()
	endif
endfunction

"-------------------------------------------------------
" Vim file
"-------------------------------------------------------
function! CreateVimFile()
	call setline(1, "\"=======================================================")
	call setline(2, "\" " . expand("%t") . " -")
	call setline(3, "\" ")
	call setline(4, "\" Created by hyl on " . strftime("%Y/%m/%d"))
	call setline(5, "\" Last Modified: " . strftime("%Y/%m/%d %T"))
	call setline(6, "\"=======================================================")
	execute "normal! jA"
endfunction

"-------------------------------------------------------
" C-family file
"-------------------------------------------------------
function! CreateCFile()
	call setline(1, "/*=======================================================")
	call setline(2, " * " . expand("%t") . " -")
	call setline(3, " *")
	call setline(4, " * Created by hyl on " . strftime("%Y/%m/%d"))
	call setline(5, " * Last Modified: " . strftime("%Y/%m/%d %T"))
	call setline(6, " *=======================================================")
	call setline(7, " */")
	execute "normal! jA"
endfunction

"-------------------------------------------------------
" shell script file
"-------------------------------------------------------
function! CreateShellFile()
	call setline(1, "#!/bin/bash")
	call setline(2, "")
	call setline(3, "#=======================================================")
	call setline(4, "# " . expand("%t") . " -")
	call setline(5, "#")
	call setline(6, "# Created by hyl on " . strftime("%Y/%m/%d"))
	call setline(7, "# Last Modified: " . strftime("%Y/%m/%d %T"))
	call setline(8, "#=======================================================")
	execute "normal! 3jA"
endfunction


"-------------------------------------------------------
" auto set Last Modified time
"-------------------------------------------------------
execute "autocmd BufWritePre,FileWritePre " . join(s:ft, ",") .
	\ " ks | call LastModified() | 's"
function! LastModified()
	if line("$") > 20
		let l:nl = 20
	else
		let l:nl = line("$")
	endif
	execute "1," . l:nl . "g/Last Modified:/s/Last Modified:.*/Last " .
		\ "Modified: " . strftime("%Y\\/%m\\/%d %T")
endfunction


"=======================================================
" Vim
"=======================================================
augroup Vim
	autocmd!
	" comment title
	autocmd BufEnter *.vim nnoremap <M-S-c>
		\ o"=======================================================
		\<CR><CR>
		\=======================================================
		\<ESC>ka<space>
	autocmd BufEnter *.vim inoremap <M-S-c>
		\ "=======================================================
		\<CR><CR>
		\=======================================================
		\<ESC>ka<space>

	" comment subtitle
	autocmd BufEnter *.vim nnoremap <M-c>
		\ o"-------------------------------------------------------
		\<CR><CR>
		\-------------------------------------------------------
		\<ESC>ka<space>
	autocmd BufEnter *.vim inoremap <M-c>
		\ "-------------------------------------------------------
		\<CR><CR>
		\-------------------------------------------------------
		\<ESC>ka<space>
augroup END


"=======================================================
" C-family
"=======================================================
augroup cfamily
	autocmd!
	" quickly comment single line
	autocmd FileType c{,c,pp} nnoremap <buffer> <localleader>/ I//<ESC>

	" snippets for C/C++
	autocmd FileType c{,c,pp} iabbrev <buffer> reutrn return
	autocmd FileType c{,c,pp} iabbrev <buffer> incldue include
	autocmd FileType c{,c,pp} iabbrev <buffer> inculde include
augroup END


"=======================================================
" json
"=======================================================
augroup json
	autocmd!
	" get correct comment highlighting
	autocmd FileType json syntax match Comment +\/\.\+$+
augroup END
