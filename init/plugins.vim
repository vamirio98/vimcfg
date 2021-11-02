"-------------------------------------------------------
" plugins.vim - plugins config
"
" Created by Haoyuan Li on 2021/02/15
" Last Modified: 2021 Nov 02 15:53:22
"-------------------------------------------------------


"-------------------------------------------------------
" default groups
"-------------------------------------------------------
if !exists('g:plugin_group')
	let g:plugin_group = ['basic', 'enhanced', 'tags', 'filetypes']
	let g:plugin_group += ['airline', 'dirvish', 'coc', 'debug']
	let g:plugin_group += ['asynctask', 'language_tool']
endif


"-------------------------------------------------------
" use vim-plug to manager all plunins
" specify a directory for plugins
"-------------------------------------------------------
if has('unix')
	call plug#begin('~/.vim/plugged')
elseif has('win32')
	call plug#begin('~/vimfiles/plugged')
endif


"-------------------------------------------------------
" basic plugins
"-------------------------------------------------------
if index(g:plugin_group, 'basic') >= 0
	"-------------------------------------------------------
	" show the start screen, display the recently edited files
	"-------------------------------------------------------
	Plug 'mhinz/vim-startify'


	"-------------------------------------------------------
	" vim-startify
	"-------------------------------------------------------
	" the dir to save/load sessions to/from
	let g:startify_session_dir = '~/.vim/session'
endif


"-------------------------------------------------------
" enhanced plugins
"-------------------------------------------------------
if index(g:plugin_group, 'enhanced') >= 0
	"-------------------------------------------------------
	" insert or delete brackets, parens, quotes in pair
	"-------------------------------------------------------
	Plug 'jiangmiao/auto-pairs'

	"-------------------------------------------------------
	" better rainbow paretheses
	"-------------------------------------------------------
	Plug 'kien/rainbow_parentheses.vim'

	"-------------------------------------------------------
	" strip whitespace
	"-------------------------------------------------------
	Plug 'axelf4/vim-strip-trailing-whitespace'

	"-------------------------------------------------------
	" float terminal
	"-------------------------------------------------------
	Plug 'voldikss/vim-floaterm'


	"-------------------------------------------------------
	" auto-pairs
	"-------------------------------------------------------
	" open fly mode
	let g:AutoPairsFlayMode = 1

	" work in FlyMode, insert the key at the Fly Mode jumped postion
	let g:AutoPairsShortcutBackInsert = '<M-b>'


	"-------------------------------------------------------
	" rainbow_parentheses
	"-------------------------------------------------------
	" set color of parentheses
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

	"-------------------------------------------------------
	" float terminal
	"-------------------------------------------------------
	let g:floaterm_wintype = 'float'
	let g:floaterm_width = 0.4
	let g:floaterm_height = 0.99
	let g:floaterm_position = 'right'
	" toggle the terminal
	let g:floaterm_keymap_toggle = '<F12>'
	" close window if the job exits normally
	let g:floaterm_autoclose = 1
	" kill all floaterm instance when quit vim
	augroup Floaterm
		au!
		au QuitPre * execute "FloatermKill!"
	augroup END
endif


"-------------------------------------------------------
" auto generate ctags/gtags and provide auto indexing function
"-------------------------------------------------------
if index(g:plugin_group, 'tags') >= 0
	"---------------------------------------------------------
	" asynchronous generate tag file
	"---------------------------------------------------------
	Plug 'ludovicchabant/vim-gutentags'


	"-------------------------------------------------------
	" vim-gutentags
	"-------------------------------------------------------
	" set root dir of a project
	let g:gutentags_project_root = ['.root', '.svn', '.git',
				\ '.project']

	" set ctags file name
	let g:gutentags_ctas_tagfile = '.tags'

	" detect dir ~/.cache/tags, create new one if it doesn't exist
	let s:vim_tags = expand('~/.cache/tags')
	if !isdirectory(s:vim_tags)
		silent! call mkdir(s:vim_tags, 'p')
	endif

	" set dir to save the tag file
	let g:gutentags_cache_dir = s:vim_tags

	" disalbe auto generate tags as default
	let g:gutentags_modules = []

	" allow to generate ctags file automatically if exist ctags
	if executable('ctags')
		let g:gutentags_modules += ['ctags']
	endif

	" set ctags arguments
	let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
	let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxl']
	let g:gutentags_ctags_extra_args += ['--c-kinds=+pxl']

	" use universal-ctags
	let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

	" gutentags whitelist
	let gutentags_exclude_filetypes = ['text']
endif


