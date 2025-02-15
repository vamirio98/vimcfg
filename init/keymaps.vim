" set <leader> key.
let g:mapleader = ' '
let g:maplocalleader = '\'

" Set Alt and function key in terminal.

" Disable ALT on GUI, make it can be used for mapping.
set winaltkeys=no

" Turn on function key timeout detection (the function key in the
" terminal is a charset starts with ESC).
set ttimeout

" Function key timeout detection: 50ms.
set ttimeoutlen=50

if $TMUX != ''
	set ttimeoutlen=30
elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
	set ttimeoutlen=80
endif
" Use ALT in terminal, should set ttimeout and ttimeoutlen at first.
" Refer: http://www.skywind.me/blog/archives/2021
if has('nvim') == 0 && has('gui_running') == 0
	function! s:set_metacode(key)
		execute "set <M-" .. a:key .. ">=\e" .. a:key
		execute "imap \e" .. a:key .. " <M-" .. a:key .. ">"
	endfunction
	for i in range(10)
		call s:set_metacode(nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		call s:set_metacode(nr2char(char2nr('a') + i))
		call s:set_metacode(nr2char(char2nr('A') + i))
	endfor
	for c in [',', '.', '/', ';', '{', '}']
		call s:set_metacode(c)
	endfor
	for c in ['?', ':', '-', '_', '+', '=', "'"]
		call s:set_metacode(c)
	endfor
endif

" Use function key in terminal.
function! s:set_function_key(name, code)
	execute "set " .. a:name .. "=\e" .. a:code
endfunction
if has('nvim') == 0 && has('gui_running') == 0
	call s:set_function_key('<F1>', 'OP')
	call s:set_function_key('<F2>', 'OQ')
	call s:set_function_key('<F3>', 'OR')
	call s:set_function_key('<F4>', 'OS')
	call s:set_function_key('<S-F1>', '[1;2P')
	call s:set_function_key('<S-F2>', '[1;2Q')
	call s:set_function_key('<S-F3>', '[1;2R')
	call s:set_function_key('<S-F4>', '[1;2S')
	call s:set_function_key('<S-F5>', '[15;2~')
	call s:set_function_key('<S-F6>', '[17;2~')
	call s:set_function_key('<S-F7>', '[18;2~')
	call s:set_function_key('<S-F8>', '[19;2~')
	call s:set_function_key('<S-F9>', '[20;2~')
	call s:set_function_key('<S-F10>', '[21;2~')
	call s:set_function_key('<S-F11>', '[23;2~')
	call s:set_function_key('<S-F12>', '[24;2~')
endif

nnoremap Q <cmd>qall<CR>

" Fast save.
nnoremap <C-s> <cmd>update<CR>
inoremap <C-s> <cmd>update<CR>
vnoremap <C-s> <cmd>update<CR>

" For cursor moving.
" Move in insert mode.
inoremap <C-a> <home>
inoremap <C-e> <end>
inoremap <C-h> <left>
inoremap <C-l> <right>

" Move in command mode.
cnoremap <C-h> <left>
cnoremap <C-j> <down>
cnoremap <C-k> <up>
cnoremap <C-l> <right>
cnoremap <C-a> <home>
cnoremap <C-e> <end>

" Move between windows.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

if has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
	set termwinkey=<C-_>
	tnoremap <ESC> <C-\><C-n>
endif
