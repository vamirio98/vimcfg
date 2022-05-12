"-
" basic.vim - Basic config for Vim
"
" Created by vamirio on 2021 Nov 08
"-

"-
" Set <leader> key.
"-
let mapleader = "\\"
let maplocalleader = "\<tab>"

"-
" Jump to the last position when reopening a file.
"-
augroup MyBasicGroup
	au!
	au BufReadPost * call s:ReturnLastPos()
augroup END
function s:ReturnLastPos()
	let l:last_pos = [line("'\""), col("'\"")]
	if l:last_pos[0] > 1 && last_pos[1] <= line("$")
				\ && &ft !~# 'commit'
		call cursor(l:last_pos)
	endif
endfunction

" Incompatible with Vi.
set nocompatible

" Make backspace work like most other programs.
set backspace=2

" Turn on word wrap.
set wrap

" Turn on function key timeout detection(the function key in the
" terminal is a charset starts with ESC).
set ttimeout

" Function key timeout detection: 50ms.
set ttimeoutlen=50

"-
" Search setting.
"-
" Case is ignored by default, unless the search content contains
" uppercase letters.
set ignorecase
set smartcase

" Highlight the search result.
set hlsearch

" Dynamically and incrementally display the search results during input.
set incsearch

"-
" Encoding setting.
"-
if has('multi_byte')
	" Termenal encoding.
	set termencoding=utf-8

	" Internal working encoding.
	set encoding=utf-8

	" Default file encoding.
	set fileencoding=utf-8

	" Auto try the following encoding when opening a file.
	set fileencodings=utf-8,gbk,gb18030,big5,euc-jp
endif

"-
" Syntax highlighting, filetype, filetype-plugin and
" filetype-indent setting.
"-
if has('autocmd')
	filetype plugin indent on
endif
if has('syntax')
	syntax enable
	syntax on
endif

"-
" Other config.
"-
" Show the matching brackets.
set showmatch

" How long will the matching brackets shows, unit: s.
set matchtime=2

" Delay drawing(improve performance).
set lazyredraw

"-
" Round indent to multiple of 'shiftwidth'. (default 8, length of a tab)
"-
set shiftround

" Keep column when switching between buffers.
set nostartofline

" Enable mouse in normal mode.
set mouse=n

" Auto load change.
set autoread
augroup MyAutoRead
	au!
	" Trigger autoread when cursor stop moving, buffer change or terminal focus.
	au CursorHold,CursorHoldI,BufEnter,FocusGained *
				\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
				\ | checktime | endif
	" Notification after file change
	au FileChangedShellPost * echohl WarningMsg
				\ | echo "File changed on disk. Buffer reloaded."
				\ | echohl None
augroup END
