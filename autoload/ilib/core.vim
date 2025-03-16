let s:windows = ilib#platform#is_win()
let g:ilib#core#windows = s:windows
let g:ilib#core#unix = !s:windows


"----------------------------------------------------------------------
" call system: system(cmd [, cwd [, encoding [, input]]])
"----------------------------------------------------------------------
function! ilib#core#system(cmd, ...)
	let cwd = ((a:0) > 0)? (a:1) : ''
	if cwd != ''
		let previous = getcwd()
		noautocmd call ilib#path#chdir(cwd)
	endif
	if a:0 >= 3
		if type(a:3) == type('')
			let sinput = a:3
		else
			let sinput = (type(a:3) == type([]))? join(a:3, "\n") : {}
		endif
	else
		let sinput = {}
	endif
	let hr = ilib#python#system(a:cmd, sinput)
	if cwd != ''
		noautocmd call ilib#path#chdir(previous)
	endif
	let g:ilib#core#shell_error = s:shell_error
	if (a:0) > 1 && has('iconv')
		let encoding = a:2
		if encoding != '' && encoding != &encoding
			try
				let hr = iconv(hr, a:2, &encoding)
			catch
			endtry
		endif
	endif
	return hr
endfunc


"---------------------------------------------------------------
" safe input
"---------------------------------------------------------------
function! ilib#core#input(...)
	call inputsave()
	try
    let text = call('input', a:000)
	catch /^Vim:Interrupt$/
		let text = ''
	endtry
	call inputrestore()
	return ilib#string#strip(text)
endfunc

"----------------------------------------------------------------
" Safe confirm
"----------------------------------------------------------------
function! ilib#core#confirm(...)
	call inputsave()
	try
		let hr = call('confirm', a:000)
	catch /^Vim:Interrupt$/
		let hr = 0
	endtry
	call inputrestore()
	return hr
endfunc

"----------------------------------------------------------------------
" Safe inputlist
"----------------------------------------------------------------------
function! ilib#core#inputlist(textlist)
	call inputsave()
	try
		let hr = inputlist(a:textlist)
	catch /^Vim:Interrupt$/
		let hr = -1
	endtry
	call inputrestore()
	return hr
endfunc
