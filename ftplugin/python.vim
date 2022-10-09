vim9script
#-
# python.vim
#
# Created by vamirio on 2021 Nov 08
#-

import autoload 'base.vim' as base

if line('$') == 1 && getline(1) == ''
	setline(1, '#!/usr/bin/env python3')
	setline(2, '# -*- coding: utf-8 -*-')
	base.AddFileHead('#-', '#', '#-', 3)
endif

#-
# Jump out comments.
#-
nnoremap <buffer> <M-g>
		\ <ScriptCmd>base.JumpOutComment('n', '', '#-')<CR>
nnoremap <buffer> <M-G>
		\ <ScriptCmd>base.JumpOutComment('n', 'b', '#-')<CR>
inoremap <buffer> <M-g>
		\ <ScriptCmd>base.JumpOutComment('i', '', '#-')<CR>
inoremap <buffer> <M-G>
		\ <ScriptCmd>base.JumpOutComment('i', 'b', '#-')<CR>
