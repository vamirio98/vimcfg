vim9script
# vim.vim
# Author: vamirio

import autoload 'base.vim' as base

if line('$') == 1 && getline(1) == ''
	setline(1, 'vim9script')
	setline(2, '')
	base.AddFileHead('#', 3)
endif
