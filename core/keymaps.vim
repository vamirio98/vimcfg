vim9script
#-
# keymaps.vim - Keymaps.
#
# Created by vamirio on 2021 Nov 08
#-

# Set <M-q> as <ESC>.
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
inoremap <M-H> <ESC><C-w>h
inoremap <M-J> <ESC><C-w>j
inoremap <M-K> <ESC><C-w>k
inoremap <M-L> <ESC><C-w>l

if has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
	set termwinkey=<C-_>
	tnoremap <M-H> <C-_>h
	tnoremap <M-J> <C-_>j
	tnoremap <M-K> <C-_>k
	tnoremap <M-L> <C-_>l
	tnoremap <M-q> <C-\><C-n>
endif

# Fast edit and reload vimrc.
# get the directory where this file is located
var cfgDir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
def EditProfile(filename: string): void
	execute 'e ' .. cfgDir .. '/' .. filename
enddef

# Fast edit Vim profile.
nnoremap <space>evb <ScriptCmd><SID>EditProfile('basic.vim')<CR>
nnoremap <space>evt <ScriptCmd><SID>EditProfile('terminal.vim')<CR>
nnoremap <space>evu <ScriptCmd><SID>EditProfile('ui.vim')<CR>
nnoremap <space>evp <ScriptCmd><SID>EditProfile('plugins.vim')<CR>
nnoremap <space>evk <ScriptCmd><SID>EditProfile('keymaps.vim')<CR>
nnoremap <space>evw <ScriptCmd><SID>EditProfile('which_key_map.vim')<CR>

def ReloadProfile(): void
	var ft = fnamemodify(bufname('%'), ':e')
		if ft == 'vim'
			execute 'source %'
		endif
enddef

# Reload Vim profile.
nnoremap <space>sv <ScriptCmd><SID>ReloadProfile()<CR>
