"-
" plugins.vim - Plugins config.
"
" Created by vamirio on 2021 Nov 08
"-

" Default groups.
if !exists('g:plugin_group')
	let g:plugin_group = ['basic', 'enhanced', 'tags']
	let g:plugin_group += ['lightline', 'dirvish', 'coc', 'debug']
	let g:plugin_group += ['asynctask', 'which_key']
endif

" Use vim-plug to manager all plunins.
" Specify a directory for plugins.
if has('unix')
	call plug#begin('~/.vim/plugged')
elseif has('win32')
	call plug#begin('~/vimfiles/plugged')
endif

" Basic plugins.
if index(g:plugin_group, 'basic') >= 0
	" Color scheme.
	Plug 'morhetz/gruvbox'

	" Show the start screen, display the recently edited files.
	Plug 'mhinz/vim-startify'

	"-
	" vim-startify
	"-
	" The dir to save/load sessions to/from.
	let g:startify_session_dir = '~/.vim/session'
endif

" Enhanced plugins.
if index(g:plugin_group, 'enhanced') >= 0
	" Insert or delete brackets, parens, quotes in pair.
	Plug 'jiangmiao/auto-pairs'

	" Better rainbow paretheses.
	Plug 'kien/rainbow_parentheses.vim'

	" Strip trailing whitespace.
	Plug 'axelf4/vim-strip-trailing-whitespace'

	" Float terminal.
	Plug 'voldikss/vim-floaterm'

	" Indent line.
	Plug 'Yggdroot/indentLine', { 'for': 'python' }

	" Additional Vim syntax highlight for C/C++.
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

	" Git.
	Plug 'tpope/vim-fugitive'

	"-
	" auto-pairs
	"-
	" Open fly mode.
	let g:AutoPairsFlayMode = 1

	" Work in FlyMode, insert the key at the Fly Mode jumped postion.
	let g:AutoPairsShortcutBackInsert = '<M-b>'


	"-
	" rainbow_parentheses
	"-
	" Set color of parentheses.
	let g:rbpt_colorpairs = [
		\ ['brown',		  'RoyalBlue3'],
		\ ['Darkblue',	  'SeaGreen3'],
		\ ['darkgray',	  'DarkOrchid3'],
		\ ['darkgreen',   'firebrick3'],
		\ ['darkcyan',	  'RoyalBlue3'],
		\ ['darkred',	  'SeaGreen3'],
		\ ['darkmagenta', 'DarkOrchid3'],
		\ ['brown',		  'firebrick3'],
		\ ['gray',		  'RoyalBlue3'],
		\ ['black',		  'SeaGreen3'],
		\ ['darkmagenta', 'DarkOrchid3'],
		\ ['Darkblue',	  'firebrick3'],
		\ ['darkgreen',   'RoyalBlue3'],
		\ ['darkcyan',	  'SeaGreen3'],
		\ ['red',		  'firebrick3'],
		\ ['darkred',	  'DarkOrchid3'],
	\ ]

	let g:rbpt_max = 16
	let g:rbpt_loadcmd_toggle = 0

	augroup MyRainbowParentheses
		au!
		au VimEnter * RainbowParenthesesToggle
		au Syntax * RainbowParenthesesLoadRound
		au Syntax * RainbowParenthesesLoadSquare
		au Syntax * RainbowParenthesesLoadBraces
	augroup END

	"-
	" vim-floaterm
	"-
	let g:floaterm_wintype = 'vsplit'
	let g:floaterm_width = 0.4
	let g:floaterm_height = 0.5
	let g:floaterm_position = 'botright'
	let g:floaterm_opener = 'vsplit'

	" Open or hide the floaterm window.
	let g:floaterm_keymap_toggle = '<M-=>'
	" Open a new floaterm window.
	let g:floaterm_keymap_new = '<M-+>'
	" Switch to the previous floaterm instance.
	let g:floaterm_keymap_prev = '<M-,>'
	" Switch to the next floaterm instance
	let g:floaterm_keymap_next = '<M-.>'
	" Close the current terminal instance.
	let g:floaterm_keymap_kill = '<M-->'

	" Close window if the job exits normally.
	let g:floaterm_autoclose = 1
	" Kill all floaterm instance when quit vim.
	augroup MyFloaterm
		au!
		au QuitPre * execute "FloatermKill!"
	augroup END
endif

