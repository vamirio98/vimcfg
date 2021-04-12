"=======================================================
" style.vim - UI setting
"
" Created by hyl on 2021/02/15
" Last Modified: 2021/04/12 23:32:04
"=======================================================

"-------------------------------------------------------
" color scheme
"-------------------------------------------------------
set t_Co=256
let g:solarized_termcolors = 256
set background=light
colorscheme solarized

" set font in GUI
if has('win32') && has('gui_running')
	set guifont=DejaVu_Sans_Mono:h16
endif

" set line number
set number
set relativenumber

" show cursor position
set cursorline
set cursorcolumn

" set folding mode
set foldmethod=indent
set nofoldenable

" use vim-airline to view status, so turn off this option
set noshowmode

" show a column line in width 80
set colorcolumn=80

" when split a window vertically, display the new one on the right side
set splitright
