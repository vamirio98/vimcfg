vim9script
# sh.vim
# Author: vamirio

import autoload 'base.vim' as base

if line('$') == 1 && getline(1) == ''
	setline(1, '#!/bin/bash')
	setline(2, '')
	base.AddFileHead('#', 3)
endif
