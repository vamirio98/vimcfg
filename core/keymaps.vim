vim9script

# Set <leader> key.
g:mapleader = "\\"
g:maplocalleader = "\<tab>"

# {{{ Set Alt and function key in terminal.

# Disable ALT on GUI, make it can be used for mapping.
set winaltkeys=no

# Turn on function key timeout detection (the function key in the
# terminal is a charset starts with ESC).
set ttimeout

# Function key timeout detection: 50ms.
set ttimeoutlen=50

if $TMUX != ''
	set ttimeoutlen=30
elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
	set ttimeoutlen=80
endif
# {{{ Use ALT in terminal, should set ttimeout and ttimeoutlen at first.
# Refer: http://www.skywind.me/blog/archives/2021
if has('nvim') == 0 && has('gui_running') == 0
	def SetMetacode(key: string): void
		execute "set <M-" .. key .. ">=\e" .. key
		execute "imap \e" .. key .. " <M-" .. key .. ">"
	enddef
	for i in range(10)
		SetMetacode(nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		SetMetacode(nr2char(char2nr('a') + i))
		SetMetacode(nr2char(char2nr('A') + i))
	endfor
	for c in [',', '.', '/', ';', '{', '}']
		SetMetacode(c)
	endfor
	for c in ['?', ':', '-', '_', '+', '=', "'"]
		SetMetacode(c)
	endfor
endif
# }}}

# {{{ Use function key in terminal.
def SetFunctionKey(name: string, code: string): void
	execute "set " .. name .. "=\e" .. code
enddef
if has('nvim') == 0 && has('gui_running') == 0
	SetFunctionKey('<F1>', 'OP')
	SetFunctionKey('<F2>', 'OQ')
	SetFunctionKey('<F3>', 'OR')
	SetFunctionKey('<F4>', 'OS')
	SetFunctionKey('<S-F1>', '[1;2P')
	SetFunctionKey('<S-F2>', '[1;2Q')
	SetFunctionKey('<S-F3>', '[1;2R')
	SetFunctionKey('<S-F4>', '[1;2S')
	SetFunctionKey('<S-F5>', '[15;2~')
	SetFunctionKey('<S-F6>', '[17;2~')
	SetFunctionKey('<S-F7>', '[18;2~')
	SetFunctionKey('<S-F8>', '[19;2~')
	SetFunctionKey('<S-F9>', '[20;2~')
	SetFunctionKey('<S-F10>', '[21;2~')
	SetFunctionKey('<S-F11>', '[23;2~')
	SetFunctionKey('<S-F12>', '[24;2~')
endif
# }}}
# }}}

# Toggle fold.
nnoremap <space>z za

inoremap <M-q> <ESC>

# {{{ Resize window.
nnoremap <M-up> <C-w>+
nnoremap <M-down> <C-w>-
nnoremap <M-left> <C-w><
nnoremap <M-right> <C-w>>
# }}}

# Fast save.
nnoremap <C-s> <Cmd>update<CR>
inoremap <C-s> <Cmd>update<CR>
vnoremap <C-s> <Cmd>update<CR>

# {{{ For cursor moving.
# Move in insert mode.
inoremap <C-a> <home>
inoremap <C-e> <end>

# Move in command mode.
cnoremap <C-h> <left>
cnoremap <C-j> <down>
cnoremap <C-k> <up>
cnoremap <C-l> <right>
cnoremap <C-a> <home>
cnoremap <C-e> <end>

# Move between words.
nnoremap <M-h> b
nnoremap <M-l> w
inoremap <M-h> <C-left>
inoremap <M-l> <C-right>
cnoremap <M-h> <C-left>
cnoremap <M-l> <C-right>

# Logic jump to the next/previous line(press wrap logic).
nnoremap <M-j> gj
nnoremap <M-k> gk
inoremap <M-j> <C-\><C-o>gj
inoremap <M-k> <C-\><C-o>gk
# }}}


# Easily deal with buffers.
nnoremap <M-x> <Cmd>bdelete<CR>
# Move between buffers.
nnoremap [b <Cmd>bp<CR>
nnoremap ]b <Cmd>bn<CR>

# {{{ Move between windows.
nnoremap <M-H> <C-w>h
nnoremap <M-J> <C-w>j
nnoremap <M-K> <C-w>k
nnoremap <M-L> <C-w>l

if has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
	set termwinkey=<C-_>
	tnoremap <M-H> <C-_>h
	tnoremap <M-J> <C-_>j
	tnoremap <M-K> <C-_>k
	tnoremap <M-L> <C-_>l
	tnoremap <M-q> <C-\><C-n>
	tnoremap <ESC> <C-\><C-n>
endif
# }}}
