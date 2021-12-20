"-
" plugins.vim - plugins config
"
" Created by Vamirio on 2021 Nov 08
" Last Modified: 2021 Dec 20 17:00:21
"-

"-
" Default groups.
"-
if !exists('g:plugin_group')
	let g:plugin_group = ['basic', 'enhanced', 'tags', 'filetypes']
	let g:plugin_group += ['lightline', 'dirvish', 'coc', 'debug']
	let g:plugin_group += ['asynctask', 'quickui', 'language_tool']
endif

"-
" Use vim-plug to manager all plunins.
" Specify a directory for plugins.
"-
if has('unix')
	call plug#begin('~/.vim/plugged')
elseif has('win32')
	call plug#begin('~/vimfiles/plugged')
endif

"-
" Basic plugins.
"-
if index(g:plugin_group, 'basic') >= 0
	"-
	" Show the start screen, display the recently edited files.
	"-
	Plug 'mhinz/vim-startify'

	"-
	" vim-startify
	"-
	" The dir to save/load sessions to/from.
	let g:startify_session_dir = '~/.vim/session'
endif

"-
" Enhanced plugins
"-
if index(g:plugin_group, 'enhanced') >= 0
	"-
	" Insert or delete brackets, parens, quotes in pair.
	"-
	Plug 'jiangmiao/auto-pairs'

	"-
	" Better rainbow paretheses.
	"-
	Plug 'kien/rainbow_parentheses.vim'

	"-
	" Strip trailing whitespace.
	"-
	Plug 'axelf4/vim-strip-trailing-whitespace'

	"-
	" Float terminal.
	"-
	Plug 'voldikss/vim-floaterm'

	"-
	" Indent line.
	"-
	Plug 'Yggdroot/indentLine', { 'for': 'python' }

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


	autocmd VimEnter * RainbowParenthesesToggle
	autocmd Syntax * RainbowParenthesesLoadRound
	autocmd Syntax * RainbowParenthesesLoadSquare
	autocmd Syntax * RainbowParenthesesLoadBraces

	"-
	" vim-floaterm
	"-
	let g:floaterm_wintype = 'float'
	let g:floaterm_width = 0.4
	let g:floaterm_height = 0.99
	let g:floaterm_position = 'right'
	" toggle the terminal
	let g:floaterm_keymap_toggle = '<F12>'
	" close window if the job exits normally
	let g:floaterm_autoclose = 1
	" Kill all floaterm instance when quit vim.
	augroup Floaterm
		au!
		au QuitPre * execute "FloatermKill!"
	augroup END
endif


"-
" Auto generate ctags/gtags and provide auto indexing function.
"-
if index(g:plugin_group, 'tags') >= 0
	"-
	" Asynchronous generate tag file.
	"-
	Plug 'ludovicchabant/vim-gutentags'
	Plug 'skywind3000/gutentags_plus'

	"-
	" vim-gutentags
	"-
	" Set root dir of a project.
	let g:gutentags_project_root = ['.root', '.svn', '.git',
				\ '.project']

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
	let g:gutentags_modules = ['ctags', 'gtags_cscope']

	" Set ctags arguments.
	let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
	let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxl']
	let g:gutentags_ctags_extra_args += ['--c-kinds=+pxl']

	" Use universal-ctags.
	let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

	" Config gutentags whitelist.
	let gutentags_exclude_filetypes = ['text']

	"-
	" gutentags_plus
	"-
	" Change focus to quickfix window after search.
	let g:gutentags_plus_switch = 1
endif

"-
" Filetypes plugin.
"-
if index(g:plugin_group, 'filetypes') >= 0
	"-
	" Additional Vim sytax highlight for C++.
	"-
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

	"-
	" Preview markdown.
	"-
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app &&
				\ npm install', 'for': ['markdown'] }


	"-
	" markdown-preview
	"-
	" Auto open the preview window after entering the markdown buffer.
	let g:mkdp_auto_start = 1

	" Auto close current preview window when change from markdown
	" buffer to another buffer.
	let g:mkdp_auto_close = 1

	" Auto refresh markdown as editing or moving the cursor.
	let g:mkdp_refresh_slow = 0

	" Specify browser to open preview page.
	let g:mkdp_browser = 'firefox'

	" Preview page title.
	" ${name} will be replace with the file name.
	let g:mkdp_page_title = '[${name}]'

	" Recognized filetypes.
	" These filetypes will have MarkdownPreview... commands.
	let g:mkdp_filetype = ['markdown']
endif

