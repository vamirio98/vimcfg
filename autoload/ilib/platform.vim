function! ilib#platform#is_win()
	return has('win32') || has('win64') || has('win16')
endfunc

"----------------------------------------------------------------------
" uname -a
"----------------------------------------------------------------------
function! ilib#platform#system_uname(...)
	let force = (a:0 >= 1)? (a:1) : 0
	if exists('s:system_uname') == 0 || force != 0
		if s:windows
			let uname = ilib#core#system('call cmd.exe /c ver')
			let uname = substitute(uname, '\s*\n$', '', 'g')
			let uname = substitute(uname, '^\s*\n', '', 'g')
			let uname = join(split(uname, '\n'), '')
		else
			let uname = substitute(system("uname -a"), '\s*\n$', '', 'g')
		endif
		let s:system_uname = uname
	endif
	return s:system_uname
endfunc

"----------------------------------------------------------------------
" check wsl
"----------------------------------------------------------------------
function! ilib#platform#is_wsl()
	if exists('s:wsl')
		return s:wsl
	elseif s:windows
		return 0
	endif
	let s:wsl = 0
	let f = '/proc/version'
	if filereadable(f)
		try
			let text = readfile(f, '', 3)
		catch
			let text = []
		endtry
		for t in text
			if match(t, 'Microsoft') >= 0
				let s:wsl = 1
				return 1
			endif
		endfor
	endif
	let cmd = '/mnt/c/Windows/System32/cmd.exe'
	if !executable(cmd)
		" can't return here, some windows may locate
		" in somewhere else.
	endif
	if $WSL_DISTRO_NAME != ''
		let s:wsl = 1
		return 1
	endif
	let uname = ilib#platform#system_uname()
	if match(uname, 'Microsoft') >= 0
		let s:wsl = 1
	endif
	return s:wsl
endfunc

let s:windows = ilib#platform#is_win()
let s:wsl = ilib#platform#is_wsl()
let g:ilib#platform#windows = s:windows
let g:ilib#platform#unix = !s:windows
let g:ilib#platform#wsl = s:wsl
