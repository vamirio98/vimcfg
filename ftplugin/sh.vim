"=======================================================
" sh.vim -
" 
" Created by Haoyuan Li on 2021/07/04
" Last Modified: 2021/07/04 16:39:33
"=======================================================

"-------------------------------------------------------
" add file head
"-------------------------------------------------------
function! s:AddFileHead()
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

if line('$') == 1
        call s:AddFileHead()
endif
