set nocompatible
set backspace=indent,eol,start
set smarttab

set nopaste
set fileformats=unix,dos,mac  " newline

set autoindent
set cindent

set shiftround  " round indent to multiple of 'shiftwidth'
set shiftwidth=4
set softtabstop=4
set noexpandtab
set tabstop=4

set ignorecase " ignore case when search
set smartcase  " unless the search content contains uppercase letters
set hlsearch " highlight the search results
set incsearch " dynamically and incrementally display the search results

if has('multi_byte')
	set termencoding=utf-8  " terminal encoding
	set encoding=utf-8  " internal working encoding
	set fileencoding=utf-8  " default file encoding
	" auto try the following encoding when opening a file
	set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1
endif

" break at a multibyte character above 255, used for Asian text where every
" character is a word on its own
set formatoptions+=m
" don't insert a space between two multibyte characters (like Chinese) when
" join lines
set formatoptions+=B

set mouse=a

" when split a window vertically, display the new one on the right side
set splitright

set hidden
set autowrite

set viewoptions=cursor,curdir,folds,slash,unix

set clipboard=unnamedplus
if ($SSH_TTY || ilib#platform#wsl) && !has('nvim-0.10')
	set clipboard=
	" let vim clipboard sync with system
	" from https://www.zhihu.com/tardis/zm/ans/2156080913?source_id=1003
	function! Copy()
		let c = join(v:event.regcontents,"\n")
		let c64 = system("base64", c)
		let s = "\e]52;c;" . trim(c64) . "\x07"
		call s:RawEcho(s)
	endfunction

	function! s:RawEcho(str)
		if has('win32') && has('nvim')
			call chansend(v:stderr, a:str)
		else
			if filewritable('/dev/fd/2')
				call writefile([a:str], '/dev/fd/2', 'b')
			else
				exec("silent! !echo " . shellescape(a:str))
				redraw!
			endif
		endif
	endfunction

	augroup ivim_system_clipboard
		au!
		au TextYankPost * call Copy()
	augroup END
endif

set completeopt=menu,menuone,noselect
set confirm " confirm to save changes before exiting modified buffer
exec printf("set formatexpr=%s", has('nvim') ?
			\ execute("lua vim.lsp.formatexpr()") : "")
set formatoptions=jcroqlnt " tcqj
set grepformat=%f:%l:%c:%m
set grepprg=rg\ --vimgrep
exec printf("set jumpoptions=%s", has("nvim") ? "view" : "")

set sessionoptions=buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds

set spelllang=en

set noundofile
set updatetime=200 " save swap file and trigger CursorHold

set virtualedit=
set wildmode=longest:full,full

" UI
set cmdheight=1
set display=lastline
set nowrap
set ruler " show cursor position
set cursorline
set colorcolumn=81
set nostartofline  " keep column when switching between buffers
set showcmd  " show command in the last line
set noshowmode
" hide * markup for bold and italic, but not markers with substitutions
set conceallevel=2
set linebreak

if has('nvim')
	set pumblend=10 " popup blend
endif
set pumheight=10 " maximum number of entries in a popup

set number
set relativenumber
" always show the signcolumn, otherwise it would shift the text each time
set signcolumn=yes

set scrolloff=2
set sidescrolloff=8 " columns of context
set showmatch
set matchtime=3
set list
let g:ivim_listchars = 'tab:\│\ ,trail:.,extends:>,precedes:<'
exec 'set listchars='.g:ivim_listchars
" error format
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m
set shortmess+=WIcC

" set navigation and font in GUI
if has('gui_running')
	set guioptions-=m  " remove menu bar.
	set guioptions-=T  " remove toolbar.
	set guioptions-=r  " remove right-hand scrollbar.
	set guioptions-=L  " remove left-hand scrollbar.
	set guioptions-=e  " use a non-GUI tab pages line.
	set guifont=JetBrains_Mono_NL:h13,JetBrainsMonoNL_NFM:h13
	set guifontwide=楷体:h15
endif

exec printf("set laststatus=%d", has('nvim') ? 3 : 2)

set splitbelow " put new windows below current
set splitright " put new windows right of current
set splitkeep=screen

set termguicolors " true color support

set winminwidth=5

" {{{ fold
"set foldcolumn=1
exec 'set fillchars=foldopen:,foldclose:,fold:\ ,foldsep:\ ,diff:╱,eob:\ '
set foldlevel=99

" optimized treesitter foldexpr for Neovim >= 0.10.0
function! s:Foldexpr()
	let buf = bufnr()
	lua << END
	local buf = vim.fn.eval('buf')
	if vim.b[buf].ts_folds == nil then
		-- as long as we don't have a filetype, don't bother
		-- checking if treesitter is available (it won't)
		if vim.bo[buf].filetype == "" then
			return "0"
		end
		if vim.bo[buf].filetype:find("dashboard") then
			vim.b[buf].ts_folds = false
		else
			vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
		end
	end
END
" END must be the only char in the last line of the heredoc
	return luaeval('vim.b[' . buf . '].ts_folds and vim.treesitter.foldexpr() or "0"')
endfunc
" }}}

set smoothscroll
if has("nvim-0.10") == 1
	set foldexpr=s:Foldexpr()
	set foldmethod=expr
	set foldtext=
else
  set foldmethod=indent
  set foldtext=foldtext()
endif


" set <leader> key.
let g:mapleader = ' '
let g:maplocalleader = '\'

" global variable
let g:ivim_rootmarkers = ['.git', '.svn', '.hg', '.root', '.project']
let g:ivim_cache_dir = expand('~/.cache/vim')
let g:bundle_home = expand('~/.vim/bundle')
