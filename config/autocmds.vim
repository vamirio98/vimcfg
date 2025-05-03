vim9script

import autoload "../autoload/ilib/ui.vim" as iui

# auto load change.
set autoread
augroup ivim_config_autoreload
	au!
	# trigger autoread when cursor stop moving, buffer change or terminal focus
	au CursorHold,CursorHoldI,BufEnter,FocusGained *
			\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
			\ | checktime | endif
	# notification after file change
	au FileChangedShellPost *
				\ iui.Warn('File changed on disk. Buffer reloaded.')
augroup END


# resize splits if window got resized
def ResizeSplits(): void
	var curr_tab: number = tabpagenr()
	tabdo wincmd =
	exec printf("tabnext %d", curr_tab)
enddef
augroup ivim_config_resize_splits
	au!
	au VimResized * ResizeSplits()
augroup END


# go to last loc when opening a buffer
augroup ivim_config_last_loc
	au!
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \ && &filetype != "gitcommit"
  | execute("normal `\"")
  | endif
augroup END


# close some filetypes with <q>
def Close(): void
	var bid: number = bufnr('%')
	close
	exec printf("bwipeout! %d", bid)
enddef
def CloseWithQ(): void
	setlocal nobuflisted
	nnoremap <buffer> q <ScriptCmd>call Close()<cr>
enddef
augroup ivim_config_close_with_q
	au!
	# do NOT add any space between two filetype
	au FileType help,qf,PlenaryTestPopup,checkhealth,dbout,gitsigns-blame,
				\grug-far,lspinfo,neotest-output,neotest-output-panel,
				\neotest-summary,notify,spectre_panel,startuptime,tsplayground
				\ CloseWithQ()
augroup END


# make it easier to close man-files when opened inline
augroup ivim_config_mam_unlisted
  au!
	au FileType man setlocal nobuflisted
augroup END


# wrap and check for spell in text filetypes
augroup ivim_config_wrap_spell
	au!
	au FileType text,gitcommit,markdown,plaintex,typst
				\ setlocal nowrap | setlocal spell
augroup END


# fix conceallevel for json files
augroup ivim_config_json_conceal
	au!
	au FileType json,jsonc,json5 setlocal conceallevel=0
augroup END


# auto create dir when saving a file, in case some intermediate
# directory does not exist
def Mkdirp(): void
	var fn: string = expand('%:p')
	# avoid specific file like fugitive
	if match(fn, '^\w\w+:[\\/][\\/]') != -1
		return
	endif
	var d: string = fnameescape(fnamemodify(fn, ':h'))
	if !isdirectory(d)
		mkdir(d, 'p')
	endif
enddef
augroup ivim_config_auto_create_dir
	au!
	au BufWritePre * Mkdirp()
augroup END
