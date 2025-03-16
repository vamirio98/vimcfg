function! imodule#plug#has(plugin) abort
	if !has('nvim')
		" vim-plug store all plugin in the variable `g:plugs`
		return has_key(g:plugs, a:plugin)
	else
		return luaeval('require("lazy.core.config").spec.plugins["' . a:plugin . '"] ~= nil')
	endif
endfunc

function! imodule#plug#plugin_dir(plugin) abort
	let plugin = a:plugin
	if !imodule#plug#has(plugin)
		throw 'no such plugin: ' . plugin
	endif

	if !has('nvim')
		return g:plugs[plugin].dir
	else
		return luaeval('require("lazy.core.config").spec.plugins["' . plugin . '"].dir')
	endif
endfunc
