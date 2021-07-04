"=======================================================
"
" ft.vim - config for specified file type
"
" Created by Haoyuan Li on 2021/02/15
" Last Modified: 2021/07/04 16:46:15
"
"=======================================================

let s:ft = [ "*.c{c,pp}", "*.sh", "*.vim" ]
"-------------------------------------------------------
" auto set Last Modified time
"-------------------------------------------------------
execute "autocmd BufWritePre,FileWritePre " . join(s:ft, ",") .
	\ " call s:ModifyTime()"
function! s:ModifyTime()
	let l:cur_pos = getcurpos()
	call LastModified()
	call cursor(l:cur_pos[1], l:cur_pos[2])
endfunction


function! LastModified()
	if line("$") > 10
		let l:nl = 10
	else
		let l:nl = line("$")
	endif
	execute "1," . l:nl . "g/Last Modified:/s/Last Modified:.*/Last " .
		\ "Modified: " . strftime("%Y\\/%m\\/%d %T")
endfunction
