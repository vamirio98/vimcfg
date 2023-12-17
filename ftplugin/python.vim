vim9script
# python.vim
# Author: vamirio

if line('$') == 1 && getline(1) == ''
	setline(1, '#!/usr/bin/env python3')
	setline(2, '# -*- coding: utf-8 -*-')
	setline(3, '')
	execute ':3'
	execute 'startinsert!'
endif