"-------------------------------------------------------
" filetypes plugin
"-------------------------------------------------------
if index(g:plugin_group, 'filetypes') >= 0
	"-------------------------------------------------------
	" additional Vim sytax highlight for C++
	"-------------------------------------------------------
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

	"-------------------------------------------------------
	" preview markdown
	"-------------------------------------------------------
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app &&
				\ npm install', 'for': ['markdown'] }


	"-------------------------------------------------------
	" markdown-preview
	"-------------------------------------------------------
	" auto open the preview window after entering the markdown buffer
	let g:mkdp_auto_start = 1

	" auto close current preview window when change from markdown
	" buffer to another buffer
	let g:mkdp_auto_close = 1

	" set to 1, the vim will refresh markdown when save the buffer
	" or leave from isert mode, default 0 is auto refresh markdown
	" as editing or moving the cursor
	let g:mkdp_refresh_slow = 0

	" specify browser to open preview page
	let g:mkdp_browser = 'firefox'

	" preview page title
	" ${name} will be replace with the file name
	let g:mkdp_page_title = '[${name}]'

	" recognized filetypes
	" these filetypes will have MarkdownPreview... commands
	let g:mkdp_filetype = ['markdown']
endif


"-------------------------------------------------------
" airline
"-------------------------------------------------------
if index(g:plugin_group, 'airline') >= 0
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'


	"-------------------------------------------------------
	" airline & airline-themes
	"-------------------------------------------------------
	" set color scheme of airline
	let g:airline_theme = 'solarized'

	" automatically displays all buffers when there's only one tab open
	let g:airline#extensions#tabline#enabled = 1

	" select path formatter ariline use
	let g:airline#extensions#tabline#formatter = 'unique_tail'

	" quick selcet buffer
	let g:airline#extensions#tabline#buffer_idx_mode = 1
	nmap <space>1<space> <Plug>AirlineSelectTab1
	nmap <space>2<space> <Plug>AirlineSelectTab2
	nmap <space>3<space> <Plug>AirlineSelectTab3
	nmap <space>4<space> <Plug>AirlineSelectTab4
	nmap <space>5<space> <Plug>AirlineSelectTab5
	nmap <space>6<space> <Plug>AirlineSelectTab6
	nmap <space>7<space> <Plug>AirlineSelectTab7
	nmap <space>8<space> <Plug>AirlineSelectTab8
	nmap <space>9<space> <Plug>AirlineSelectTab9
	nmap <space>0<space> <Plug>AirlineSelectTab0
	nmap <space>-<space> <Plug>AirlineSelectPrevTab
	nmap <space>+<space> <Plug>AirlineSelectNextTab
endif


"-------------------------------------------------------
" dirvish
"-------------------------------------------------------
if index(g:plugin_group, 'dirvish') >= 0
	Plug 'justinmk/vim-dirvish'
endif


"-------------------------------------------------------
" coc
"-------------------------------------------------------
if index(g:plugin_group, 'coc') >= 0
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'honza/vim-snippets'
	Plug 'SirVer/ultisnips'

	"-------------------------------------------------------
	" coc.nvim
	"-------------------------------------------------------
	" if hidden is not set, TextEdit might fail
	set hidden

	" better display for messages
	set cmdheight=2

	" for better diagnostic messages experience
	set updatetime=300

	" don't give |ins-completion-menu| messages
	set shortmess+=c

	" show signcolumns
	if has("patch-8.1-1564")
		set signcolumn=number
	else
		set signcolumn=yes
	endif

	" use tab for trigger completion and snippet expand
	inoremap <silent><expr> <tab>
				\ pumvisible() ? "\<C-n>" :
				\ <SID>check_back_space() ? "\<tab>" :
				\ coc#refresh()
	inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1] =~# '\s'
	endfunction

	" Remap key for gotos
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gD <Plug>(coc-declaration)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implemention)
	nmap <silent> gr <Plug>(coc-references)

	" display error messages at the current position:w
	nmap <silent> <M-e> <Plug>(coc-diagnostic-info)
	" jump to previous error
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	" jump to next error
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" use K to show documentation in preview window
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

	" highlight symbol under cursor on CursorHold
	augroup coc_hightligt
		autocmd!
		autocmd CursorHold * silent call CocActionAsync('highlight')
	augroup END

	" symbol renaming
	nmap <space>rn<space> <Plug>(coc-rename)

	" apply AutoFix to problem on the current line
	nmap <space>qf<space> <Plug>(coc-fix-current)

	" translation
	" popup
	nmap <space>tt<space> <Plug>(coc-translator-p)
	vmap <space>tt<space> <Plug>(coc-translator-pv)
	" echo
	nmap <space>te<space> <Plug>(coc-translator-e)
	vmap <space>te<space> <Plug>(coc-translator-ev)
	" replace
	nmap <space>tr<space> <Plug>(coc-translator-r)
	vmap <space>tr<space> <Plug>(coc-translator-rv)

	" remap <C-j> and <C-k> for scroll float window/popups
	if has('nvim-0.4.0') || has('patch-8.2.0750')
		nnoremap <silent><nowait><expr> <C-j>
					\ coc#float#has_scroll() ?
					\ coc#float#scroll(1) : "\<C-f>"
		nnoremap <silent><nowait><expr> <C-k>
					\ coc#float#has_scroll() ?
					\ coc#float#scroll(0) : "\<C-b>"
		inoremap <silent><nowait><expr> <C-j>
					\ coc#float#has_scroll() ?
					\ "\<C-r>=coc#float#scroll(1)\<CR>" : "\<right>"
		inoremap <silent><nowait><expr> <C-k>
					\ coc#float#has_scroll() ?
					\ "\<C-r>=coc#float#scroll(0)\<CR>" : "\<left>"
		vnoremap <silent><nowait><expr> <C-j>
					\ coc#float#has_scroll() ?
					\ coc#float#scroll(1) : "\<C-f>"
		vnoremap <silent><nowait><expr> <C-k>
					\ coc#float#has_scroll() ?
					\ coc#float#scroll(0) : "\<C-b>"
	endif

	" mapping for CocList
	" show all diagnostics
	nnoremap <silent><nowait> <space>a<space> :<C-u>CocList diagnostics<CR>
	" manage extensions
	nnoremap <silent><nowait> <space>e<space> :<C-u>CocList extensions<CR>
	" show commands
	nnoremap <silent><nowait> <space>c<space> :<C-u>CocList commands<CR>
	" find symbol of current document
	nnoremap <silent><nowait> <space>o<space> :<C-u>CocList outline<CR>
	" search workspace symbols
	nnoremap <silent><nowait> <space>s<space> :<C-u>CocList -I symbols<CR>
	" do default action for next item
	nnoremap <silent><nowait> <space>j<space> :<C-u>CocNext<CR>
	" do default action for previous item
	nnoremap <silent><nowait> <space>k<space> :<C-u>CocPrev<CR>
	" resume last coc list
	nnoremap <silent><nowait> <space>p<space> :<C-u>CocListResume<CR>

    "-------------------------------------------------------
    " snippets
    "-------------------------------------------------------
	let g:UltiSnipsSnippetDirectories = ["UltiSnips", "plugcfg/UltiSnips"]
	let g:UltiSnipsExpandTrigger = '<C-l>'
	let g:UltiSnipsJumpForwardTrigger = '<C-j>'
	let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

