vim9script
# plugins.vim - Plugins config.
# Author: vamirio

# Default groups.
if !exists('g:plugin_group')
	g:plugin_group = ['basic', 'enhanced', 'tags', 'git']
	g:plugin_group += ['lightline', 'dirvish', 'coc', 'snippets', 'debug']
	g:plugin_group += ['asynctask', 'which_key', 'fuzzy_search', 'quickui']
endif


# Use vim-plug to manager all plugins.
# Specify a directory for plugins.
if has('unix')
	plug#begin('~/.vim/plugged')
elseif has('win32')
	plug#begin('~/vimfiles/plugged')
endif


# Basic plugins.
if index(g:plugin_group, 'basic') >= 0
	# Color scheme.
	Plug 'morhetz/gruvbox'


	# Show the start screen, display the recently edited files.
	Plug 'mhinz/vim-startify'

	# The dir to save/load sessions to/from.
	g:startify_session_dir = '~/.vim/session'


	# Insert or delete brackets, parens, quotes in pair.
	Plug 'Eliot00/auto-pairs'

	# Open fly mode.
	g:AutoPairsFlayMode = 1


	# Easy motion.
	Plug 'monkoose/vim9-stargate'

	# How should VIM9000 call you.
	g:stargate_name = 'Master'


	# Better rainbow paretheses.
	Plug 'luochen1990/rainbow'

	g:rainbow_active = 1


	# Strip trailing whitespace.
	Plug 'axelf4/vim-strip-trailing-whitespace'


	# Additional Vim syntax highlight for C/C++.
	Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}
endif


# Enhanced plugins.
if index(g:plugin_group, 'enhanced') >= 0
	# Float terminal.
	Plug 'voldikss/vim-floaterm'

	# Terminal style.
	g:floaterm_wintype = 'vsplit'
	g:floaterm_width = 56
	g:floaterm_height = 30
	g:floaterm_position = 'botright'
	g:floaterm_opener = 'vsplit'

	# Close window if the job exits normally.
	g:floaterm_autoclose = 1
	# Kill all floaterm instance when quit vim.
	augroup MyFloaterm
		au!
		au QuitPre * execute 'FloatermKill!'
	augroup END


	# Indent line.
	Plug 'Yggdroot/indentLine', {'for': ['python', 'json']}

	g:indentLine_setColors = 0
	# Make quotation marks visible in JSON.
	g:vim_json_conceal = 0
endif


# Auto generate ctags/gtags and provide auto indexing function.
if index(g:plugin_group, 'tags') >= 0
	# Asynchronous generate tag file.
	Plug 'ludovicchabant/vim-gutentags'
	Plug 'skywind3000/gutentags_plus'

	# Set root dir of a project.
	g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

	# Set ctags file name.
	g:gutentags_ctas_tagfile = '.tags'

	# Detect dir ~/.cache/tags, create new one if it doesn't exist.
	var tagCacheDir = expand('~/.cache/tags')
	if !isdirectory(tagCacheDir)
		silent! mkdir(tagCacheDir, 'p')
	endif

	# Set dir to save the tag file.
	g:gutentags_cache_dir = tagCacheDir

	# Use a ctags-compatible program to generate a tags file and
	# GNU's gtags to generate a code database file.
	g:gutentags_modules = []
	if executable('ctags')
		g:gutentags_modules += ['ctags']
	endif
	if executable('gtags-cscope') && executable('gtags')
		g:gutentags_modules += ['gtags_cscope']
	endif

	# Set ctags arguments.
	g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
	g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
	g:gutentags_ctags_extra_args += ['--c-kinds=+px']

	# Use universal-ctags.
	g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

	# Config gutentags whitelist.
	g:gutentags_exclude_filetypes = ['text']

	# Prevent gutentags from autoloading gtags database.
	g:gutentags_auto_add_gtags_cscope = 0

	# Change focus to quickfix window after search.
	g:gutentags_plus_switch = 1
endif


# Git.
if index(g:plugin_group, 'git') >= 0
	Plug 'tpope/vim-fugitive'
	Plug 'Eliot00/git-lens.vim'
endif


