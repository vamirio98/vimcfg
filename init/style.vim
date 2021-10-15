"-------------------------------------------------------
" style.vim - UI setting
"
" Created by Haoyuan Li on 2021/02/15
" Last Modified: 2021 Oct 15 11:13:17
"-------------------------------------------------------

"-------------------------------------------------------
" color scheme
"-------------------------------------------------------
set t_Co=256
let g:solarized_termcolors = 256
set background=light
colorscheme solarized

" set font in GUI
if has('win32') && has('gui_running')
	set guifont=DejaVu_Sans_Mono:h12
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

" show a column line in width 80
set colorcolumn=80

" when split a window vertically, display the new one on the right side
set splitright
