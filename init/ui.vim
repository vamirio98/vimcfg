"-
" ui.vim - UI config
"
" Created by Vamirio on 2021 Nov 08
" Last Modified: 2021 Dec 21 10:34:44
"-

"-
" Color scheme.
"-
set t_Co=256
let g:solarized_termcolors = 256
set background=light
colorscheme solarized

" Set navigation and font in GUI.
if has('gui_running')
	set guioptions-=m  " Remove menu bar.
	set guioptions-=T  " Remove toolbar.
	set guioptions-=r  " Remove scrollbar.
	set guioptions-=e  " Use a non-GUI tab pages line.
	set guifont=JetBrains_Mono:h12
endif

" Set line number.
set number

" Cursorline.
set cursorline

" Set folding mode.
set foldmethod=indent
set nofoldenable

" Use plugin lightline to view status line.
set noshowmode
set laststatus=2

" Show a column line in width 81.
set colorcolumn=81

" When split a window vertically, display the new one on the right side.
set splitright

" Enable italic comment.
highlight Comment cterm=italic
