setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal expandtab

if line('$') == 1 && getline(1) == ''
	call setline(1, '#!/usr/bin/env python3')
	call setline(2, '# -*- coding: utf-8 -*-')
	call setline(3, '')

	execute 'normal G'
	execute 'startinsert!'
endif
