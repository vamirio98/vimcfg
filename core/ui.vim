vim9script
#-
# ui.vim - UI config.
#
# Created by vamirio on 2021 Nov 08
#-

# Color scheme.
g:gruvbox_italic = 1
set background=dark
augroup MyColorScheme
	au!
	au vimenter * ++nested colorscheme gruvbox
augroup END
# Use 24-bit (true-color) mode in Vim.
if (has('termguicolors'))
	set termguicolors
endif

# Set navigation and font in GUI.
if has('gui_running')
	set guioptions-=m  # Remove menu bar.
	set guioptions-=T  # Remove toolbar.
	set guioptions-=r  # Remove right-hand scrollbar.
	set guioptions-=L  # Remove left-hand scrollbar.
	set guioptions-=e  # Use a non-GUI tab pages line.
	set guifont=JetBrains_Mono:h12
endif

# Set line number.
set number

# Cursorline.
set cursorline

# Use plugin lightline to view status line.
set noshowmode
set laststatus=2

# Show a column line in width 81.
set colorcolumn=81

# When split a window vertically, display the new one on the right side.
set splitright
