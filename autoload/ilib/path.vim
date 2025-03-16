let s:windows = g:ilib#platform#windows
let s:sep = s:windows ? '\' : '/'
let g:ilib#path#sep = s:sep


"----------------------------------------------------------------------
" get CD command
"----------------------------------------------------------------------
function! ilib#path#getcd()
	if has('nvim')
		let cmd = haslocaldir() ? 'lcd' : (haslocaldir(-1, 0) ? 'tcd' : 'cd')
	else
		let cmd = haslocaldir() ? ((haslocaldir() == 1) ? 'lcd' : 'tcd') : 'cd'
	endif
	return cmd
endfunc


"----------------------------------------------------------------------
" change directory in proper way
"----------------------------------------------------------------------
function! ilib#path#chdir(path)
	let cmd = ilib#path#getcd()
	silent execute cmd . ' '. fnameescape(a:path)
endfunc


"----------------------------------------------------------------------
" change dir with noautocmd prefix
"----------------------------------------------------------------------
function! ilib#path#chdir_noautocmd(path)
	noautocmd call ilib#path#chdir(a:path)
endfunc


function! ilib#path#abspath(path)
	let f = a:path
	if f =~ "'."
		try
			redir => m
			silent exe ':marks' f[1]
			redir END
			let f = split(split(m, '\n')[-1])[-1]
			let f = filereadable(f)? f : ''
		catch
			let f = '%'
		endtry
	endif
	if f == '%'
		let f = expand('%')
		if &bt == 'terminal'
			let f = ''
		elseif &bt != ''
			let is_directory = 0
			if f =~ '\v^fugitive\:[\\\/]{3}'
				return ilib#path#abspath(f)
			elseif f =~ '[\/\\]$'
				if f =~ '^[\/\\]' || f =~ '^.:[\/\\]'
					let is_directory = isdirectory(f)
				endif
			endif
			let f = (is_directory)? f : ''
		endif
	elseif f =~ '^\~[\/\\]'
		let f = expand(f)
	elseif f =~ '\v^fugitive\:[\\\/]{3}'
		let path = strpart(f, s:windows? 12 : 11)
		let pos = stridx(path, '.git')
		if pos >= 0
			let path = strpart(path, 0, pos)
		endif
		let f = fnamemodify(path, ':h')
	endif
	let f = fnamemodify(f, ':p')
	if s:windows
		let f = tr(f, '\', '/')
		let h = matchstr(f, '\v^[\/\\]+')
		let b = strpart(f, strlen(h))
		let f = h . substitute(b, '\v[\/\\]+', '/', 'g')
	else
		let f = substitute(f, '\v[\/\\]+', '/', 'g')
	endif
	if f =~ '\/$'
		let f = fnamemodify(f, ':h')
	endif
	return f
endfunc


"----------------------------------------------------------------------
" check absolute path name
"----------------------------------------------------------------------
function! ilib#path#isabs(path)
	let path = a:path
	if strpart(path, 0, 1) == '~'
		return 1
	endif
	if s:windows != 0
		if path =~ '^.:[\/\\]'
			return 1
		endif
		let head = strpart(path, 0, 1)
		if head == "\\"
			return 1
		endif
	endif
	let head = strpart(path, 0, 1)
	if head == '/'
		return 1
	endif
	return 0
endfunc


"----------------------------------------------------------------------
" join two path
"----------------------------------------------------------------------
function! s:JoinTwoPath(home, name)
	let l:size = strlen(a:home)
	if l:size == 0 | return a:name | endif
	if ilib#path#isabs(a:name)
		return a:name
	endif
	let l:last = strpart(a:home, l:size - 1, 1)
	if ilib#platform#is_win()
		if l:last == "/" || l:last == "\\"
			return a:home . a:name
		else
			return a:home . '/' . a:name
		endif
	else
		if l:last == "/"
			return a:home . a:name
		else
			return a:home . '/' . a:name
		endif
	endif
endfunc


"--------------------------------------------------------------
" python: os.path.join
"--------------------------------------------------------------
function! ilib#path#join(...) abort
	let t = ''
	for p in a:000
		let t = s:JoinTwoPath(t, p)
	endfor
	return t
endfunc


"----------------------------------------------------------------------
" dirname
"----------------------------------------------------------------------
function! ilib#path#dirname(path)
	return fnamemodify(a:path, ':h')
endfunc


"----------------------------------------------------------------------
" basename of /foo/bar is bar
"----------------------------------------------------------------------
function! ilib#path#basename(path)
	return fnamemodify(a:path, ':t')
endfunc


"----------------------------------------------------------------------
" normalize, translate path to unix format absoute path
" @param path
" @param lower(optional) Whether to translate to uppercase to lowercase
"                        on Windows, default: 0
"----------------------------------------------------------------------
function! ilib#path#normalize(path, ...)
	let lower = (a:0 > 0)? a:1 : 0
	let path = a:path
	if (s:windows == 0 && path == '/') || (s:windows && path =~ '^.:[\/\\]')
		let path = fnamemodify(path, ':p')
	endif
	if s:windows
		let path = tr(path, "\\", '/')
	endif
	if lower && (s:windows || has('win32unix'))
		let path = tolower(path)
	endif
	if path =~ '^[\/\\]$'
		return path
	elseif s:windows && path =~ '^.:[\/\\]$'
		return path
	endif
	if s:windows
		let path = tr(path, '\', '/')
		let h = matchstr(path, '\v^[\/\\]+')
		let b = strpart(path, strlen(h))
		let path = h . substitute(b, '\v[\/\\]+', '/', 'g')
	else
		let path = substitute(path, '\v[\/\\]+', '/', 'g')
	endif
	let size = len(path)
	if size > 1 && path[size - 1] == '/'
		let path = fnamemodify(path, ':h')
	endif
	return path
endfunc


"----------------------------------------------------------------------
" normal case, if on Windows and path contains uppercase letter,
" change it to lowercase
"----------------------------------------------------------------------
function! ilib#path#normcase(path)
	if s:windows == 0
		return (has('win32unix') == 0)? (a:path) : tolower(a:path)
	else
		return tolower(tr(a:path, '/', '\'))
	endif
endfunc


"----------------------------------------------------------------------
" returns 1 for equal, 0 for not equal
"----------------------------------------------------------------------
function! ilib#path#equal(path1, path2)
	if a:path1 == a:path2
		return 1
	endif
	let p1 = ilib#path#normcase(ilib#path#abspath(a:path1))
	let p2 = ilib#path#normcase(ilib#path#abspath(a:path2))
	return (p1 == p2) ? 1 : 0
endfunc


"----------------------------------------------------------------------
" return 1 if base directory contains child, 0 for not contain
"----------------------------------------------------------------------
function! ilib#path#contains(base, child)
	let base = ilib#path#abspath(a:base)
	let child = ilib#path#abspath(a:child)
	let base = ilib#path#normalize(base)
	let child = ilib#path#normalize(child)
	let base = ilib#path#normcase(base)
	let child = ilib#path#normcase(child)
	return (stridx(child, base) == 0) ? 1 : 0
endfunc


"----------------------------------------------------------------------
" return a relative version of a path
"----------------------------------------------------------------------
function! ilib#path#relpath(path, base) abort
	let path = ilib#path#abspath(a:path)
	let base = ilib#path#abspath(a:base)
	let path = ilib#path#normalize(path)
	let base = ilib#path#normalize(base)
	let head = ''
	while 1
		if ilib#path#contains(base, path)
			if base =~ '[\/\\]$'
				let size = strlen(base)
			else
				let size = strlen(base) + 1
			endif
			return head . strpart(path, size)
		endif
		let prev = base
		let head = '../' . head
		let base = fnamemodify(base, ':h')
		if base == prev
			break
		endif
	endwhile
	return ''
endfunc


"----------------------------------------------------------------------
" python: os.path.split
"----------------------------------------------------------------------
function! ilib#path#split(path)
	let p1 = fnamemodify(a:path, ':h')
	let p2 = fnamemodify(a:path, ':t')
	return [p1, p2]
endfunc


"----------------------------------------------------------------------
" split ext, return [main, ext]
"----------------------------------------------------------------------
function! ilib#path#splitext(path)
	let path = a:path
	let size = strlen(path)
	let pos = strridx(path, '.')
	if pos < 0
		return [path, '']
	endif
	let p1 = strridx(path, '/')
	if s:windows
		let p2 = strridx(path, '\')
		let p1 = (p1 > p2)? p1 : p2
	endif
	if p1 > pos
		return [path, '']
	endif
	let main = strpart(path, 0, pos)
	let ext = strpart(path, pos)
	return [main, ext]
endfunc


"----------------------------------------------------------------------
" strip ending slash
"----------------------------------------------------------------------
function! ilib#path#stripslash(path)
	if a:path =~ '\v[\/\\]$'
		return fnamemodify(a:path, ':h')
	endif
	return a:path
endfunc


"----------------------------------------------------------------------
" find files in $PATH
"----------------------------------------------------------------------
function! ilib#path#which(name)
	if has('win32') || has('win64') || has('win16') || has('win95')
		let sep = ';'
	else
		let sep = ':'
	endif
	if ilib#path#isabs(a:name)
		if filereadable(a:name)
			return ilib#path#abspath(a:name)
		endif
	endif
	for path in split($PATH, sep)
		let filename = s:JoinTwoPath(path, a:name)
		if filereadable(filename)
			return ilib#path#abspath(filename)
		endif
	endfor
	return ''
endfunc


"----------------------------------------------------------------------
" find executable in $PATH
"----------------------------------------------------------------------
function! ilib#path#executable(name)
	if s:windows != 0
		for n in ['.exe', '.cmd', '.bat', '.vbs']
			let nname = a:name . n
			let npath = ilib#path#which(nname)
			if npath != ''
				return npath
			endif
		endfor
	else
		return ilib#path#which(a:name)
	endif
	return ''
endfunc


"----------------------------------------------------------------------
" exists
"----------------------------------------------------------------------
function! ilib#path#exists(path)
	if isdirectory(a:path)
		return 1
	elseif filereadable(a:path)
		return 1
	else
		if !empty(glob(a:path, 1))
			return 1
		endif
	endif
	return 0
endfunc


"----------------------------------------------------------------------
" win2unix
" @param winpath
" @param prefix(optional) Path prefix, will be add to `winpath`,
"                         default: ''
"----------------------------------------------------------------------
function! ilib#path#win2unix(winpath, ...)
	let prefix = a:0 > 0 ? a:1 : ''
	let path = a:winpath
	if path =~ '^\a:[/\\]'
		let drive = tolower(strpart(path, 0, 1))
		let name = strpart(path, 3)
		let p = ilib#path#join(prefix, drive)
		let p = ilib#path#join(p, name)
		return tr(p, '\', '/')
	elseif path =~ '^[/\\]'
		let drive = tolower(strpart(getcwd(), 0, 1))
		let name = strpart(path, 1)
		let p = ilib#path#join(prefix, drive)
		let p = ilib#path#join(p, name)
		return tr(p, '\', '/')
	else
		return tr(a:winpath, '\', '/')
	endif
endfunc


"----------------------------------------------------------------------
" shorten path
" @param path
" @param limit(optional) The path length limit, default: 40
"----------------------------------------------------------------------
function! ilib#path#shorten(path, ...) abort
	let home = expand('~')
	let path = a:path
	let limit = (a:0 > 0)? a:1 : 40
	if ilib#path#contains(home, path)
		let size = strlen(home)
		let path = '~' . strpart(path, size)
	endif
	let size = strlen(path)
	if size > limit
		let t = pathshorten(path, 2)
		let size = strlen(t)
		if size > limit
			return pathshorten(path)
		endif
		return t
	endif
	return path
endfunc
