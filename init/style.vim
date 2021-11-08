"-
" style.vim - UI config
"
" Created by Vamirio on 2021 Nov 08
" Last Modified: 2021 Nov 08 16:52:23
"-

"-
" color scheme
"-
set t_Co=256
let g:solarized_termcolors = 256
set background=light
colorscheme solarized

" set navigation and font in GUI
if has('gui_running')
	set guioptions-=m  " remove menu bar
	set guioptions-=T  " remove toolbar
	set guioptions-=r  " remove scrollbar
	if has('win32')
		set guifont=JetBrains_Mono:h13
	endif
endif

" set line number
set number

" cursorline
set cursorline

" set folding mode
set foldmethod=indent
set nofoldenable

" use vim-airline to view status, so turn off this option
set noshowmode

" show a column line in width 81
set colorcolumn=81

" when split a window vertically, display the new one on the right side
set splitright

" enable italic in vim
highlight Comment cterm=italic
