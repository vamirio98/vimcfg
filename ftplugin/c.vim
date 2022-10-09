vim9script
#-
# c.vim
#
# Created by vamirio on 2021 Oct 14
#-

import autoload 'base.vim' as base

# Quickly comment single line.
nnoremap <buffer> <localleader>/ I//<ESC>

# Abbreviation for C/C++.
iabbrev <buffer> reutrn return
iabbrev <buffer> incldue include
iabbrev <buffer> inculde include

# Add file head.
if line('$') == 1 && getline(1) == ''
	base.AddFileHead('/**', ' *', ' */', 1)
endif

# Jump to comments.
nnoremap <buffer> <M-g>
		\ <ScriptCmd>base.JumpOutComment('n', '', '/*\|*/')<CR>
nnoremap <buffer> <M-G>
		\ <ScriptCmd>base.JumpOutComment('n', 'b', '/*\|*/')<CR>
inoremap <buffer> <M-g>
		\ <ScriptCmd>base.JumpOutComment('i', '', '/*\|*/')<CR>
inoremap <buffer> <M-G>
		\ <ScriptCmd>base.JumpOutComment('i', 'b', '/*\|*/')<CR>
