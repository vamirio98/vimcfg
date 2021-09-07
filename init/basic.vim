"=======================================================
" basic.vim - Basic config for Vim
"
" Created by Haoyuan Li on 2021/02/15
" Last Modified: 2021/09/07 23:51:26
"=======================================================


"-------------------------------------------------------
" set <leader> key
"-------------------------------------------------------
let mapleader = "\\"
let maplocalleader = "\<tab>"


"-------------------------------------------------------
" jump to the last position when reopening a file
"-------------------------------------------------------
autocmd BufReadPost * call s:ReturnLastPos()
function s:ReturnLastPos()
	let l:last_pos = [line("'\""), col("'\"")]
	if l:last_pos[0] > 1 && last_pos[1] <= line("$")
		\ && &ft !~# 'commit'
		call cursor(l:last_pos)
	endif
endfunction


"-------------------------------------------------------
" incompatible with Vi
"-------------------------------------------------------
set nocompatible


"-------------------------------------------------------
" make backspace work like most other programs
"-------------------------------------------------------
set backspace=2


" turn on word wrap
set wrap

" turn on function key timeout detection(the function key in the
" terminal is a charset starts with ESC)
set ttimeout


" function key timeout detection: 50ms
set ttimeoutlen=50


"-------------------------------------------------------
" search setting
"-------------------------------------------------------
" case is ignored by default, unless the search content contains
" uppercase letters
set smartcase

" highlight the search result
set hlsearch

" dynamically and incrementally display the search results during
" input
set incsearch


"-------------------------------------------------------
" encoding setting
"-------------------------------------------------------
if has('multi_byte')
	" termenal encoding
	set termencoding=utf-8

	" internal working encoding
	set encoding=utf-8

	" default file encoding
	set fileencoding=utf-8

	" auto try the following encoding when opening a file
	set fileencodings=utf-8,gbk,gb18030,big5,euc-jp
endif


"-------------------------------------------------------
" syntax highlighting, filetype, filetype-plugin and
" filetype-indent setting
"-------------------------------------------------------
if has('autocmd')
	filetype plugin indent on
endif
if has('syntax')
	syntax enable
	syntax on
endif


"-------------------------------------------------------
" other config
"-------------------------------------------------------
" show the matching brackets
set showmatch

" how long will the matching brackets shows, unit: s
set matchtime=2

" delay drawing(improve performance)
set lazyredraw

"-------------------------------------------------------
" round indent to multiple of 'shiftwidth'
" (default 8, length of a tab)
"-------------------------------------------------------
set shiftround

" auto change to the file dir
set autochdir

" keep column when switching between buffers
set nostartofline
