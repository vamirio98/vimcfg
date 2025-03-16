" auto load change.
set autoread
augroup ivim_autoreload
	au!
	" trigger autoread when cursor stop moving, buffer change or terminal focus
	au CursorHold,CursorHoldI,BufEnter,FocusGained *
			\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
			\ | checktime | endif
	" notification after file change
	au FileChangedShellPost *
				\ call ilib#ui#warn('File changed on disk. Buffer reloaded.')
augroup END


" highlight on yank
if has('nvim')
	augroup ivim_highlight_yank
		au!
		au TextYankPost * lua vim.highlight.on_yank()
	augroup END
endif


" resize splits if window got resized
function! s:ResizeSplits()
	let current_tab = tabpagenr()
	tabdo wincmd =
	exec printf("tabnext %d", current_tab)
endfunc
augroup ivim_resize_splits
	au!
	au VimResized * call s:ResizeSplits()
augroup END


" go to last loc when opening a buffer
augroup ivim_last_loc
	au!
	au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
					\ execute("normal `\"") |
			\ endif
augroup END


" close some filetypes with <q>
function s:Close()
	let bid = bufnr('%')
	close
	exec printf("bwipeout! %d", bid)
endfunc
function! s:CloseWithQ()
	setlocal nobuflisted
	nnoremap <buffer><silent> q <cmd>call <SID>Close()<cr>
endfunc
augroup ivim_close_with_q
	au!
	" do NOT add any space between two filetype
	au FileType help,qf,PlenaryTestPopup,checkhealth,dbout,gitsigns-blame,
				\grug-far,lspinfo,neotest-output,neotest-output-panel,
				\neotest-summary,notify,spectre_panel,startuptime,tsplayground
				\ call s:CloseWithQ()
augroup END


" make it easier to close man-files when opened inline
augroup ivim_mam_unlisted
	au FileType man setlocal nobuflisted
augroup END


" wrap and check for spell in text filetypes
augroup ivim_wrap_spell
	au!
	au FileType text,gitcommit,markdown,plaintex,typst
				\ setlocal nowrap | setlocal spell
augroup END


" fix conceallevel for json files
augroup ivim_json_conceal
	au!
	au FileType json,jsonc,json5 setlocal conceallevel=0
augroup END


" auto create dir when saving a file, in case some intermediate
" directory does not exist
function! s:Mkdirp()
	let fn = expand('%:p')
	" avoid specific file like fugitive
	if match(fn, '^\w\w+:[\\/][\\/]') != -1
		return
	endif
	let d = fnameescape(fnamemodify(fn, ':h'))
	if !isdirectory(d)
		call mkdir(d, 'p')
	endif
endfunc
augroup ivim_auto_create_dir
	au!
	au BufWritePre * call s:Mkdirp()
augroup END
