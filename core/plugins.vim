vim9script
#-
# plugins.vim - Plugins config.
#
# Created by vamirio on 2021 Nov 08
#-

# Default groups.
if !exists('g:plugin_group')
	g:plugin_group = ['basic', 'enhanced', 'tags']
	g:plugin_group += ['lightline', 'dirvish', 'coc', 'debug']
	g:plugin_group += ['asynctask', 'which_key', 'fuzzy_search']
endif


# Use vim-plug to manager all plunins.
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
endif


# Enhanced plugins.
if index(g:plugin_group, 'enhanced') >= 0
	# Insert or delete brackets, parens, quotes in pair.
	Plug 'Eliot00/auto-pairs'

	# Open fly mode.
	g:AutoPairsFlayMode = 1

	# Work in FlyMode, insert the key at the Fly Mode jumped postion.
	g:AutoPairsShortcutBackInsert = '<M-b>'


	# Easy motion.
	Plug 'monkoose/vim9-stargate'

	# How should VIM9000 call you.
	g:stargate_name = 'Master'

	# For 1 character to search before showing hints.
	noremap <leader>f <Cmd>call stargate#OKvim(1)<CR>
	# For 2 consecutive characters to search.
	noremap <leader>F <Cmd>call stargate#OKvim(2)<CR>

	# Move between windows.
	nnoremap <leader>w <Cmd>call stargate#Galaxy()<CR>


	# Better rainbow paretheses.
	Plug 'luochen1990/rainbow'

	g:rainbow_active = 1


	# Strip trailing whitespace.
	Plug 'axelf4/vim-strip-trailing-whitespace'


	# Float terminal.
	Plug 'voldikss/vim-floaterm'

	# Terminal style.
	g:floaterm_wintype = 'vsplit'
	g:floaterm_width = 56
	g:floaterm_height = 30
	g:floaterm_position = 'botright'
	g:floaterm_opener = 'vsplit'

	# Open or hide the floaterm window.
	g:floaterm_keymap_toggle = '<M-=>'
	# Open a new floaterm window.
	g:floaterm_keymap_new = '<M-+>'
	# Switch to the previous floaterm instance.
	g:floaterm_keymap_prev = '<M-,>'
	# Switch to the next floaterm instance
	g:floaterm_keymap_next = '<M-.>'
	# Close the current terminal instance.
	g:floaterm_keymap_kill = '<M-->'

	# Close window if the job exits normally.
	g:floaterm_autoclose = 1
	# Kill all floaterm instance when quit vim.
	augroup MyFloaterm
		au!
		au QuitPre * execute 'FloatermKill!'
	augroup END


	# Indent line.
	Plug 'Yggdroot/indentLine', {'for': 'python'}

	g:indentLine_setColors = 0


	# Additional Vim syntax highlight for C/C++.
	Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}


	# Git.
	Plug 'tpope/vim-fugitive'
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

	# Use unicode superscipt numerals as buffer number.
	g:lightline#bufferline#composed_number_map = {
		0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
		5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
	}

	# Quick switch to buffers using their ordinal number.
	nmap <leader>1 <Plug>lightline#bufferline#go(1)
	nmap <leader>2 <Plug>lightline#bufferline#go(2)
	nmap <leader>3 <Plug>lightline#bufferline#go(3)
	nmap <leader>4 <Plug>lightline#bufferline#go(4)
	nmap <leader>5 <Plug>lightline#bufferline#go(5)
	nmap <leader>6 <Plug>lightline#bufferline#go(6)
	nmap <leader>7 <Plug>lightline#bufferline#go(7)
	nmap <leader>8 <Plug>lightline#bufferline#go(8)
	nmap <leader>9 <Plug>lightline#bufferline#go(9)
	nmap <leader>0 <Plug>lightline#bufferline#go(10)

	# Quick delete buffers by their ordinal number.
	nmap <leader>c1 <Plug>lightline#bufferline#delete(1)
	nmap <leader>c2 <Plug>lightline#bufferline#delete(2)
	nmap <leader>c3 <Plug>lightline#bufferline#delete(3)
	nmap <leader>c4 <Plug>lightline#bufferline#delete(4)
	nmap <leader>c5 <Plug>lightline#bufferline#delete(5)
	nmap <leader>c6 <Plug>lightline#bufferline#delete(6)
	nmap <leader>c7 <Plug>lightline#bufferline#delete(7)
	nmap <leader>c8 <Plug>lightline#bufferline#delete(8)
	nmap <leader>c9 <Plug>lightline#bufferline#delete(9)
	nmap <leader>c0 <Plug>lightline#bufferline#delete(10)
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

	# For better diagnostic messages experience.
	set updatetime=300

	# Always show the signcolumn, otherwise it would shift the text each
	# time diagnostics appear/become resolved.
	set signcolumn=yes

	# Limit completion menu height.
	set pumheight=10
	# Use tab for trigger completion with characters ahead and navigate.
	inoremap <silent><expr> <tab>
				\ coc#pum#visible() ? coc#pum#next(1) :
				\ <SID>CheckBackspace() ? "\<tab>" :
				\ coc#refresh()
	inoremap <expr><S-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

	# Confirm the completion when popupmenu is visible, insert <CR> and
	# notify coc.nvim otherwise.
	inoremap <silent><expr> <CR> (coc#pum#visible() &&
				\ coc#pum#info()["inserted"]) ? coc#pum#confirm() :
				\ "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

	def CheckBackspace(): bool
		var col = col('.') - 1
		return !col || getline('.')[col - 1] =~# '\s'
	enddef

	# Use <C-space> to trigger completion.
	inoremap <silent><expr> <C-@> coc#refresh()

	# Goto code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gc <Plug>(coc-declaration)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	# Jump to previous diagnostic.
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	# Jump to next diagnostic.
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	# Use K to show documentation in preview window.
	nnoremap K <ScriptCmd>ShowDocumentation()<CR>
	def ShowDocumentation(): void
		if g:CocAction('hasProvider', 'hover')
			g:CocActionAsync('doHover')
		else
			feedkeys('K', 'in')
		endif
	enddef

	# Symbol renaming.
	nmap <leader>rn <Plug>(coc-rename)

	# Formating code.
	nnoremap <space>fc <Cmd>call CocActionAsync('format')<CR>

	# Apply AutoFix to problem on the current line.
	nmap <space>qf <Plug>(coc-fix-current)

	# Translation.
	nmap <space>tt <Plug>(coc-translator-p)
	vmap <space>tt <Plug>(coc-translator-pv)

	# Remap <C-f> and <C-b> for scroll float window/popups.
	if has('patch-8.2.0750')
		nnoremap <silent><nowait><expr> <C-f>
					\ coc#float#has_scroll() ?
					\ coc#float#scroll(1) : "\<C-f>"
		nnoremap <silent><nowait><expr> <C-b>
					\ coc#float#has_scroll() ?
					\ coc#float#scroll(0) : "\<C-b>"
		inoremap <silent><nowait><expr> <C-f>
					\ coc#float#has_scroll() ?
					\ "\<C-r>=coc#float#scroll(1)\<CR>" : "\<right>"
		inoremap <silent><nowait><expr> <C-b>
					\ coc#float#has_scroll() ?
					\ "\<C-r>=coc#float#scroll(0)\<CR>" : "\<left>"
		vnoremap <silent><nowait><expr> <C-f>
					\ coc#float#has_scroll() ?
					\ coc#float#scroll(1) : "\<C-f>"
		vnoremap <silent><nowait><expr> <C-b>
					\ coc#float#has_scroll() ?
					\ coc#float#scroll(0) : "\<C-b>"
	endif

	# List outline.
	nnoremap <nowait> <space>co  <ScriptCmd>ToggleCocOutline()<CR>
	def ToggleCocOutline(): void
		var winid = coc#window#find('cocViewId', 'OUTLINE')
		if winid == -1
			g:CocActionAsync('showOutline', 1)
		else
			coc#window#close(winid)
		endif
	enddef

	# Mapping for CocList.
	# Show all diagnostics.
	nnoremap <nowait> <space>cld <Cmd>CocList diagnostics<CR>
	# Manage extensions.
	nnoremap <nowait> <space>cle <Cmd>CocList extensions<CR>
	# Show commands.
	nnoremap <nowait> <space>clc <Cmd>CocList commands<CR>
	# Find symbol of current document.
	nnoremap <nowait> <space>clo <Cmd>CocList outline<CR>
	# Search workspace symbols.
	nnoremap <nowait> <space>cls <Cmd>CocList -I symbols<CR>
	# Do default action for next item.
	nnoremap <nowait> <space>clj <Cmd>CocNext<CR>
	# Do default action for previous item.
	nnoremap <nowait> <space>clk <Cmd>CocPrev<CR>
	# Resume latest coc list.
	nnoremap <nowait> <space>clp <Cmd>CocListResume<CR>

	augroup MyCocNvim
		au!
		# Highlight symbol and its references when holding the cursor.
		au CursorHold * silent g:CocActionAsync('highlight')
		# Setup formatexpr specified filetype(s).
		au FileType json,typescript setl formatexpr=CocAction('formatSelected')
		# Update signature help on jump placeholder.
		au User CocJumpPlaceholder g:CocActionAsync('showSignatureHelp')
	augroup END

	#-
	# Snippets.
	#-
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	g:UltiSnipsSnippetDirectories = ['UltiSnips', 'plugcfg/UltiSnips']
	g:UltiSnipsExpandTrigger = '<C-l>'
	g:UltiSnipsJumpForwardTrigger = '<C-j>'
	g:UltiSnipsJumpBackwardTrigger = '<C-k>'
endif


# Debug.
if index(g:plugin_group, 'debug') >= 0
	Plug 'puremourning/vimspector'

	nmap <silent> <S-F5> <Plug>VimspectorContinue
	nmap <silent> <F9> <Plug>VimspectorToggleBreakpoint
	nmap <silent> <S-F9> <Plug>VimspectorToggleConditionalBreakpoint

	augroup MyVimspector
		au!
		au User VimspectorUICreated CustomiseWinBar()
		au User VimspectorJumpedToFrame OnJumpToFrame()
		au User VimspectorDebugEnded ++nested OnDebugEnd()
	augroup END

	# Customise UI {{{
	def CustomiseWinBar(): void
		win_gotoid(g:vimspector_session_windows.code)
		# Clear the existing WinBar created by Vimspector.
		aunmenu WinBar
		# Create new WinBar.
		nnoremenu WinBar.▷ :call vimspector#Continue()<CR>
		nnoremenu WinBar.↷ :call vimspector#StepOver()<CR>
		nnoremenu WinBar.↓ :call vimspector#StepInto()<CR>
		nnoremenu WinBar.↑ :call vimspector#StepOut()<CR>
		nnoremenu WinBar.● :call vimspector#ToggleBreakpoint()<CR>
		nnoremenu WinBar.‖ :call vimspector#Pause()<CR>
		nnoremenu WinBar.□ :call vimspector#Stop()<CR>
		nnoremenu WinBar.⟲ :call vimspector#Restart()<CR>
		nnoremenu WinBar.✕ :call vimspector#Reset()<CR>
	enddef
	# }}}

	# Custom mappings while debuggins. {{{
	var vimspectorMapped = {}

	def OnJumpToFrame(): void
		if has_key(vimspectorMapped, string(bufnr()))
			return
		endif

		nmap <silent><buffer> <F5> <Plug>VimspectorContinue
		nmap <silent><buffer> <S-F5> :VimspectorReset<CR>
		nmap <silent><buffer> <F4> <Plug>VimspectorRestart
		nmap <silent><buffer> <S-F4> <Plug>VimspectorStop
		nmap <silent><buffer> <F6> <Plug>VimspectorPause
		nmap <silent><buffer> <F8> <Plug>VimspectorRunToCursor
		nmap <silent><buffer> <F10> <Plug>VimspectorStepOver
		nmap <silent><buffer> <F11> <Plug>VimspectorStepInto
		nmap <silent><buffer> <F12> <Plug>VimspectorStepOut

		vimspectorMapped[string(bufnr())] = {'modifiable': &modifiable}

		setlocal nomodifiable
	enddef

	def OnDebugEnd(): void
		var originalBuf = bufnr()
		var bufHidden = &hidden
		augroup MyVimspectorSwapExists
			au!
			au SwapExists * v:swapchoice = 'o'
		augroup END

		try
			set hidden
			for bufnr in keys(vimspectorMapped)
				try
					execute 'buffer' bufnr
					silent! nunmap <buffer> <F5>
					silent! nunmap <buffer> <S-F5>
					silent! nunmap <buffer> <F4>
					silent! nunmap <buffer> <S-F4>
					silent! nunmap <buffer> <F6>
					silent! nunmap <buffer> <F8>
					silent! nunmap <buffer> <F10>
					silent! nunmap <buffer> <F11>
					silent! nunmap <buffer> <F12>

					&modifiable = vimspectorMapped[bufnr]['modifiable']
				finally
				endtry
			endfor
		finally
			execute 'noautocmd buffer' originalBuf
			&hidden = bufHidden
		endtry

		au! MyVimspectorSwapExists

		vimspectorMapped = {}
	enddef
	# }}}
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

	# Automatically open Qickfix window with a height of 6.
	g:asyncrun_open = 6

	# Bell when finish the task.
	g:asyncrun_bell = 0

	# Open/close the Quickficx window.
	nnoremap  <F10> <Cmd>call asyncrun#quickfix_toggle(6)<CR>

	# Specify what terminal to use.
	g:asynctasks_term_pos = 'right'
	g:asynctasks_term_cols = 56

	# Reuse a terminal.
	g:asynctasks_term_reuse = 1

	# Shortcut for single file tasks.
	# Compile single file.
	nnoremap <F4> <Cmd>AsyncTask file-build<CR>
	# Complie single file with debug info.
	nnoremap <S-F4> <Cmd>AsyncTask file-debug<CR>
	# Run the program.
	nnoremap <F5> <Cmd>AsyncTask file-run<CR>
	# Delete the executable file generated by current file.
	nnoremap <space>asd <Cmd>AsyncTask exe-del<CR>

	# Set root dir for project.
	g:asyncrun_rootmarks = ['.root', '.svn', '.git', '.project']

	# Shortcut for project tasks.
	# Set code style.
	nnoremap <space>aps <Cmd>AsyncTask set-code-style<CR>

	# Shortcut for CMake project tasks.
	# Configure CMake project.
	nnoremap <S-F7> <Cmd>AsyncTask cmake-project-config<CR>
	# Build CMake project.
	nnoremap <F7> <Cmd>AsyncTask cmake-project-build<CR>
	# Run CMake project.
	nnoremap <F6> <Cmd>AsyncTask cmake-project-run<CR>
	# Clean CMake project.
	nnoremap <S-F6> <Cmd>AsyncTask cmake-project-clean<CR>

	# Query available tasks.
	nnoremap <space>aa <Cmd>AsyncTaskList<CR>
endif


# Vim key mapping hint.
if index(g:plugin_group, 'which_key') >= 0
	Plug 'liuchengxu/vim-which-key'

	set timeoutlen=300

	g:which_key_use_floating_win = 1
endif


# Fuzzy search.
if index(g:plugin_group, 'fuzzy_search') >= 0
	Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}

	# Search files.
	g:Lf_ShortcutF = '<space>ff'
	# Search buffers.
	g:Lf_ShortcutB = '<space>fb'
	# Search functions.
	nnoremap <space>fn <Cmd>LeaderfFunction<CR>

	g:Lf_IgnoreCurrentBufferName = 1

	# Popup mode.
	g:Lf_WindowPosition = 'popup'
	g:Lf_PreviewInPopup = 1
endif


# Initialize plugin system.
call plug#end()
