" This command only work in old vimscript.
if exists('DiffOrig') == 0
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis |
				\ wincmd p | diffthis
endif
