vim9script

var s_system_uname: string = null_string
var s_windows: bool = false

export def IsWin(): bool
	return has('win32') || has('win64')
enddef

s_windows = IsWin()

#----------------------------------------------------------------------
# uname -a
#----------------------------------------------------------------------
export def SystemUname(force: bool = false): string
  var uname: string = null_string
	if s_system_uname == null || force
		if s_windows
			uname = system('cmd.exe /c ver')
			uname = substitute(uname, '\s*\n$', '', 'g')
			uname = substitute(uname, '^\s*\n', '', 'g')
			uname = join(split(uname, '\n'), '')
		else
			uname = substitute(system("uname -a"), '\s*\n$', '', 'g')
		endif
    s_system_uname = uname
	endif
	return s_system_uname
enddef

#----------------------------------------------------------------------
# check wsl
#----------------------------------------------------------------------
export def IsWsl(): bool
	if s_windows
		return false
	endif
	var f: string = '/proc/version'
  var text: list<string> = null_list
	if filereadable(f)
		try
			text = readfile(f, '', 3)
		catch
			text = []
		endtry
		for t in text
			if match(t, 'Microsoft') >= 0
				return true
			endif
		endfor
	endif
	var cmd: string = '/mnt/c/Windows/System32/cmd.exe'
	if !executable(cmd)
		# can't return here, some windows may locate in somewhere else.
	endif
	if $WSL_DISTRO_NAME != ''
		return true
	endif
	var uname: string = SystemUname()
	if match(uname, 'Microsoft') >= 0
    return true
	endif
	return false
enddef

export const WIN = s_windows
export const UNIX = !s_windows
export const WSL = IsWsl()