# Lightline.
if index(g:plugin_group, 'lightline') >= 0
	Plug 'itchyny/lightline.vim'
	Plug 'mengelbrecht/lightline-bufferline'

	g:lightline = {
		'colorscheme': 'one',
		'active': {
			'left': [['mode', 'paste'],
		             ['gitstatus', 'cocstatus', 'readonly', 'filename',
			          'modified']]
		},
		'component_function': {
			'gitstatus': 'FugitiveStatusline',
			'cocstatus': 'coc#status'
		},
		'tabline': {
			'left': [['buffers']],
			'right': [['']]
		},
		'component_expand': {
			'buffers': 'lightline#bufferline#buffers'
		},
		'component_type': {
			'buffers': 'tabsel'
		}
	}

	# Force lightline update.
	augroup MyLightline
		au!
		au User CocStatusChange,CocDiagnosticChange lightline#update()
	augroup END

	# Always show tabline.
	set showtabline=2

	# Add the ordinal buffer number to the buffer name.
	g:lightline#bufferline#show_number = 2

	# Use unicode superscript numerals as buffer number.
	g:lightline#bufferline#composed_number_map = {
		0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
		5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
	}
endif


# Dirvish.
if index(g:plugin_group, 'dirvish') >= 0
	Plug 'justinmk/vim-dirvish'

	# Sort and hide files, then locate related file.
	def SetupDirvish(): void
		if &buftype != 'nofile' && &filetype != 'dirvish'
			return
		endif

		# Get current filename.
		var text = getline('.')
		if get(g:, 'dirvish_hide_visible', 0) == 0
			execute 'silent! keeppatterns g@\v[\/]\.[^\/]+[\/]?$@d _'
		endif
		# Sort filename.
		execute 'sort ,^.*[\/],'
		var name = '^' .. escape(text, '.*[]~\') .. '[/*|@=|\\*]\=\%($\|\s\+\)'
		# Locate to current file.
		search(name, 'wc')
		nnoremap <buffer> ~ <Cmd>Dirvish ~<CR>
	enddef

	augroup MyDirvish
		au!
		au FileType dirvish SetupDirvish()
	augroup END
endif


# Coc-nvim.
if index(g:plugin_group, 'coc') >= 0
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	# Some servers have issues with backup files.
	set nobackup
	set nowritebackup

	# For better diagnostic messages experience.
	set updatetime=300

	# Always show the signcolumn, otherwise it would shift the text each
	# time diagnostics appear/become resolved.
	set signcolumn=yes

	# Limit completion menu height.
	set pumheight=10

	augroup MyCocNvim
		au!
		# Highlight symbol and its references when holding the cursor.
		au CursorHold * silent g:CocActionAsync('highlight')
		# Setup formatexpr specified filetype(s).
		au FileType json,typescript setl formatexpr=CocAction('formatSelected')
		# Update signature help on jump placeholder.
		au User CocJumpPlaceholder g:CocActionAsync('showSignatureHelp')
	augroup END
endif


if index(g:plugin_group, 'snippets') >= 0
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	g:UltiSnipsSnippetDirectories = ['UltiSnips', 'plugcfg/UltiSnips']
endif


# Debug.
if index(g:plugin_group, 'debug') >= 0
	Plug 'puremourning/vimspector'
endif


# Execute tasks asynchronously.
if index(g:plugin_group, 'asynctask') >= 0
	# Run asynchronous tasks.
	Plug 'skywind3000/asyncrun.vim', {'on': ['AsyncRun', 'AsyncStop']}
	Plug 'skywind3000/asynctasks.vim', {'on': ['AsyncTask', 'AsyncTaskMacro', 'AsyncTaskList', 'AsyncTaskEdit']}

	# Extra config file.
	if has('unix')
		g:asynctasks_extra_config = ['~/.vim/vimcfg/plugcfg/tasks.ini']
	elseif has('win32')
		g:asynctasks_extra_config = ['~/vimfiles/vimcfg/plugcfg/tasks.ini']
	endif

	# Automatically open Quickfix window with a height of 6.
	g:asyncrun_open = 6

	# Bell when finish the task.
	g:asyncrun_bell = 0

	# Specify what terminal to use.
	g:asynctasks_term_pos = 'right'
	g:asynctasks_term_cols = 56

	# Reuse a terminal.
	g:asynctasks_term_reuse = 1

	# Set root dir for project.
	g:asyncrun_rootmarks = ['.root', '.svn', '.git', '.project']
endif


# Vim key mapping hint.
if index(g:plugin_group, 'which_key') >= 0
	Plug 'liuchengxu/vim-which-key'

	set timeoutlen=300
endif


# Fuzzy search.
if index(g:plugin_group, 'fuzzy_search') >= 0
	Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}

	g:Lf_IgnoreCurrentBufferName = 1

	# Popup mode.
	g:Lf_WindowPosition = 'popup'
	g:Lf_PreviewInPopup = 1
endif


# Vim quickui.
if index(g:plugin_group, 'quickui') >= 0
	Plug 'skywind3000/vim-quickui'

	g:quickui_show_tip = 1
	g:quickui_border_style = 2
	g:quickui_color_scheme = 'gruvbox'
endif


# Initialize plugin system.
call plug#end()
