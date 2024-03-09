if exists('g:diff_orig_loaded')
	finish
endif
let g:diff_orig_loaded = 1

" This command only work in old vimscript.
if exists('DiffOrig') == 0
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis |
				\ wincmd p | diffthis
endif
