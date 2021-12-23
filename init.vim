"-
" init.vim - Initialize config
"
" Created by Vamirio on 2021 Nov 08
" Last Modified: 2021 Dec 23 19:34:53
"-

" Prevent reload.
if get(s:, 'loaded', 0) != 0
	finish
else
	let s:loaded = 1
end

" Get the directory where this file is located.
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
" Use in init/keymaps.vim.
let g:cfg_init_dir = s:home . '/init/'

" Define a command to load the file.
command! -nargs=1 LoadScript exec 'source ' . s:home . '/' . '<args>'

" Add dir vimcfg to runtimepath.
execute 'set runtimepath+=' . s:home

" Add dir ~/.vim or ~/vimfile to runtimepath(sometimes vim will not add it
" automatically for you).
if has('unix')
	set runtimepath+=~/.vim
elseif has('win32')
	set runtimepath+=~/vimfiles
endif

"-
" Load modules.
"-
" Load basic config.
LoadScript init/basic.vim

" Load terminal key extention config.
LoadScript init/terminal.vim

" Load plugins config.
LoadScript init/plugins.vim

" Load UI style.
LoadScript init/ui.vim

" Load keymaps.
LoadScript init/keymaps.vim

" Load vim-which-key map.
LoadScript init/which_key_map.vim
