vim9script
#-
# vim.vim
#
# Created by vamirio on 2021 Oct 14
#-

import autoload 'base.vim' as base

if line('$') == 1 && getline(1) == ''
	setline(1, 'vim9script')
	base.AddFileHead('#-', '#', '#-', 2)
endif

#-
# Jump out comments.
#-
nnoremap <silent><buffer> <M-g>
		\ <ScriptCmd>base.JumpOutComment('n', '', '#-')<CR>
nnoremap <silent><buffer> <M-G>
		\ <ScriptCmd>base.JumpOutComment('n', 'b', '#-')<CR>
inoremap <silent><buffer> <M-g>
		\ <ScriptCmd>base.JumpOutComment('i', '', '#-')<CR>
inoremap <silent><buffer> <M-G>
		\ <ScriptCmd>base.JumpOutComment('i', 'b', '#-')<CR>
