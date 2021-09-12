"-------------------------------------------------------
" init.vim - Initialize config
"
" Created by hyl on 2021/02/16
" Last Modified: 2021/09/12 10:45:52
"-------------------------------------------------------

" prevent reload
if get(s:, 'loaded', 0) != 0
	finish
else
	let s:loaded = 1
end

" get the directory where this file is located
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
" use in init/keymaps.vim
let g:cfg_init_dir = s:home . '/init/'

" define a command to load the file
command! -nargs=1 LoadScript exec 'source ' . s:home . '/' . '<args>'

" add dir vimcfg to runtimepath
execute 'set runtimepath+=' . s:home

" add dir ~/.vim or ~/vimfile to runtimepath(sometimes vim will not add it
" automatically for you)
if has('unix')
	set runtimepath+=~/.vim
elseif has('win32')
	set runtimepath+=~/vimfiles
endif


"-------------------------------------------------------
" load modules
"-------------------------------------------------------
" load basic config
LoadScript init/basic.vim

" load terminal key extention config
LoadScript init/terminal.vim

" load plugins config
LoadScript init/plugins.vim

" load UI style
LoadScript init/style.vim

" load keymaps
LoadScript init/keymaps.vim
