vim9script

# {{{ All plugin groups.
if !exists('g:plugin_group')
	g:plugin_group = [
		'basic',
		'ui',
		'enhanced',
		'lsp',
		'debug',
	]
endif
# }}}

# {{{ Plugin group config.
# {{{ Basic plugins.
if index(g:plugin_group, 'basic') >= 0
	g:basic_plugin = [
		'auto_pairs',
		'easy_motion',
		'strip_whitespace',
		'match-up'
	]
endif
# }}}

# {{{ UI plugins.
if index(g:plugin_group, 'ui') >= 0
	g:ui_plugin = [
		'gruvbox',
		'startify',
		'rainbow',
		'cpp_enhanced_highlight',
		'indent_line',
		'lightline',
		'quickui',
		'which_key'
	]
endif
# }}}

# {{{ Enhanced plugins.
if index(g:plugin_group, 'enhanced') >= 0
	g:enhanced_plugin = [
		'floaterm',
		'tag',
		'git',
		'dirvish',
		'snippets',
		'asynctask',
		'fuzzy_search',
	]
endif
# }}}

# {{{ LSP plugins.
if index(g:plugin_group, 'lsp') >= 0
	g:lsp_plugin = [
		'coc',
	]
endif
# }}}

# {{{ Debug plugins.
if index(g:plugin_group, 'debug') >= 0
	g:debug_plugin = [
		'vimspector',
	]
endif
# }}}
# }}}

# {{{ Load plugins.
# Use vim-plug to manager all plugins.
# Specify a directory for plugins.
if has('unix')
	plug#begin('~/.vim/plugged')
elseif has('win32')
	plug#begin('~/vimfiles/plugged')
endif

# {{{ basic.
if index(g:plugin_group, 'basic') >= 0
	# {{{ auto-pairs.
	if index(g:basic_plugin, 'auto_pairs') >= 0
		# Insert or delete brackets, parens, quotes in pair.
		Plug 'Eliot00/auto-pairs'
	endif
	# }}}

	# {{{ easy motion.
	if index(g:basic_plugin, 'easy_motion') >= 0
		Plug 'monkoose/vim9-stargate'
	endif
	# }}}

	# {{{ strip trailing whitespace.
	if index(g:basic_plugin, 'strip_whitespace') >= 0
		# Strip trailing whitespace.
		Plug 'axelf4/vim-strip-trailing-whitespace'
	endif
	# }}}

	# {{{ enhance match
	if index(g:basic_plugin, "match-up") >= 0
		Plug 'andymass/vim-matchup'
	endif
	# }}}
endif
# }}}

# {{{ UI.
if index(g:plugin_group, 'ui') >= 0
	# {{{ gruvbox.
	if index(g:ui_plugin, 'gruvbox') >= 0
		Plug 'gruvbox-community/gruvbox'
	endif
	# }}}

	# {{{ startify.
	if index(g:ui_plugin, 'startify') >= 0
		# Show the start screen, display the recently edited files.
		Plug 'mhinz/vim-startify'
	endif
	# }}}

	# {{{ rainbow.
	if index(g:ui_plugin, 'rainbow') >= 0
		# Better rainbow paretheses.
		Plug 'luochen1990/rainbow'
	endif
	# }}}

	# {{{ cpp_enhanced_highlight.
	if index(g:ui_plugin, 'cpp_enhanced_highlight') >= 0
		# Additional Vim syntax highlight for C/C++.
		Plug 'bfrg/vim-cpp-modern'
	endif
	# }}}

	# {{{ indent_line.
	if index(g:ui_plugin, 'indent_line') >= 0
		Plug 'Yggdroot/indentLine'
	endif
	# }}}

	# {{{ lightline.
	if index(g:ui_plugin, 'lightline') >= 0
		Plug 'itchyny/lightline.vim'
		Plug 'mengelbrecht/lightline-bufferline'
	endif
	# }}}

	# {{{ quickui.
	if index(g:ui_plugin, 'quickui') >= 0
		Plug 'skywind3000/vim-quickui'
	endif
	# }}}

	# {{{ which_key.
	# Vim key mapping hint.
	if index(g:ui_plugin, 'which_key') >= 0
		Plug 'liuchengxu/vim-which-key'
	endif
	# }}}
endif
# }}}

