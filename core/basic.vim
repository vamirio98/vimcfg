"-
" basic.vim - Basic config for Vim, should be compatible with vim-tiny.
"
" Created by vamirio on 2021 Nov 08
"-

"-
" Set <leader> key.
"-
let mapleader = "\\"
let maplocalleader = "\<tab>"

" Incompatible with Vi.
set nocompatible

" Make backspace work like most other programs.
set backspace=2

" Indent.
set autoindent
set cindent

" Disable ALT on GUI, make it can be used for mapping.
set winaltkeys=no

" Turn on word wrap.
set wrap

" Turn on function key timeout detection (the function key in the
" terminal is a charset starts with ESC).
set ttimeout

" Function key timeout detection: 50ms.
set ttimeoutlen=50

" Show cursor position.
set ruler

" When search, case is ignored by default, unless the search content contains
" uppercase letters.
set ignorecase
set smartcase
" Highlight the search result.
set hlsearch
" Dynamically and incrementally display the search results during input.
set incsearch

" Encoding setting.
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

" Syntax highlighting, filetype, filetype-plugin and filetype-indent setting.
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

" Show @@@ in the last column of the last line in the screen if it is too long.
set display=lastline

" Delay drawing (improve performance).
set lazyredraw

" Error format.
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m

" Make the delimiter visible.
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<


" Break at a multibyte character above 255, used for Asian text where every
" character is a word on its own.
set formatoptions+=m

" Don't insert a space between two multibyte characters (like Chinese) when
" join lines.
set formatoptions+=B

" Newline.
set fileformats=unix,dos,mac

" Round indent to multiple of 'shiftwidth'. (default 8, length of a tab)
set shiftround

" Keep column when switching between buffers.
set nostartofline

" Enable mouse.
set mouse=a

" Fold.
if has('folding')
	set foldenable
	set foldmethod=marker
	" Expand all fold by default.
	set foldlevel=99
endif
