"----------------------------------------------------------------------
" string replace
"----------------------------------------------------------------------
function! ilib#string#replace(text, old, new)
	let data = split(a:text, a:old, 1)
	return join(data, a:new)
endfunc


"----------------------------------------------------------------------
" string strip
"----------------------------------------------------------------------
function! ilib#string#strip(text)
	return substitute(a:text, '^\s*\(.\{-}\)[\t\r\n ]*$', '\1', '')
endfunc


"----------------------------------------------------------------------
" strip left
"----------------------------------------------------------------------
function! ilib#string#lstrip(text)
	return substitute(a:text, '^\s*', '', '')
endfunc


"----------------------------------------------------------------------
" strip left
"----------------------------------------------------------------------
function! ilib#string#rstrip(text)
	return substitute(a:text, '[\t\r\n ]*$', '', '')
endfunc


"----------------------------------------------------------------------
" string partition
"----------------------------------------------------------------------
function! ilib#string#partition(text, sep)
	let pos = stridx(a:text, a:sep)
	if pos < 0
		return [a:text, '', '']
	else
		let size = strlen(a:sep)
		let head = strpart(a:text, 0, pos)
		let sep = strpart(a:text, pos, size)
		let tail = strpart(a:text, pos + size)
		return [head, sep, tail]
	endif
endfunc


"----------------------------------------------------------------------
" starts with prefix
"----------------------------------------------------------------------
function! ilib#string#startswith(text, prefix)
	return (empty(a:prefix) || (stridx(a:text, a:prefix) == 0))
endfunc


"----------------------------------------------------------------------
" ends with suffix
"----------------------------------------------------------------------
function! ilib#string#endswith(text, suffix)
	let s1 = len(a:text)
	let s2 = len(a:suffix)
	let ss = s1 - s2
	if s1 < s2
		return 0
	endif
	return (empty(a:suffix) || (stridx(a:text, a:suffix, ss) == ss))
endfunc


"----------------------------------------------------------------------
" check if text contains part
"----------------------------------------------------------------------
function! ilib#string#contains(text, part)
	return (stridx(a:text, a:part) >= 0) ? 1 : 0
endfunc


"----------------------------------------------------------------------
" get range
" @param text
" @param begin The head token
" @param endup The tail token
" @param pos? Start search from where
"----------------------------------------------------------------------
function! ilib#string#between(text, begin, endup, ...)
	let pos = (a:0 > 0)? (a:1) : 0
	let p1 = stridx(a:text, a:begin, pos)
	if p1 < 0
		return [-1, -1]
	endif
	let p1 = p1 + len(a:begin)
	let p2 = stridx(a:text, a:endup, p1)
	if p2 < 0
		return [-1, -1]
	endif
	return [p1, p2]
endfunc


"----------------------------------------------------------------------
" return matched text at certain position
"----------------------------------------------------------------------
function! ilib#string#matchat(text, pattern, position)
	let start = match(a:text, a:pattern, 0)
	while (start >= 0) && (start <= a:position)
		let endup = matchend(a:text, a:pattern, start)
		if (start <= a:position) && (endup > a:position)
			return [start, endup, strpart(a:text, start, endup - start)]
		else
			let start = match(a:text, a:pattern, endup)
		endif
	endwhile
	return [-1, -1, '']
endfunc