# {{{ enhanced.
if index(g:plugin_group, 'enhanced') >= 0
	# {{{ floaterm.
	if index(g:enhanced_plugin, 'floaterm') >= 0
		Plug 'voldikss/vim-floaterm'
	endif
	# }}}

	# {{{ tag.
	if index(g:enhanced_plugin, 'tag') >= 0
		# Asynchronous generate tag file.
		Plug 'ludovicchabant/vim-gutentags'
		Plug 'skywind3000/gutentags_plus'
	endif
	# }}}

	# {{{ git.
	if index(g:enhanced_plugin, 'git') >= 0
		Plug 'tpope/vim-fugitive'
		Plug 'Eliot00/git-lens.vim'
		Plug 'airblade/vim-gitgutter'
	endif
	# }}}

	# {{{ dirvish.
	if index(g:enhanced_plugin, 'dirvish') >= 0
		Plug 'justinmk/vim-dirvish'
	endif
	# }}}

	# {{{ snippets.
	if index(g:enhanced_plugin, 'snippets') >= 0
		Plug 'SirVer/ultisnips'
		Plug 'honza/vim-snippets'
	endif
	# }}}

	# {{{ asynctask.
	if index(g:enhanced_plugin, 'asynctask') >= 0
		# Run asynchronous tasks.
		Plug 'skywind3000/asyncrun.vim'
		Plug 'skywind3000/asynctasks.vim'
	endif
	# }}}

	# {{{ fuzzy_search.
	if index(g:enhanced_plugin, 'fuzzy_search') >= 0
		Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}
		Plug 'skywind3000/Leaderf-snippet'
	endif
	# }}}
endif
# }}}

# {{{ lsp.
if index(g:plugin_group, 'lsp') >= 0
	# {{{ coc.
	if index(g:lsp_plugin, 'coc') >= 0
		Plug 'neoclide/coc.nvim', {'branch': 'release'}
	endif
	# }}}
endif
# }}}

# {{{ debug.
if index(g:plugin_group, 'debug') >= 0
	# {{{ vimspcetor.
	if index(g:debug_plugin, 'vimspector') >= 0
		Plug 'puremourning/vimspector'
	endif
	# }}}
endif
# }}}

# Initialize plugin system.
call plug#end()
# }}}

# {{{ Config plugins.
# {{{ basic.
if index(g:plugin_group, 'basic') >= 0
	# {{{ auto-pairs.
	if index(g:basic_plugin, 'auto_pairs') >= 0
		# Fast wrap.
		g:AutoPaisShortcutFastWrap = '<M-e>'
	endif
	# }}}

	# {{{ easy motion.
	if index(g:basic_plugin, 'easy_motion') >= 0
		# How should VIM9000 call you.
		g:stargate_name = 'Master'

		# For 1 character to search before showing hints.
		noremap <leader>f <Cmd>call stargate#OKvim(1)<CR>
		# For 2 consecutive characters to search.
		noremap <leader>F <Cmd>call stargate#OKvim(2)<CR>

		# Move between windows.
		nnoremap <leader>w <Cmd>call stargate#Galaxy()<CR>

		# For the start of a line
		noremap <leader>l <Cmd>call stargate#OKvim('\_^')<CR>
	endif
	# }}}

	# {{{ strip trailing whitespace.
	if index(g:basic_plugin, 'strip_whitespace') >= 0
	endif
	# }}}

	# {{{ match-up
	if index(g:basic_plugin, 'match-up') >= 0
		g:matchup_matchparen_offscreen = {'method': 'popup'}
	endif
	# }}}
endif
# }}}