endif


"-------------------------------------------------------
" debug
"-------------------------------------------------------
if index(g:plugin_group, 'debug') >= 0
	"Plug 'puremourning/vimspector'


	"-------------------------------------------------------
	" vimspector
	"-------------------------------------------------------
	"let g:vimspector_enable_mappings = 'HUMAN'
endif


if index(g:plugin_group, 'asynctask') >= 0
	"-------------------------------------------------------
	" run asynchronous tasks
	"-------------------------------------------------------
	Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun', 'AsyncStop'] }
	Plug 'skywind3000/asynctasks.vim', { 'on': ['AsyncTask', 'AsyncTaskMacro', 'AsyncTaskList', 'AsyncTaskEdit'] }


	"-------------------------------------------------------
	" AsyncTasks, AsyncRun
	"-------------------------------------------------------
	" extra config file
	if has('unix')
		let g:asynctasks_extra_config = ['~/.vim/vimcfg/plugcfg/tasks.ini']
	elseif has('win32')
		let g:asynctasks_extra_config = ['~/vimfiles/vimcfg/plugcfg/tasks.ini']
	endif

	" automatically open Qickfix window with a height of 6
	let g:asyncrun_open = 6

	" bell when finish the task
	let g:asyncrun_bell = 1

	" set <leader>q to open/close the Quickficx window
	nnoremap <silent> <leader>q :call asyncrun#quickfix_toggle(6)<cr>

	" specify what terminal do I want to use
	let g:asynctasks_term_pos = 'tab'

	" reuse a terminal
	let g:asynctasks_term_reuse = 1

	" run the program
	nnoremap <silent> <space>r<space> :AsyncTask file-run<CR>

	" compile single file
	nnoremap <silent> <space>c<space> :AsyncTask file-build<CR>

	" complie single file with debug info
	nnoremap <silent> <space>cd<space> :AsyncTask file-debug<CR>

	" use gdbgui to debug
	nnoremap <silent> <space>d<space> :AsyncTask file-gdbgui<CR>

	" delete the executable file generated by current file
	nnoremap <silent> <space>rm<space> :AsyncTask exe-del<CR>

	" set root dir for make
	let g:asyncrun_rootmarks = ['.root', '.svn', '.git', '.project']

	" run current project
	nnoremap <silent> <space>mr<space> :AsyncTask project-run<CR>

	" run make
	nnoremap <silent> <space>m<space> :AsyncTask project-build<CR>

	" run make for debugging
	nnoremap <silent> <space>md<space> :AsyncTask project-debug<CR>

	" run make for cleaning
	nnoremap <silent> <space>mc<space> :AsyncTask project-clean<CR>

	" query available tasks
	nnoremap <silent> <space>qat<space> :AsyncTaskList<CR>
endif


"-------------------------------------------------------
" language tool - translator and grammar check
"-------------------------------------------------------
if index(g:plugin_group, 'language_tool') >= 0
endif

"-------------------------------------------------------
" initialize plugin system
"-------------------------------------------------------
call plug#end()


"Plug 'Yggdroot/LeaderF'
