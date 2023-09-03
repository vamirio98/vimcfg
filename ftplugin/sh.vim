" sh.vim
" Author: vamirio

if line('$') == 1 && getline(1) == ''
	call setline(1, '#!/bin/bash')
	call setline(2, '')
	call base#addFileHead('#', 3)
endif