"-
" Lightline.
"-
if index(g:plugin_group, 'lightline') >= 0
	Plug 'itchyny/lightline.vim'
	Plug 'mengelbrecht/lightline-bufferline'

	let g:lightline = {
		\ 'colorscheme': 'solarized',
		\ 'active': {
			\ 'left': [ [ 'mode', 'paste' ],
		    \           [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
		\ },
		\ 'component_function': {
			\ 'cocstatus': 'coc#status'
		\ },
		\ 'tabline': {
			\ 'left': [ [ 'buffers' ] ],
			\ 'right': [ [ 'close' ] ]
		\ },
		\ 'component_expand': {
			\ 'buffers': 'lightline#bufferline#buffers'
		\ },
		\ 'component_type': {
			\ 'buffers': 'tabsel'
		\ }
	\ }

	" Force lightline update.
	augroup lightline
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
	nmap <space>1<space> <Plug>lightline#bufferline#go(1)
	nmap <space>2<space> <Plug>lightline#bufferline#go(2)
	nmap <space>3<space> <Plug>lightline#bufferline#go(3)
	nmap <space>4<space> <Plug>lightline#bufferline#go(4)
	nmap <space>5<space> <Plug>lightline#bufferline#go(5)
	nmap <space>6<space> <Plug>lightline#bufferline#go(6)
	nmap <space>7<space> <Plug>lightline#bufferline#go(7)
	nmap <space>8<space> <Plug>lightline#bufferline#go(8)
	nmap <space>9<space> <Plug>lightline#bufferline#go(9)
	nmap <space>0<space> <Plug>lightline#bufferline#go(10)

	" Quick delete buffers by their ordinal number.
	nmap <space>c1<space> <Plug>lightline#bufferline#delete(1)
	nmap <space>c2<space> <Plug>lightline#bufferline#delete(2)
	nmap <space>c3<space> <Plug>lightline#bufferline#delete(3)
	nmap <space>c4<space> <Plug>lightline#bufferline#delete(4)
	nmap <space>c5<space> <Plug>lightline#bufferline#delete(5)
	nmap <space>c6<space> <Plug>lightline#bufferline#delete(6)
	nmap <space>c7<space> <Plug>lightline#bufferline#delete(7)
	nmap <space>c8<space> <Plug>lightline#bufferline#delete(8)
	nmap <space>c9<space> <Plug>lightline#bufferline#delete(9)
	nmap <space>c0<space> <Plug>lightline#bufferline#delete(10)
endif

"-
" Dirvish.
"-
if index(g:plugin_group, 'dirvish') >= 0
	Plug 'justinmk/vim-dirvish'
endif

"-
" Coc-nvim.
"-
if index(g:plugin_group, 'coc') >= 0
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'honza/vim-snippets'
	Plug 'SirVer/ultisnips'

	"-
	" coc.nvim
	"-
	" If hidden is not set, TextEdit might fail.
	set hidden

	" Better display for messages.
	set cmdheight=2

	" For better diagnostic messages experience.
	set updatetime=300

	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c

	" Always show the signcolumn, otherwise it would shift the text each
	" time diagnostics appear/become resolved.
	if has("patch-8.1-1564")
		set signcolumn=number
	else
		set signcolumn=yes
	endif

	" Use tab for trigger completion with characters ahead and navigate.
	inoremap <silent><expr> <tab>
				\ pumvisible() ? "\<C-n>" :
				\ <SID>check_back_space() ? "\<tab>" :
				\ coc#refresh()
	inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1] =~# '\s'
	endfunction

	" Goto code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gD <Plug>(coc-declaration)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implemention)
	nmap <silent> gr <Plug>(coc-references)

	" Jump to previous error.
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	" Jump to next error.
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>show_documentation()<CR>
	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h ' . expand('<cword>')
		elseif (coc#rpc#ready())
			call CocActionAsync('doHover')
		else
			execute '!' . &keywordprg . " " .expand('<cword>')
		endif
	endfunction

	" Highlight symbol and its references when holding the cursor.
	augroup coc_hightligt
		autocmd!
		autocmd CursorHold * silent call CocActionAsync('highlight')
	augroup END

	" Symbol renaming.
	nmap <space>rn<space> <Plug>(coc-rename)

	" Formating selected code.
	xmap <space>f<space> <Plug>(coc-format-selected)
	nmap <space>f<space> <Plug>(coc-format-selected)

	" Apply AutoFix to problem on the current line.
	nmap <space>qf<space> <Plug>(coc-fix-current)

	" Translation.
	" Popup.
	nmap <space>tt<space> <Plug>(coc-translator-p)
	vmap <space>tt<space> <Plug>(coc-translator-pv)
	" Echo.
	nmap <space>te<space> <Plug>(coc-translator-e)
	vmap <space>te<space> <Plug>(coc-translator-ev)
	" Replace.
	nmap <space>tr<space> <Plug>(coc-translator-r)
	vmap <space>tr<space> <Plug>(coc-translator-rv)

	" Remap <C-f> and <C-b> for scroll float window/popups.
	if has('nvim-0.4.0') || has('patch-8.2.0750')
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

	" Mapping for CocList.
	" Show all diagnostics.
	nnoremap <silent><nowait> <space>a<space> :<C-u>CocList diagnostics<CR>
	" Manage extensions.
	nnoremap <silent><nowait> <space>e<space> :<C-u>CocList extensions<CR>
	" Show commands.
	nnoremap <silent><nowait> <space>c<space> :<C-u>CocList commands<CR>
	" Find symbol of current document.
	nnoremap <silent><nowait> <space>o<space> :<C-u>CocList outline<CR>
	" Search workspace symbols.
	nnoremap <silent><nowait> <space>s<space> :<C-u>CocList -I symbols<CR>
	" Do default action for next item.
	nnoremap <silent><nowait> <space>j<space> :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent><nowait> <space>k<space> :<C-u>CocPrev<CR>
	" Resume lastest coc list.
	nnoremap <silent><nowait> <space>p<space> :<C-u>CocListResume<CR>

    "-
    " Snippets.
    "-
	let g:UltiSnipsSnippetDirectories = ["UltiSnips", "plugcfg/UltiSnips"]
	let g:UltiSnipsExpandTrigger = '<C-l>'
	let g:UltiSnipsJumpForwardTrigger = '<C-j>'
	let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
endif

"-
" Debug.
"-
if index(g:plugin_group, 'debug') >= 0
	"Plug 'puremourning/vimspector'

	"-
	" vimspector
	"-
	"let g:vimspector_enable_mappings = 'HUMAN'
endif

"-
" Execute tasks asynchronously.
"-
if index(g:plugin_group, 'asynctask') >= 0
	"-
	" Run asynchronous tasks.
	"-
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
	let g:asyncrun_bell = 1

	" Set <leader>q to open/close the Quickficx window.
	nnoremap <silent> <leader>q :call asyncrun#quickfix_toggle(6)<cr>

	" Specify what terminal to use.
	let g:asynctasks_term_pos = 'tab'

	" Reuse a terminal.
	let g:asynctasks_term_reuse = 1

	" Run the program.
	nnoremap <silent> <space>r<space> :AsyncTask file-run<CR>

	" Compile single file.
	nnoremap <silent> <space>c<space> :AsyncTask file-build<CR>

	" Complie single file with debug info.
	nnoremap <silent> <space>cd<space> :AsyncTask file-debug<CR>

	" Use gdbgui to debug.
	nnoremap <silent> <space>d<space> :AsyncTask file-gdbgui<CR>

	" Delete the executable file generated by current file.
	nnoremap <silent> <space>rm<space> :AsyncTask exe-del<CR>

	" Set root dir for make.
	let g:asyncrun_rootmarks = ['.root', '.svn', '.git', '.project']

	" Run current project.
	nnoremap <silent> <space>mr<space> :AsyncTask project-run<CR>

	" Run make.
	nnoremap <silent> <space>m<space> :AsyncTask project-build<CR>

	" Run make for debugging.
	nnoremap <silent> <space>md<space> :AsyncTask project-debug<CR>

	" Run make for cleaning.
	nnoremap <silent> <space>mc<space> :AsyncTask project-clean<CR>

	" Query available tasks.
	nnoremap <silent> <space>qat<space> :AsyncTaskList<CR>
endif

"-
" Quick UI
"-
if index(g:plugin_group, 'quickui') >= 0
	Plug 'skywind3000/vim-quickui'

	" Color scheme.
	let g:quickui_color_scheme = 'papercol dark'

	" Border style
	let g:quickui_border_style = 2

	" Preview help.
	nnoremap <F3> :call quickui#tools#preview_tag('')<CR>

	" Set the size of preview window.
	let g:quickui_preview_w = 77
	let g:quickui_preview_h = 10

	" Preview quickfix.
	augroup QuickfixPreview
		au!
		au FileType qf nnoremap <silent><buffer> p
					\ :call quickui#tools#preview_quickfix()<CR>
		au FileType qf nnoremap <silent><buffer> <C-f>
					\ :call quickui#preview#scroll(g:quickui_preview_h - 1)<CR>
		au FileType qf nnoremap <silent><buffer> <C-b>
					\ :call quickui#preview#scroll(1 - g:quickui_preview_h)<CR>
	augroup END
endif

"-
" Language tool - grammar check.
"-
if index(g:plugin_group, 'language_tool') >= 0
endif

"-
" Initialize plugin system.
"-
call plug#end()

"Plug 'Yggdroot/LeaderF'
