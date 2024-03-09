vim9script noclear

if exists('g:clean_view_loaded')
	finish
endif
g:clean_view_loaded = 1

if !exists("g:clean_view_ago")
	g:clean_view_ago = 30
endif

g:ExePy("from vimcfg.clean_view import CleanView")
g:ExePy(printf("vimcfg_CleanView = CleanView(r'%s', %d)",
	&viewdir, g:clean_view_ago))
g:ExePy("vimcfg_CleanView.execute()")
