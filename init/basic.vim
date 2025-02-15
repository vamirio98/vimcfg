vim9script

# Incompatible with Vi.
set nocompatible

# Make backspace work like most other programs.
set backspace=2

# Indent.
set autoindent
set cindent

# Turn on word wrap.
set wrap

# Show cursor position.
set ruler

# {{{1 Search
# When search, case is ignored by default, unless the search content contains
# uppercase letters.
set ignorecase
set smartcase
# Highlight the search result.
set hlsearch
# Dynamically and incrementally display the search results during input.
set incsearch
# 1}}}

# {{{1Encoding setting.
if has('multi_byte')
	# Terminal encoding.
	set termencoding=utf-8

	# Internal working encoding.
	set encoding=utf-8

	# Default file encoding.
	set fileencoding=utf-8

	# Auto try the following encoding when opening a file.
	set fileencodings=utf-8,gbk,gb18030,big5,euc-jp
endif

# Break at a multibyte character above 255, used for Asian text where every
# character is a word on its own.
set formatoptions+=m

# Don't insert a space between two multibyte characters (like Chinese) when
# join lines.
set formatoptions+=B
# 1}}}

# Syntax highlighting, filetype, filetype-plugin and filetype-indent setting.
if has('autocmd')
	filetype plugin indent on
endif
if has('syntax')
	syntax enable
	syntax on
endif

# Newline.
set fileformats=unix,dos,mac

# Round indent to multiple of 'shiftwidth'. (default 8, length of a tab)
set shiftround

# Keep column when switching between buffers.
set nostartofline

# Fold.
if has('folding')
	set foldenable
	set foldmethod=manual
	# Expand all fold by default.
	set foldlevel=99
endif

# {{{1 Jump to the last position when reopening a file and auto load change.
set autoread

augroup MyExtendedGroup
	au!
	# Trigger autoread when cursor stop moving, buffer change or terminal focus.
	au CursorHold,CursorHoldI,BufEnter,FocusGained *
			\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
			\ | checktime | endif
	# Notification after file change
	au FileChangedShellPost * echohl WarningMsg
			\ | echo 'File changed on disk. Buffer reloaded.'
			\ | echohl None
augroup END
# 1}}}

# {{{1 UI.
# Show the matching brackets.
set showmatch
# How long will the matching brackets shows, unit: s.
set matchtime=2

# Show @@@ in the last column of the last line in the screen if it is too long.
set display=lastline
# Error format.
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m

# Make the delimiter visible.
set list
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

# Set line number.
set number
# Cursorline.
set cursorline
# Show a column line in width 81.
set colorcolumn=81
# 1}}}

# {{{1 Set navigation and font in GUI.
if has('gui_running')
	set guioptions-=m  # Remove menu bar.
	set guioptions-=T  # Remove toolbar.
	set guioptions-=r  # Remove right-hand scrollbar.
	set guioptions-=L  # Remove left-hand scrollbar.
	set guioptions-=e  # Use a non-GUI tab pages line.
	set guifont=JetBrains_Mono_NL:h13,JetBrainsMonoNL_NFM:h13
	set guifontwide=楷体:h15
endif
# 1}}}

# Enable mouse.
set mouse=a

# When split a window vertically, display the new one on the right side.
set splitright

set hidden
