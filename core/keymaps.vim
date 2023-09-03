vim9script
# keymaps.vim - Keymaps.

inoremap <M-q> <ESC>

# Fast save.
nnoremap <C-s> <Cmd>update<CR>
inoremap <C-s> <Cmd>update<CR>
vnoremap <C-s> <Cmd>update<CR>

# Easily deal with buffers.
nnoremap <M-x> <Cmd>bdelete<CR>

# Fast move in insert mode.
inoremap <C-a> <home>
inoremap <C-e> <end>

# Fast move in command mode.
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

# Move between buffers.
nnoremap [b <Cmd>bp<CR>
nnoremap ]b <Cmd>bn<CR>

# Move between windows.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

if has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
	set termwinkey=<C-_>
	tnoremap <C-h> <C-_>h
	tnoremap <C-j> <C-_>j
	tnoremap <C-k> <C-_>k
	tnoremap <C-l> <C-_>l
	tnoremap <M-q> <C-\><C-n>
endif
