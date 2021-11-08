"-
" terminal.vim - Terminal key extension config
"
" Configure Alt and Backspace
"
" Created by Vamirio on 2021 Nov 08
" Last Modified: 2021 Nov 08 16:52:31
"-

function! Terminal_MetaMode(mode)
	set ttimeout
	if $TMUX != ''
		set ttimeoutlen=30
	elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
		set ttimeoutlen=80
	endif
	if has('nvim') || has('gui_running')
		return
	endif
	function! s:metacode(mode, key)
		if a:mode == 0
			execute "set <M-" . a:key . ">=\e" . a:key
		else
			execute "set <M-" . a:key . ">\e]{0}" . a:key . "~"
		endif
	endfunction
	for i in range(10)
		call s:metacode(a:mode, nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		call s:metacode(a:mode, nr2char(char2nr('a') + i))
		call s:metacode(a:mode, nr2char(char2nr('A') + i))
	endfor
	if a:mode != 0
		for c in [',', '.', '/', ';', '[', ']', '{', '}']
			call s:metacode(a:mode, c)
		endfor
		for c in ['?', ':', '-', '_']
			call s:metacode(a:mode, c)
		endfor
	else
		for c in [',', '.', '/', ';', '{', '}']
			call s:metacode(a:mode, c)
		endfor
		for c in ['?', ':', '-', '_']
			call s:metacode(a:mode, c)
		endfor
	endif
endfunction

call Terminal_MetaMode(0)
