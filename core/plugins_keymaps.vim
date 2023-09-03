" plugins.vim - Plugins' keymaps.
" Must be loaded after plugins.vim.
" Author: vamirio

if index(g:plugin_group, 'basic') >= 0
	" auto-pairs

	" Work in FlyMode, insert the key at the Fly Mode jumped postion.
	let g:AutoPairsShortcutBackInsert = '<M-b>'


	" easymotion

	" <leader>f{char} to move to {char}.
	map <leader>f <Plug>(easymotion-bd-f)
	nmap <leader>f <Plug>(easymotion-overwin-f)

	" <leader>F{char}{char} to move to {char}{char}
	nmap <leader>F <Plug>(easymotion-overwin-f2)

	" Quick h/j/k/l(JK motion).
	map <leader>h <Plug>(easymotion-linebackward)
	map <leader>j <Plug>(easymotion-j)
	map <leader>k <Plug>(easymotion-k)
	map <leader>l <Plug>(easymotion-lineforward)
endif

if index(g:plugin_group, 'enhanced') >= 0
	" vim-floaterm

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
endif

if index(g:plugin_group, 'tags') >= 0
endif

if index(g:plugin_group, 'lightline') >= 0
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

if index(g:plugin_group, 'coc') >= 0
	" Use tab for trigger completion with characters ahead and navigate.
	inoremap <silent><expr> <tab>
				\ coc#pum#visible() ? coc#pum#next(1) :
				\ <SID>CheckBackspace() ? "\<tab>" :
				\ coc#refresh()
	inoremap <silent><expr><S-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
	function! s:CheckBackspace() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1] =~# '\s'
	endfunction

	" Make <CR> to accept selected completion item.
	inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() :
				\ "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

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

	" Refactor.
	nmap <leader>rf <Plug>(coc-refactor)

	" Formating code.
	nnoremap <space>fc :call CocActionAsync('format')<CR>

	" Applying codeAction to the selected code block.
	xmap <leader>a <Plug>(coc-codeaction-selected)
	nmap <leader>a <Plug>(coc-codeaction-selected)

	" Apply AutoFix to problem on the current line.
	nmap <space>qf <Plug>(coc-fix-current)

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

	nnoremap <leader>o  :call <SID>ToggleCocOutline()<CR>
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
	nnoremap <nowait> <space>d :<C-u>CocList diagnostics<CR>
	" Show commands.
	nnoremap <nowait> <space>c :<C-u>CocList commands<CR>
	" Find symbol of current document.
	nnoremap <nowait> <space>s :<C-u>CocList outline<CR>
	" Search workspace symbols.
	nnoremap <nowait> <space>S :<C-u>CocList -I symbols<CR>
	" Do default action for next item.
	nnoremap <nowait> <space>j :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <nowait> <space>k :<C-u>CocPrev<CR>
	" Resume latest coc list.
	nnoremap <nowait> <space>p :<C-u>CocListResume<CR>

	" coc-translator.
	nmap <space>t <Plug>(coc-translator-p)
	vmap <space>t <Plug>(coc-translator-pv)
endif

if index(g:plugin_group, 'snippets') >= 0
	let g:UltiSnipsExpandTrigger = '<C-l>'
	let g:UltiSnipsJumpForwardTrigger = '<C-j>'
	let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
endif

if index(g:plugin_group, 'debug') >= 0
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
		nnoremenu WinBar.● :call vimspector#ToggleBreakpoint()<CR>
		nnoremenu WinBar.‖ :call vimspector#Pause()<CR>
		nnoremenu WinBar.□ :call vimspector#Stop()<CR>
		nnoremenu WinBar.⟲ :call vimspector#Restart()<CR>
		nnoremenu WinBar.✕ :call vimspector#Reset()<CR>

		" Enable mouse.
		set mouse=a
	endfunction
	" }}}

	" Custom mappings while debuggins. {{{
	let s:vimspectorMapped = {}

	function! s:OnJumpToFrame() abort
		if has_key(s:vimspectorMapped, string(bufnr()))
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

		let s:vimspectorMapped[string(bufnr())] = {'modifiable': &modifiable}

		setlocal nomodifiable
	endfunction

	function! s:OnDebugEnd() abort
		" Disable mouse.
		set mouse=

		let originalBuf = bufnr()
		let bufHidden = &hidden
		augroup MyVimspectorSwapExists
			au!
			au SwapExists * let v:swapchoice='o'
		augroup END

		try
			set hidden
			for bufnr in keys(s:vimspectorMapped)
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

					let &modifiable = s:vimspectorMapped[bufnr]['modifiable']
				finally
				endtry
			endfor
		finally
			execute 'noautocmd buffer' originalBuf
			let &hidden = bufHidden
		endtry

		au! MyVimspectorSwapExists

		let s:vimspectorMapped = {}
	endfunction
	" }}}
