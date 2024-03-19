vim9script noclear
# This script is the vim9script version of resotre_vim.vim
# (https://www.vim.org/scripts/script.php?script_id=4021)
# I changed the autocmd event to avoid slowing when changing buffer.
#
# It is recommanded to put them in your vimrc file:
#     set viewoptions=cursor,folds,slash,unix

if exists('g:resotre_vim_loaded')
	finish
endif
g:resotre_vim_loaded = 1

if !exists('g:skipview_files')
	g:skipview_files = []
endif

def MakeViewCheck(): bool
	if &l:diff | return v:false | endif
	if &buftype != '' | return v:false | endif
	if expand('%') =~ '\[.*\]' | return v:false | endif
	if empty(glob(expand('%:p'))) | return v:false | endif
	if &modifiable == v:false | return v:false | endif
	if len($TMPDIR) != 0 && expand('%:p:h') == $TMPDIR | return v:false | endif
	if len($TEMP) != 0 && expand('%:p:h') == $TEMP | return v:false | endif
	if len($TMP) != 0 && expand('%:p:h') == $TMP | return v:false | endif

	var fileName = expand('%:p')
	for ifiles in g:skipview_files
		if fileName =~ ifiles
			return v:false
		endif
	endfor

	return v:true
enddef

augroup RestoreView
	au!
	# Autosave & load views.
	au BufUnload ?* if MakeViewCheck() | silent! mkview | endif
	au BufReadPost ?* if MakeViewCheck() | silent! loadview | endif
augroup END
