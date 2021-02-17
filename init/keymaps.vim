"=======================================================
" keymaps.vim - Keymaps
"
" Created by hyl on 2021/02/15
" Last Modified: 2021/02/17 00:14:38
"=======================================================


"-------------------------------------------------------
" set <M-q> as <ESC>
"-------------------------------------------------------
inoremap <M-q> <ESC>


"------------------------------------------------------
" fast move
"------------------------------------------------------
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>
inoremap <C-a> <home>
inoremap <C-e> <end>

"-------------------------------------------------------
" fast move in command mode
"-------------------------------------------------------
cnoremap <C-h> <left>
cnoremap <C-j> <down>
cnoremap <C-k> <up>
cnoremap <C-l> <right>
cnoremap <C-a> <home>
cnoremap <C-e> <end>


"-------------------------------------------------------
" Alt key movement enhancement
"-------------------------------------------------------

" move between words
nnoremap <M-h> b
nnoremap <M-l> w
inoremap <M-h> <C-left>
inoremap <M-l> <C-right>
cnoremap <M-h> <C-left>
cnoremap <M-l> <C-right>

" move between windows
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


"------------------------------------------------------
" fast save
"------------------------------------------------------
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>a


"------------------------------------------------------
" change case
"------------------------------------------------------
nnoremap <C-u> viw~

" switch letters to uppercase
inoremap <C-u> <ESC>viwgUea


"------------------------------------------------------
" easily deal with buffers
"------------------------------------------------------
nnoremap <silent> <tab> :bnext<CR>
nnoremap <silent> <S-tab> :bprevious<CR>
nnoremap <silent> <M-w> :bdelete<CR>


"------------------------------------------------------
" fast add quotes and brackets
"------------------------------------------------------
nnoremap ' bi'<ESC>ea'<ESC>
nnoremap " bi"<ESC>ea"<ESC>
vnoremap ' c''<ESC>hp
vnoremap " c""<ESC>hp
nnoremap ( bi(<ESC>ea)<ESC>
nnoremap [ bi[<ESC>ea]<ESC>
nnoremap { bi{<ESC>ea}<ESC>
vnoremap ( c()<ESC>hpe
vnoremap [ c[]<ESC>hpe
vnoremap { c{}<ESC>hpe


"------------------------------------------------------
" fast edit and reload vimrc
"------------------------------------------------------

function EditProfile(filename)
	" get the directory where this file is located
	execute "vsp " . g:vim_config_init_dir . "/" . a:filename
endfunction

" fast edit Vim profile
nnoremap <silent> <leader>evb :call EditProfile('basic.vim')<CR>
nnoremap <silent> <leader>evt :call EditProfile('terminal.vim')<CR>
nnoremap <silent> <leader>evs :call EditProfile('style.vim')<CR>
nnoremap <silent> <leader>evi :call EditProfile('indent.vim')<CR>
nnoremap <silent> <leader>evf :call EditProfile('ft.vim')<CR>
nnoremap <silent> <leader>evp :call EditProfile('plugins.vim')<CR>
nnoremap <silent> <leader>evk :call EditProfile('keymaps.vim')<CR>

" reload Vim profile
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>
