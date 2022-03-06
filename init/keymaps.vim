"-
" keymaps.vim - Keymaps
"
" Created by vamirio on 2021 Nov 08
" Last Modified: 2021 Dec 23 19:54:58
"-

" Set <M-q> as <ESC>.
inoremap <M-q> <ESC>

"-
" Fast move in insert mode.
"-
inoremap <C-a> <home>
inoremap <C-e> <end>

"-
" Fast move in command mode.
"-
cnoremap <C-h> <left>
cnoremap <C-j> <down>
cnoremap <C-k> <up>
cnoremap <C-l> <right>
cnoremap <C-a> <home>
cnoremap <C-e> <end>


"-
" Alt key movement enhancement.
"-
" Move between words.
nnoremap <M-h> b
nnoremap <M-l> w
inoremap <M-h> <C-left>
inoremap <M-l> <C-right>
cnoremap <M-h> <C-left>
cnoremap <M-l> <C-right>

" Logic jump to the next/previous line(press wrap logic).
nnoremap <M-j> gj
nnoremap <M-k> gk
inoremap <M-j> <C-\><C-o>gj
inoremap <M-k> <C-\><C-o>gk

" Move between windows.
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


"-
" Fast save.
"-
nnoremap <silent> <C-s> :update<CR>
inoremap <silent> <C-s> <C-o>:update<CR>
vnoremap <silent> <C-s> <C-c>:update<CR>

" Switch all letters to uppercase.
inoremap <C-u> <ESC>viwgUea

"-
" Easily deal with buffers.
"-
nnoremap <silent> <M-x> :bdelete<CR>

"-
" Fast add quotes and brackets.
"-
nnoremap <leader>' bi'<ESC>ea'<ESC>
nnoremap <leader>" bi"<ESC>ea"<ESC>
vnoremap <leader>' c''<ESC>hp
vnoremap <leader>" c""<ESC>hp
nnoremap <leader>( bi(<ESC>ea)<ESC>
nnoremap <leader>[ bi[<ESC>ea]<ESC>
nnoremap <leader>{ bi{<ESC>ea}<ESC>
vnoremap <leader>( c()<ESC>hpe
vnoremap <leader>[ c[]<ESC>hpe
vnoremap <leader>{ c{}<ESC>hpe

"-
" Fast edit and reload vimrc.
"-
function EditProfile(filename)
	" get the directory where this file is located
	execute "e " . g:cfg_init_dir . a:filename
endfunction

" Fast edit Vim profile.
nnoremap <silent> <space>evb :call EditProfile('basic.vim')<CR>
nnoremap <silent> <space>evt :call EditProfile('terminal.vim')<CR>
nnoremap <silent> <space>evu :call EditProfile('ui.vim')<CR>
nnoremap <silent> <space>evp :call EditProfile('plugins.vim')<CR>
nnoremap <silent> <space>evk :call EditProfile('keymaps.vim')<CR>
nnoremap <silent> <space>evw :call EditProfile('which_key_map.vim')<CR>

function RoloadProfile()
	let l:ft = fnamemodify(bufname("%"), ":e")
		if l:ft == "vim"
			execute "source %"
		endif
endfunction

" Reload Vim profile.
nnoremap <silent> <space>sv :call ReloadProfile()<CR>
