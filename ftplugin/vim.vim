vim9script
#-
# vim.vim
#
# Created by vamirio on 2021 Oct 14
#-

import autoload 'base.vim' as base

if line('$') == 1 && getline(1) == ''
	setline(1, 'vim9script')
	setline(2, '')
	base.AddFileHead('#', 3)
endif