# {{{ UI.
if index(g:plugin_group, 'ui') >= 0
	# {{{ gruvbox.
	if index(g:ui_plugin, 'gruvbox') >= 0
		# Prevent the background color of Vim in tmux from displaying abnormally.
		# Refer: http://sunaku.github.io/vim-256color-bce.html
		if &term =~ '256color' && $TMUX != ''
			# Disable background color erase (BCE) so that color schemes render
			# properly when inside 256-color tmux and GNU screen.
			set t_ut=
		endif

		g:gruvbox_italic = 1
		set background=light
		augroup MyColorScheme
			au!
			au vimenter * ++nested colorscheme gruvbox
		augroup END
		# Use 24-bit (true-color) mode in Vim.
		if has('termguicolors')
			set termguicolors
		endif
	endif
	# }}}

	# {{{ startify.
	if index(g:ui_plugin, 'startify') >= 0
		# Hide <empty buffer> and <quit>.
		g:startify_enable_special = 0

		# Header.
		g:asciiArt = [
					\  '__  __ _  __  __ ',
					\  '\ \/ /| ||  \/  |',
					\  ' \__/ |_||_|\/|_|',
		]
		g:startify_custom_header = 'startify#center(g:asciiArt)'

		# Ignore some files.
		g:startify_skiplist = [
			# Vimcfg files.
			escape(fnamemodify(expand('<sfile>:p:h'), ':h'), '\')
		]
	endif
	# }}}

	# {{{ rainbow.
	if index(g:ui_plugin, 'rainbow') >= 0
		g:rainbow_active = 1
	endif
	# }}}

	# {{{ cpp_enhanced_highlight.
	if index(g:ui_plugin, 'cpp_enhanced_highlight') >= 0
	endif
	# }}}

	# {{{ indent_line.
	if index(g:ui_plugin, 'indent_line') >= 0
		g:indentLine_setColors = 0
		# Make quotation marks visible in JSON.
		g:vim_json_conceal = 0

		# Specify suport file types.
		g:indentLine_fileType = ['c', 'cpp', 'vim', 'python']
	endif
	# }}}

	# {{{ lightline.
	if index(g:ui_plugin, 'lightline') >= 0
		# {{{ lightline.
		set noshowmode
		set laststatus=2

		g:lightline = {
			'colorscheme': 'solarized',
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
		# }}}

		# {{{ lightline-bufferline.
		# Always show tabline.
		set showtabline=2

		# Add the ordinal buffer number to the buffer name.
		g:lightline#bufferline#show_number = 2

		# Use unicode superscript numerals as buffer number.
		g:lightline#bufferline#composed_number_map = {
			0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
			5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
		}

		# Move between buffers.
		nmap <space>[ <Plug>lightline#bufferline#go_previous()
		nmap <space>] <Plug>lightline#bufferline#go_next()

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
		nmap <leader>c1 <ScriptCmd>call DeleteBufferAndUpdateBufferline(1)<CR>
		nmap <leader>c2 <ScriptCmd>call DeleteBufferAndUpdateBufferline(2)<CR>
		nmap <leader>c3 <ScriptCmd>call DeleteBufferAndUpdateBufferline(3)<CR>
		nmap <leader>c4 <ScriptCmd>call DeleteBufferAndUpdateBufferline(4)<CR>
		nmap <leader>c5 <ScriptCmd>call DeleteBufferAndUpdateBufferline(5)<CR>
		nmap <leader>c6 <ScriptCmd>call DeleteBufferAndUpdateBufferline(6)<CR>
		nmap <leader>c7 <ScriptCmd>call DeleteBufferAndUpdateBufferline(7)<CR>
		nmap <leader>c8 <ScriptCmd>call DeleteBufferAndUpdateBufferline(8)<CR>
		nmap <leader>c9 <ScriptCmd>call DeleteBufferAndUpdateBufferline(9)<CR>
		nmap <leader>c0 <ScriptCmd>call DeleteBufferAndUpdateBufferline(10)<CR>

		# it's strange that sometimes filename still appear in bufferline
		# after deleting it with lightline#bufferline#delete(), force to update
		# bufferline after deleting a buffer to avoid it
		def DeleteBufferAndUpdateBufferline(n: number): void
			lightline#bufferline#delete(n)
			lightline#bufferline#reload()
		enddef
		# }}}
	endif
	# }}}

	# {{{ quickui.
	if index(g:ui_plugin, 'quickui') >= 0
		g:quickui_show_tip = 1
		g:quickui_border_style = 2
		g:quickui_color_scheme = 'gruvbox'

		# {{{ Menubar.
		noremap <space><space> <Cmd>call quickui#menu#open()<CR>

		# Clear all the menus.
		quickui#menu#reset()

		# quickui#menu#install(section, items [, weight, [, filetypes]])
		# Use [text, command, tip(optional)] to represent an item.
		# {{{ Build.
		quickui#menu#install('&Build', [
			[ "&Build\tF4", 'AsyncTask file-build', 'build current file' ],
			[ "Build &Debug\tS+F4", 'AsyncTask file-debug-build', 'build current file for debug' ],
			['--', ''],
			[ '&Clean', 'AsyncTask file-clean', 'clean the executable' ],
		])
		# }}}

		# {{{ Project.
		quickui#menu#install('&Project', [
			[ "&Config\tS+F7", 'AsyncTask project-config', 'config project' ],
			[ "&Build\tF7", 'AsyncTask project-build', 'build project' ],
			[ '--', ''],
			[ "Clea&n", 'AsyncTask project-clean', 'clean project' ],
			[ '--', '' ],
			[ '&Set Style', 'AsyncTask set-code-style', 'set code style' ],
		])
		# }}}

		# {{{ Debug.
		quickui#menu#install('&Debug', [
			[ "&Run\tF5", 'AsyncTask file-run', 'run current file' ],
			[ "R&un Project\tF6", 'AsyncTask project-run', 'run project' ],
			[ '--', '' ],
			[ "&Debug\tS+F5", 'call vimspector#Continue()' ],
			[ "Toggle &Breakpoint\tF9", 'call vimspector#ToggleBreakpoint()' ],
			[ "Toggle &Conditional Breakpoint\tS+F9", 'call vimspector#ToggleAdvancedBreakpoint()' ],
		])
		# }}}

		# {{{ Tools.
		def g:SetIndentSize(): void
			var prompt = 'Set indent size: '
			var num = str2nr(quickui#input#open(prompt))
			if num == 0 # Indent size shouldn't be 0 or empty.
				return
			endif
			&l:shiftwidth = num
			&l:tabstop = num
			&l:softtabstop = num
		enddef
		def g:OpenIndentMenu(): void
			var content = [
				[ 'Toggle Indent &Line', 'IndentLinesToggle' ],
				[ 'Set Indent &Size', 'call g:SetIndentSize()' ],
			]
			var opts = {'title': 'Indent Menu'}

			quickui#listbox#open(content, opts)
		enddef
		# Script inside %{...} will be evaluated and expanded in the string.
		quickui#menu#install('&Tools', [
			[ 'Set Highligh&t Search %{&hlsearch ? "Off" : "On"}', 'set hlsearch!', 'toggle highlight search' ],
			[ 'Set &Spell Check %{&spell ? "Off" : "On"}', 'set spell!', 'toggle spell check' ],
			[ 'Open &Indent Menu', 'call g:OpenIndentMenu()' ],
			[ 'Toogle &Git Lens', 'call ToggleGitLens()' ],
		])
		# }}}
		# }}}

		# {{{ Message textbox.
		# Display vim messages in the textbox.
		nnoremap <space>m <ScriptCmd>call DisplayMessages()<CR>
		def DisplayMessages(): void
			var x = ''
			redir => x
			silent! messages
			redir END
			x = substitute(x, '[\n\r]\+\%$', '', 'g')
			var content = split(x, "\n")
			var opts = {'close': 'button', 'title': 'Vim Messages'}
			quickui#textbox#open(content, opts)
		enddef
		# }}}

		augroup MyQuickUi
			au!
			au FileType qf noremap <silent><buffer> p :call quickui#tools#preview_quickfix()<cr>
		augroup END
	endif
	# }}}

	# {{{ which_key.
	# Vim key mapping hint.
	if index(g:ui_plugin, 'which_key') >= 0
		set timeoutlen=500

		g:leader_map = {}
		g:space_map = {}

		nnoremap <silent> <leader> :<C-u>WhichKey '\'<CR>
		nnoremap <silent> <space> :<C-u>WhichKey ' '<CR>

		# {{{ Leader keymaps.

		# {{{ leader.
		g:leader_map = {
			'1': 'which_key_ignore',
			'2': 'which_key_ignore',
			'3': 'which_key_ignore',
			'4': 'which_key_ignore',
			'5': 'which_key_ignore',
			'6': 'which_key_ignore',
			'7': 'which_key_ignore',
			'8': 'which_key_ignore',
			'9': 'which_key_ignore',
			'0': 'which_key_ignore',
		}
		# }}}

		g:leader_map.a = 'apply-code-action'

		# {{{ c.
		g:leader_map.c = {
			'name': '+cscope',
			'1': 'which_key_ignore',
			'2': 'which_key_ignore',
			'3': 'which_key_ignore',
			'4': 'which_key_ignore',
			'5': 'which_key_ignore',
			'6': 'which_key_ignore',
			'7': 'which_key_ignore',
			'8': 'which_key_ignore',
			'9': 'which_key_ignore',
			'0': 'which_key_ignore',
			'a': 'where-current-symbol-is-assigned',
			'c': 'functions-calling-this-function',
			'd': 'functions-called-by-this-function',
			'e': 'egrep-pattern-under-cursor',
			'f': 'filename-under-cursor',
			'g': 'symbol-definition',
			'i': 'files-#including-the-filename-under-cursor',
			't': 'text-string',
			's': 'symbol-reference',
			'z': 'current-word',
		}
		# }}}

		g:leader_map.f = 'search-1-char'

		g:leader_map.F = 'search-2-char'

		g:leader_map.l = 'go-to-line'

		g:leader_map.o = 'toggle-outline'

		# {{{ r.
		g:leader_map.r = {
			'name': '+refactor/rename-symbol',
			'f': 'refactor',
			'n': 'rename-symbol',
		}
		# }}}

		g:leader_map.w = 'move-to-window'
		# }}}

		# {{{ Space keymaps.

		# {{{ space.
		g:space_map = {
			'[': 'which_key_ignore',
			']': 'which_key_ignore',
		}
		# }}}

		# {{{ a.
		g:space_map.a = {
			'name': '+asynctask',
			'q': 'query-available-tasks'
		}
		# }}}

		# {{{ c.
		g:space_map.c = {
			'name': '+coc',
			'c': 'show-coc-commands',
			'd': 'show-all-diagnostics',
			'e': 'manage-extensions',
			'j': 'do-default-action-for-next-item',
			'k': 'do-default-action-for-prev-item',
			'p': 'resume-latest-coc-list',
			's': 'search-document-symbols',
			'S': 'search-workspace-symbols',
			't': 'translate',
		}
		# }}}

		# {{{ f.
		g:space_map.f = {
			'name': '+format-code',
			'c': 'format code',
		}
		# }}}

		g:space_map.m = 'display-message'

		# {{{ q.
		g:space_map.q = {
			'name': '+quick-fix',
			'f': 'quick-fix',
		}
		# }}}

		# {{{ s.
		g:space_map.s = {
			'name': '+search',
			'b': 'buffer',
			'f': 'file',
			'l': 'line',
			'm': 'MRU file',
			'n': 'function',
			't': 'tag'
		}
		# }}}

		# }}}

		call which_key#register('\', "g:leader_map")
		call which_key#register(' ', "g:space_map")
	endif
	# }}}
