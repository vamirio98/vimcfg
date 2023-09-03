" python.vim
" Author: vamirio

if line('$') == 1 && getline(1) == ''
	call setline(1, '#!/usr/bin/env python3')
	call setline(2, '# -*- coding: utf-8 -*-')
	call setline(3, '')
	call base#addFileHead('#', 4)
endif
