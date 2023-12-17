vim9script
# keymaps.vim - Keymaps.
# Author: vamirio

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
endif