endif
# }}}

# {{{ enhanced.
if index(g:plugin_group, 'enhanced') >= 0
	# {{{ floaterm.
	if index(g:enhanced_plugin, 'floaterm') >= 0
		# Terminal style.
		g:floaterm_position = 'bottomright'

		# Close window if the job exits normally.
		g:floaterm_autoclose = 1
		# Kill all floaterm instance when quit vim.
		augroup MyFloaterm
			au!
			au QuitPre * execute 'FloatermKill!'
		augroup END

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
	endif
	# }}}

	# {{{ tag.
	if index(g:enhanced_plugin, 'tag') >= 0
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
	# }}}

	# {{{ git.
	if index(g:enhanced_plugin, 'git') >= 0
	endif
	# }}}

	# {{{ dirvish.
	if index(g:enhanced_plugin, 'dirvish') >= 0
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
	# }}}

	# {{{ snippets.
	if index(g:enhanced_plugin, 'snippets') >= 0
		g:UltiSnipsSnippetDirectories = ['UltiSnips', 'config/UltiSnips']

		g:UltiSnipsExpandTrigger = '<C-l>'
		g:UltiSnipsJumpForwardTrigger = '<C-j>'
		g:UltiSnipsJumpBackwardTrigger = '<C-k>'
	endif
	# }}}

	# {{{ asynctask.
	if index(g:enhanced_plugin, 'asynctask') >= 0
		# Extra config file.
		if has('unix')
			g:asynctasks_extra_config = ['~/.vim/vimcfg/config/tasks.ini']
		elseif has('win32')
			g:asynctasks_extra_config = ['~/vimfiles/vimcfg/config/tasks.ini']
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

		# Open/close the Quickfic window.
		nnoremap <F10> <Cmd>call asyncrun#quickfix_toggle(g:asyncrun_open)<CR>

		# Shortcut for single file tasks.
		# Compile single file.
		nnoremap <F4> <Cmd>AsyncTask file-build<CR>
		# Complie single file with debug info.
		nnoremap <S-F4> <Cmd>AsyncTask file-debug-build<CR>
		# Run the program.
		nnoremap <F5> <Cmd>AsyncTask file-run<CR>

		# Shortcut for project tasks.
		# Configure project.
		nnoremap <S-F7> <Cmd>AsyncTask project-config<CR>
		# Build project.
		nnoremap <F7> <Cmd>AsyncTask project-build<CR>
		# Run project.
		nnoremap <F6> <Cmd>AsyncTask project-run<CR>

		# Query available tasks.
		nnoremap <space>aq <Cmd>AsyncTaskList<CR>
	endif
	# }}}

	# {{{ fuzzy_search.
	if index(g:enhanced_plugin, 'fuzzy_search') >= 0
		g:Lf_IgnoreCurrentBufferName = 1

		# Popup mode.
		g:Lf_WindowPosition = 'popup'
		g:Lf_PreviewInPopup = 1

		# Search files.
		g:Lf_ShortcutF = '<space>sf'
		noremap <space>sb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
		noremap <space>sm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
		noremap <space>st :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
		noremap <space>sl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
		# Search functions.
		nnoremap <space>sn <Cmd>LeaderfFunction<CR>

		inoremap <C-x><C-x> <C-\><C-o>:Leaderf snippet<CR>
	endif
	# }}}
