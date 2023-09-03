" extended.vim - Extended config.
" Author: vamirio

if $TMUX != ''
	set ttimeoutlen=30
elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
	set ttimeoutlen=80
endif

" Use ALT in terminal, should set ttimeout (in basic.vim) and ttimeoutlen at
" first.
" Refer: http://www.skywind.me/blog/archives/2021
if has('nvim') == 0 && has('gui_running') == 0
	function! s:metacode(key)
		execute "set <M-" . a:key . ">=\e" . a:key
	endfunction
	for i in range(10)
		call s:metacode(nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		call s:metacode(nr2char(char2nr('a') + i))
		call s:metacode(nr2char(char2nr('A') + i))
	endfor
	for c in [',', '.', '/', ';', '{', '}']
		call s:metacode(c)
	endfor
	for c in ['?', ':', '-', '_', '+', '=', "'"]
		call s:metacode(c)
	endfor
endif

" Use function key in terminal.
function! s:SetFunctionKey(name, code)
	execute "set " . a:name . "=\e" . a:code
endfunction
if has('nvim') == 0 && has('gui_running') == 0
	call s:SetFunctionKey('<F1>', 'OP')
	call s:SetFunctionKey('<F2>', 'OQ')
	call s:SetFunctionKey('<F3>', 'OR')
	call s:SetFunctionKey('<F4>', 'OS')
	call s:SetFunctionKey('<S-F1>', '[1;2P')
	call s:SetFunctionKey('<S-F2>', '[1;2Q')
	call s:SetFunctionKey('<S-F3>', '[1;2R')
	call s:SetFunctionKey('<S-F4>', '[1;2S')
	call s:SetFunctionKey('<S-F5>', '[15;2~')
	call s:SetFunctionKey('<S-F6>', '[17;2~')
	call s:SetFunctionKey('<S-F7>', '[18;2~')
	call s:SetFunctionKey('<S-F8>', '[19;2~')
	call s:SetFunctionKey('<S-F9>', '[20;2~')
	call s:SetFunctionKey('<S-F10>', '[21;2~')
	call s:SetFunctionKey('<S-F11>', '[23;2~')
	call s:SetFunctionKey('<S-F12>', '[24;2~')
endif

" Prevent the backgroud color of Vim in tmux from displaying abnormally.
" Refer: http://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color' && $TMUX != ''
	" Disable background color erase (BCE) so that color schemes render
	" properly when inside 256-color tmux and GNU screen.
	set t_ut=
endif

" Disable swap file.
set noswapfile
" Disable undofile.
set noundofile

function s:ReturnLastPos()
	let lastPos = [line("'\""), col("'\"")]
	if lastPos[0] > 1 && lastPos[1] <= line("$") && &ft !~# 'commit'
		call cursor(lastPos)
	endif
endfunction

" Jump to the last position when reopening a file and auto load change.
set autoread
augroup MyExtendedGroup
	au!
	au BufReadPost * call s:ReturnLastPos()
	" Trigger autoread when cursor stop moving, buffer change or terminal focus.
	au CursorHold,CursorHoldI,BufEnter,FocusGained *
			\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
			\ | checktime | endif
	" Notification after file change
	au FileChangedShellPost * echohl WarningMsg
			\ | echo "File changed on disk. Buffer reloaded."
			\ | echohl None
augroup END
