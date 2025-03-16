let s:windows = g:ilib#platform#windows

"----------------------------------------------------------------------
" guess root
"----------------------------------------------------------------------
function! s:GuessRoot(filename, markers)
	let fullname = ilib#path#abspath(a:filename)
	let pivot = fullname
	if !isdirectory(pivot)
		let pivot = fnamemodify(pivot, ':h')
	endif
	while 1
		let prev = pivot
		for marker in a:markers
			let newname = ilib#path#join(pivot, marker)
			if newname =~ '[\*\?\[\]]'
				if glob(newname) != ''
					return pivot
				endif
			elseif filereadable(newname)
				return pivot
			elseif isdirectory(newname)
				return pivot
			endif
		endfor
		let pivot = fnamemodify(pivot, ':h')
		if pivot == prev
			break
		endif
	endwhile
	return ''
endfunc


"----------------------------------------------------------------------
" find project root
" @param name Path, bufnr or '%'
" @param markers Root markers
" @param strict If 1, return '' if not found, otherwise the cwd
"----------------------------------------------------------------------
function! s:FindRoot(name, markers, strict)
	let path = ''
	if type(a:name) == v:t_number
		let bid = (a:name < 0)? bufnr('%') : (a:name + 0)
		let path = bufname(bid)
		let root = getbufvar(bid, 'ivim_root', '')
		if root != ''
			return root
		elseif exists('g:ivim_root') && g:ivim_root != ''
			return g:ivim_root
		elseif exists('g:ivim_root_locator')
			let root = call(g:ivim_root_locator, [bid])
			if root != ''
				return root
			endif
		endif
		if getbufvar(bid, '&buftype') != ''
			let path = getcwd()
			return ilib#path#abspath(path)
		endif
	elseif a:name == '%'
		let path = a:name
		if exists('b:ivim_root') && b:ivim_root != ''
			return b:ivim_root
		elseif exists('t:ivim_root') && t:ivim_root != ''
			return t:ivim_root
		elseif exists('g:ivim_root') && g:ivim_root != ''
			return g:ivim_root
		elseif exists('g:ivim_root_locator')
			let root = call(g:ivim_root_locator, [a:name])
			if root != ''
				return root
			endif
		endif
	else
		let path = printf('%s', a:name)
	endif
	let root = s:GuessRoot(path, a:markers)
	if root != ''
		return ilib#path#abspath(root)
	elseif a:strict != 0
		return ''
	endif
	" Not found: return parent directory of current file / file itself.
	let fullname = ilib#path#abspath(path)
	if isdirectory(fullname)
		return fullname
	endif
	return ilib#path#abspath(fnamemodify(fullname, ':h'))
endfunc


"----------------------------------------------------------------------
" get project root
" @param name Path, bufnr or '%'
" @param markers Root markers
" @param strict If 1, return '' if not found, otherwise the cwd
"----------------------------------------------------------------------
function! ilib#project#get_root(path, ...)
	let markers = ['.root', '.git', '.hg', '.svn', '.project']
	if exists('g:ivim_rootmarkers')
		let markers = g:ivim_rootmarkers
	endif
	if a:0 > 0
		if type(a:1) == type([])
			let markers = a:1
		endif
	endif
	let strict = (a:0 >= 2)? (a:2) : 0
	if type(a:path) == v:t_number && (a:path == 0)
		let l:hr = s:FindRoot('%', markers, strict)
	else
		let l:hr = s:FindRoot(a:path, markers, strict)
	endif
	if s:windows != 0
		let l:hr = join(split(l:hr, '/', 1), "\\")
	endif
	return l:hr
endfunc


"----------------------------------------------------------------------
" current root
"----------------------------------------------------------------------
function! ilib#project#current_root()
	return ilib#project#get_root('%')
endfunc