endif
# }}}

# {{{ lsp.
if index(g:plugin_group, 'lsp') >= 0
	# {{{ coc.
	if index(g:lsp_plugin, 'coc') >= 0
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

		# Use tab for trigger completion with characters ahead and navigate.
		inoremap <silent><expr> <tab>
					\ coc#pum#visible() ? coc#pum#next(1) :
					\ <SID>CheckBackspace() ? "\<tab>" :
					\ coc#refresh()
		inoremap <silent><expr><S-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
		def CheckBackspace(): bool
			var col = col('.') - 1
			return !col || getline('.')[col - 1] =~# '\s'
		enddef

		# Make <CR> to accept selected completion item.
		inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() :
					\ "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

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
		nnoremap K <ScriptCmd>call ShowDocumentation()<CR>
		def ShowDocumentation(): void
			if g:CocAction('hasProvider', 'hover')
				g:CocActionAsync('doHover')
			else
				feedkeys('K', 'in')
			endif
		enddef

		# Symbol renaming.
		nmap <leader>rn <Plug>(coc-rename)

		# Refactor.
		nmap <leader>rf <Plug>(coc-refactor)

		# Formating code.
		nnoremap <space>fc <Cmd>call CocActionAsync('format')<CR>

		# Applying codeAction to the selected code block.
		xmap <leader>a <Plug>(coc-codeaction-selected)
		nmap <leader>a <Plug>(coc-codeaction-selected)

		# Apply AutoFix to problem on the current line.
		nmap <space>qf <Plug>(coc-fix-current)

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
		nnoremap <leader>o <ScriptCmd>call ToggleCocOutline()<CR>
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
		nnoremap <nowait> <space>cd <Cmd>CocList diagnostics<CR>
		# Manage extensions.
		nnoremap <nowait> <space>ce <Cmd>CocList extensions<CR>
		# Show commands.
		nnoremap <nowait> <space>cc <Cmd>CocList commands<CR>
		# Find symbol of current document.
		nnoremap <nowait> <space>cs <Cmd>CocList outline<CR>
		# Search workspace symbols.
		nnoremap <nowait> <space>cS <Cmd>CocList -I symbols<CR>
		# Do default action for next item.
		nnoremap <nowait> <space>cj <Cmd>CocNext<CR>
		# Do default action for previous item.
		nnoremap <nowait> <space>ck <Cmd>CocPrev<CR>
		# Resume latest coc list.
		nnoremap <nowait> <space>cp <Cmd>CocListResume<CR>

		# coc-translator.
		nmap <space>ct <Plug>(coc-translator-p)
		vmap <space>ct <Plug>(coc-translator-pv)
	endif
	# }}}
endif
# }}}

# {{{ debug.
if index(g:plugin_group, 'debug') >= 0
	# {{{ vimspcetor.
	if index(g:debug_plugin, 'vimspector') >= 0
		nmap <silent> <S-F5> <Plug>VimspectorContinue
		nmap <silent> <F9> <Plug>VimspectorToggleBreakpoint
		nmap <silent> <S-F9> <Plug>VimspectorToggleConditionalBreakpoint

		augroup MyVimspector
			au!
			au User VimspectorUICreated CustomizeWinBar()
			au User VimspectorJumpedToFrame OnJumpToFrame()
			au User VimspectorDebugEnded ++nested OnDebugEnd()
		augroup END

		# Customize UI {{{
		def CustomizeWinBar(): void
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
	# }}}
endif
# }}}
# }}}
