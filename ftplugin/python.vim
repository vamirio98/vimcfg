vim9script
# python.vim
# Author: vamirio

import autoload 'base.vim' as base

if line('$') == 1 && getline(1) == ''
	setline(1, '#!/usr/bin/env python3')
	setline(2, '# -*- coding: utf-8 -*-')
	setline(3, '')
	base.AddFileHead('#', 4)
endif