endif

if index(g:plugin_group, 'asynctask') >= 0
	" Open/close the Quickficx window.
	nnoremap <silent> <F10> :call asyncrun#quickfix_toggle(6)<CR>

	" Shortcut for single file tasks.
	" Compile single file.
	nnoremap <silent> <F4> :AsyncTask file-build<CR>
	" Complie single file with debug info.
	nnoremap <silent> <S-F4> :AsyncTask file-debug<CR>
	" Run the program.
	nnoremap <silent> <F5> :AsyncTask file-run<CR>

	" Shortcut for project tasks.
	" Configure CMake project.
	nnoremap <silent> <S-F7> :AsyncTask project-config<CR>
	" Build project.
	nnoremap <silent> <F7> :AsyncTask project-build<CR>
	" Run project.
	nnoremap <silent> <F6> :AsyncTask project-run<CR>

	" Query available tasks.
	nnoremap <silent> <space>a :AsyncTaskList<CR>
endif

if index(g:plugin_group, 'which_key') >= 0
endif

if index(g:plugin_group, 'fuzzy_search') >= 0
	" Search files.
	let g:Lf_ShortcutF = '<space>ff'
	" Search buffers.
	let g:Lf_ShortcutB = '<space>fb'
	" Search functions.
	nnoremap <space>fn :LeaderfFunction<CR>
endif

if index(g:plugin_group, 'quickui') >= 0
	noremap <space><space> <Cmd>call quickui#menu#open()<CR>

	" Clear all the menus.
	call quickui#menu#reset()

	" quickui#menu#install(section, items [, weight, [, filetypes]])
	" Use [text, command, tip(optional)] to represent an item.
	call quickui#menu#install('&Build', [
		\ ["&Build\tF4", 'AsyncTask file-build', 'build current file'],
		\ ["Build &Debug\tS+F4", 'AsyncTask file-debug-build', 'build current file for debug'],
		\ ['--', ''],
		\ ['&Clean', 'AsyncTask file-clean', 'clean the executable'],
	  \ ])

	call quickui#menu#install('&Project', [
		\ ["&Config\tS+F7", 'AsyncTask project-config', 'config project'],
		\ ["&Build\tF7", 'AsyncTask project-build', 'build project'],
		\ ['--', ''],
		\ ["Clea&n", 'AsyncTask project-clean', 'clean project'],
		\ ['--', ''],
		\ ['&Set Style', 'AsyncTask set-code-style', 'set code style'],
	  \ ])

	call quickui#menu#install('&Debug', [
		\ ["&Run\tF5", 'AsyncTask file-run', 'run current file'],
		\ ["R&un Project\tF6", 'AsyncTask project-run', 'run project'],
		\ ['--', ''],
		\ ["&Debug\tS+F5", 'call vimspector#Continue()'],
		\ ["Toggle &Breakpoint\tF9", 'call vimspector#ToggleBreakpoint()'],
		\ ["Toggle &Conditional Breakpoint\tS+F9", 'call vimspector#ToggleAdvancedBreakpoint()'],
	  \ ])

	" Script inside %{...} will be evaluated and expanded in the string.
	call quickui#menu#install('&Tools', [
				\ ['Set &Highlight Search %{&hlsearch ? "Off" : "On"}', 'set hlsearch!', 'toggle highlight search'],
	  \ ])
endif