" Auto generate ctags/gtags and provide auto indexing function.
if index(g:plugin_group, 'tags') >= 0
	" Asynchronous generate tag file.
	Plug 'ludovicchabant/vim-gutentags'
	Plug 'skywind3000/gutentags_plus'

	"-
	" vim-gutentags
	"-
	" Set root dir of a project.
	let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

	" Set ctags file name.
	let g:gutentags_ctas_tagfile = '.tags'

	" Detect dir ~/.cache/tags, create new one if it doesn't exist.
	let s:vim_tags = expand('~/.cache/tags')
	if !isdirectory(s:vim_tags)
		silent! call mkdir(s:vim_tags, 'p')
	endif

	" Set dir to save the tag file.
	let g:gutentags_cache_dir = s:vim_tags

	" Use a ctags-compatible program to generate a tags file and
	" GNU's gtags to generate a code database file.
	let g:gutentags_modules = []
	if executable('ctags')
		let g:gutentags_modules += ['ctags']
	endif
	if executable('gtags-cscope') && executable('gtags')
		let g:gutentags_modules += ['gtags_cscope']
	endif

	" Set ctags arguments.
	let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
	let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
	let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

	" Use universal-ctags.
	let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

	" Config gutentags whitelist.
	let g:gutentags_exclude_filetypes = ['text']

	" Prevent gutentags from autoloading gtags database.
	let g:gutentags_auto_add_gtags_cscope = 0

	"-
	" gutentags_plus
	"-
	" Change focus to quickfix window after search.
	let g:gutentags_plus_switch = 1
endif

" Lightline.
if index(g:plugin_group, 'lightline') >= 0
	Plug 'itchyny/lightline.vim'
	Plug 'mengelbrecht/lightline-bufferline'

	let g:lightline = {
		\ 'colorscheme': 'one',
		\ 'active': {
			\ 'left': [ [ 'mode', 'paste' ],
		    \           [ 'gitstatus', 'cocstatus', 'readonly', 'filename',
			\             'modified' ] ]
		\ },
		\ 'component_function': {
			\ 'gitstatus': 'FugitiveStatusline',
			\ 'cocstatus': 'coc#status'
		\ },
		\ 'tabline': {
			\ 'left': [ [ 'buffers' ] ],
			\ 'right': [ [ '' ] ]
		\ },
		\ 'component_expand': {
			\ 'buffers': 'lightline#bufferline#buffers'
		\ },
		\ 'component_type': {
			\ 'buffers': 'tabsel'
		\ }
	\ }

	" Force lightline update.
	augroup MyLightline
		au!
		au User CocStatusChange,CocDiagnosticChange call lightline#update()
	augroup END

	" Always show tabline.
	set showtabline=2

	" Add the ordinal buffer number to the buffer name.
	let g:lightline#bufferline#show_number = 2

	" Use unicode superscipt numerals as buffer number.
	let g:lightline#bufferline#composed_number_map = {
		\ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
		\ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}

	" Quick switch to buffers using their ordinal number.
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

	" Quick delete buffers by their ordinal number.
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

