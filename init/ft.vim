"=======================================================
"
" ft.vim - config for specified file type
"
" Created by hyl on 2021/02/15
" Last Modified: 2021/03/17 12:56:07
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
	execute "normal! j"
	execute "startinsert!"
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
	execute "normal! j"
	execute "startinsert!"
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
	execute "normal! 3j"
	execute "startinsert!"
endfunction


"-------------------------------------------------------
" auto set Last Modified time
"-------------------------------------------------------
execute "autocmd BufWritePre,FileWritePre " . join(s:ft, ",") .
	\ " call s:ReturnToCurPos()"
function! s:ReturnToCurPos()
	let l:cur_pos = getcurpos('.')
	call LastModified()
	call cursor(l:cur_pos[1], l:cur_pos[2])
endfunction


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
	autocmd BufEnter *.vim let b:AutoPairs = {'(':')', '[':']', '{':'}',
		\ "'":"'", "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
	" comment title
	autocmd BufEnter *.vim nnoremap <buffer> <M-C> :call
		\ AddVimCommentTitle('n')<CR>
	autocmd BufEnter *.vim inoremap <buffer> <M-C> <ESC>:call
		\ AddVimCommentTitle('i')<CR>

	" comment subtitle
	autocmd BufEnter *.vim nnoremap <buffer> <M-c> :call
		\ AddVimCommentSubtitle('n')<CR>
	autocmd BufEnter *.vim inoremap <buffer> <M-c> <ESC>:call
		\ AddVimCommentSubtitle('i')<CR>
augroup END

function! s:GetIndent()
	let l:cur_indent = indent('.')
	let l:n_tab = l:cur_indent / &tabstop
	let l:n_space = l:cur_indent % &tabstop

	let l:str = ""
	while l:n_tab > 0
		let l:str = l:str . "\t"
		let l:n_tab -= 1
	endwhile
	while l:n_space > 0
		let l:str = l:str . " "
		let l:n_space -= 1
	endwhile
	return l:str
endfunction


function! AddVimCommentTitle(mode)
	let l:str = s:GetIndent()
	let l:title = [l:str . "\"=======================================================",
		\ l:str . "\"",
		\ l:str . "\"======================================================="]
	if a:mode == 'n'       " normal mode
		call append(line('.'), l:title)
		execute "normal! 2j"
		execute "startinsert!"
	elseif a:mode == 'i'   " insert mode
		call append(line('.')-1, l:title)
		execute "normal! 2k"
		execute "startinsert!"
	endif
endfunction

function! AddVimCommentSubtitle(mode)
	let l:str = s:GetIndent()
	let l:title = [l:str . "\"-------------------------------------------------------",
		\ l:str . "\"",
		\ l:str . "\"-------------------------------------------------------"]
	if a:mode == 'n'       " normal mode
		call append(line('.'), l:title)
		execute "normal! 2j"
		execute "startinsert!"
	elseif a:mode == 'i'   " insert mode
		call append(line('.')-1, l:title)
		execute "normal! 2k"
		execute "startinsert!"
	endif
endfunction


"=======================================================
" C-family
"=======================================================
augroup cfamily
	autocmd!
	" comment subtitle
	autocmd FileType c{,c,pp} nnoremap <buffer> <M-c> :call
		\ AddCCommentSubtitle('n')<CR>
	autocmd FileType c{,c,pp} inoremap <buffer> <M-c> <ESC>:call
		\ AddCCommentSubtitle('i')<CR>
	" quickly comment single line
	autocmd FileType c{,c,pp} nnoremap <buffer> <localleader>/ I//<ESC>

	" snippets for C/C++
	autocmd FileType c{,c,pp} iabbrev <buffer> reutrn return
	autocmd FileType c{,c,pp} iabbrev <buffer> incldue include
	autocmd FileType c{,c,pp} iabbrev <buffer> inculde include
augroup END

function! AddCCommentSubtitle(mode)
	let l:str = s:GetIndent()
	let l:title = [l:str . "/*-------------------------------------------------------",
		\ l:str . " *",
		\ l:str . " *-------------------------------------------------------",
		\ l:str . " */"]
	if a:mode == 'n'       " normal mode
		call append(line('.'), l:title)
		execute "normal! 2j"
		execute "startinsert!"
	elseif a:mode == 'i'   " insert mode
		call append(line('.')-1, l:title)
		execute "normal! 3k"
		execute "startinsert!"
	endif
endfunction


"=======================================================
" json
"=======================================================
augroup json
	autocmd!
	" get correct comment highlighting
	autocmd FileType json syntax match Comment +\/\.\+$+
augroup END