" Dirvish.
if index(g:plugin_group, 'dirvish') >= 0
	Plug 'justinmk/vim-dirvish'

	" Sort and hide files, then locate related file.
	function! s:SetupDirvish()
		if &buftype != 'nofile' && &filetype != 'dirvish'
			return
		endif
		if has('nvim')
			return
		endif
		" Get current filename.
		let text = getline('.')
		if !get(g:, 'dirvish_hide_visible', 0)
			execute 'silent keeppatterns g@\v[\/]\.[^\/]+[\/]?$@d _'
		endif
		" Sort filename.
		execute 'sort ,^.*[\/],'
		let name = '^' . escape(text, '.*[]~\') . '[/*|@=|\\*]\=\%($\|\s\+\)'
		" Locate to current file.
		call search(name, 'wc')
		nnoremap <silent><buffer> ~ :Dirvish ~<CR>
	endfunction

	augroup MyDirvish
		au!
		au FileType dirvish call s:SetupDirvish()
	augroup END
endif

" Coc-nvim.
if index(g:plugin_group, 'coc') >= 0
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	"-
	" coc.nvim
	"-
	" For better diagnostic messages experience.
	set updatetime=300

	" Always show the signcolumn, otherwise it would shift the text each
	" time diagnostics appear/become resolved.
	set signcolumn=yes

	" Use tab for trigger completion with characters ahead and navigate.
	inoremap <silent><expr> <tab>
				\ coc#pum#visible() ? coc#pum#next(1) :
				\ <SID>CheckBackspace() ? "\<tab>" :
				\ coc#refresh()
	inoremap <expr><S-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

	" Confirm the completion when popupmenu is visible, insert <CR> and
	" notify coc.nvim otherwise.
	inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
				\ : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

	function! s:CheckBackspace() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1] =~# '\s'
	endfunction

	" Use <C-space> to trigger completion.
	inoremap <silent><expr> <C-@> coc#refresh()

	" Goto code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gc <Plug>(coc-declaration)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Jump to previous diagnostic.
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	" Jump to next diagnostic.
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>ShowDocumentation()<CR>
	function! s:ShowDocumentation()
		if CocAction('hasProvider', 'hover')
			call CocActionAsync('doHover')
		else
			call feedkeys('K', 'in')
		endif
	endfunction

	" Symbol renaming.
	nmap <leader>rn <Plug>(coc-rename)

	" Formating code.
	nnoremap <silent> <space>ft :call CocActionAsync('format')<CR>

	" Apply AutoFix to problem on the current line.
	nmap <space>qf <Plug>(coc-fix-current)

	" Translation.
	" Popup.
	nmap <space>tt <Plug>(coc-translator-p)
	vmap <space>tt <Plug>(coc-translator-pv)
	" Echo.
	nmap <space>te <Plug>(coc-translator-e)
	vmap <space>te <Plug>(coc-translator-ev)
	" Replace.
	nmap <space>tr <Plug>(coc-translator-r)
	vmap <space>tr <Plug>(coc-translator-rv)

	" Remap <C-f> and <C-b> for scroll float window/popups.
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

	nnoremap <silent><nowait> <space>co  :call <SID>ToggleCocOutline()<CR>
	function! s:ToggleCocOutline() abort
		let winid = coc#window#find('cocViewId', 'OUTLINE')
		if winid == -1
			call CocActionAsync('showOutline', 1)
		else
			call coc#window#close(winid)
		endif
	endfunction

	" Mapping for CocList.
	" Show all diagnostics.
	nnoremap <silent><nowait> <space>cld :<C-u>CocList diagnostics<CR>
	" Manage extensions.
	nnoremap <silent><nowait> <space>cle :<C-u>CocList extensions<CR>
	" Show commands.
	nnoremap <silent><nowait> <space>clc :<C-u>CocList commands<CR>
	" Find symbol of current document.
	nnoremap <silent><nowait> <space>clo :<C-u>CocList outline<CR>
	" Search workspace symbols.
	nnoremap <silent><nowait> <space>cls :<C-u>CocList -I symbols<CR>
	" Do default action for next item.
	nnoremap <silent><nowait> <space>clj :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent><nowait> <space>clk :<C-u>CocPrev<CR>
	" Resume latest coc list.
	nnoremap <silent><nowait> <space>clp :<C-u>CocListResume<CR>

	augroup MyCocNvim
		au!
		" Highlight symbol and its references when holding the cursor.
		au CursorHold * silent call CocActionAsync('highlight')
		" Set highlight color for completion menu.
		au VimEnter,ColorScheme * hi! CocMenuSel ctermbg=15 guibg=#FFFFFF
		" Setup formatexpr specified filetype(s).
		au FileType json setl formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder.
		au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup END

    "-
    " Snippets.
    "-
	let g:UltiSnipsSnippetDirectories = ["UltiSnips", "plugcfg/UltiSnips"]
	let g:UltiSnipsExpandTrigger = '<C-l>'
	let g:UltiSnipsJumpForwardTrigger = '<C-j>'
	let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
endif

" Debug.
if index(g:plugin_group, 'debug') >= 0
	Plug 'puremourning/vimspector'

	"-
	" vimspector
	"-
	nmap <silent> <S-F5> <Plug>VimspectorContinue
	nmap <silent> <F9> <Plug>VimspectorToggleBreakpoint
	nmap <silent> <S-F9> <Plug>VimspectorToggleConditionalBreakpoint

	augroup MyVimspector
		au!
		au User VimspectorUICreated call s:CustomiseWinBar()
		au User VimspectorJumpedToFrame call s:OnJumpToFrame()
		au User VimspectorDebugEnded ++nested call s:OnDebugEnd()
	augroup END

	" Customise UI {{{
	function! s:CustomiseWinBar()
		call win_gotoid(g:vimspector_session_windows.code)
		" Clear the existing WinBar created by Vimspector.
		nunmenu WinBar
		" Create new WinBar.
		nnoremenu WinBar.▷ :call vimspector#Continue()<CR>
		nnoremenu WinBar.↷ :call vimspector#StepOver()<CR>
		nnoremenu WinBar.↓ :call vimspector#StepInto()<CR>
		nnoremenu WinBar.↑ :call vimspector#StepOut()<CR>
		nnoremenu WinBar.❘❘ :call vimspector#Pause()<CR>
		nnoremenu WinBar.□ :call vimspector#Stop()<CR>
		nnoremenu WinBar.⟲ :call vimspector#Restart()<CR>
		nnoremenu WinBar.✕ :call vimspector#Reset()<CR>
	endfunction
	" }}}

	" Custom mappings while debuggins. {{{
	let s:vimspector_mapped = {}

	function! s:OnJumpToFrame() abort
		if has_key(s:vimspector_mapped, string(bufnr()))
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

		let s:vimspector_mapped[string(bufnr())] = { 'modifiable': &modifiable }

		setlocal nomodifiable
	endfunction

	function! s:OnDebugEnd() abort
		let original_buf = bufnr()
		let hidden = &hidden
		augroup MyVimspectorSwapExists
			au!
			au SwapExists * let v:swapchoice='o'
		augroup END

		try
			set hidden
			for bufnr in keys(s:vimspector_mapped)
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

					let &modifiable = s:vimspector_mapped[bufnr]['modifiable']
				endtry
			endfor
		finally
			execute 'noautocmd buffer' original_buf
			let &hidden = hidden
		endtry

		au! MyVimspectorSwapExists

		let s:vimspector_mapped = {}
	endfunction
	" }}}
endif

" Execute tasks asynchronously.
if index(g:plugin_group, 'asynctask') >= 0
	" Run asynchronous tasks.
	Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun', 'AsyncStop'] }
	Plug 'skywind3000/asynctasks.vim', { 'on': ['AsyncTask', 'AsyncTaskMacro', 'AsyncTaskList', 'AsyncTaskEdit'] }

	"-
	" AsyncTasks, AsyncRun
	"-
	" Extra config file.
	if has('unix')
		let g:asynctasks_extra_config = ['~/.vim/vimcfg/plugcfg/tasks.ini']
	elseif has('win32')
		let g:asynctasks_extra_config = ['~/vimfiles/vimcfg/plugcfg/tasks.ini']
	endif

	" Automatically open Qickfix window with a height of 6.
	let g:asyncrun_open = 6

	" Bell when finish the task.
	let g:asyncrun_bell = 0

	" Open/close the Quickficx window.
	nnoremap <silent> <F10> :call asyncrun#quickfix_toggle(6)<CR>

	" Specify what terminal to use.
	let g:asynctasks_term_pos = 'tab'

	" Reuse a terminal.
	let g:asynctasks_term_reuse = 1

	" Shortcut for single file tasks.
	" Compile single file.
	nnoremap <silent> <F4> :AsyncTask file-build<CR>
	" Complie single file with debug info.
	nnoremap <silent> <S-F4> :AsyncTask file-debug<CR>
	" Run the program.
	nnoremap <silent> <F5> :AsyncTask file-run<CR>
	" Delete the executable file generated by current file.
	nnoremap <silent> <space>asd :AsyncTask exe-del<CR>

	" Set root dir for project.
	let g:asyncrun_rootmarks = ['.root', '.svn', '.git', '.project']

	" Shortcut for project tasks.
	" Set code style.
	nnoremap <silent> <space>aps :AsyncTask set-code-style<CR>

	" Shortcut for CMake project tasks.
	" Configure CMake project.
	nnoremap <silent> <S-F7> :AsyncTask cmake-project-config<CR>
	" Build CMake project.
	nnoremap <silent> <F7> :AsyncTask cmake-project-build<CR>
	" Run CMake project.
	nnoremap <silent> <F6> :AsyncTask cmake-project-run<CR>
	" Clean CMake project.
	nnoremap <silent> <S-F6> :AsyncTask cmake-project-clean<CR>

	" Query available tasks.
	nnoremap <silent> <space>aa :AsyncTaskList<CR>
endif

" Vim key mapping hint.
if index(g:plugin_group, 'which_key') >= 0
	Plug 'liuchengxu/vim-which-key'

	set timeoutlen=300

	let g:which_key_use_floating_win = 1
endif

" Initialize plugin system.
call plug#end()

"Plug 'Yggdroot/LeaderF'
