vim9script

import autoload "./platform.vim" as iplatform
import autoload "./path.vim" as ipath
import autoload "./string.vim" as istring
import autoload "./python.vim" as ipython

const WIN: bool = iplatform.WIN
var shell_error: number = 0


#----------------------------------------------------------------------
# call system(): system(cmd [, cwd [, input [, encoding]]])
#----------------------------------------------------------------------
export def System(cmd: string, cwd: string = null_string,
    input: any = null, encoding: string = null_string): any
  var previous: string = null_string
  var sinput: string = null_string
  if cwd != null
    previous = getcwd()
    ipath.ChdirNoautocmd(cwd)
  endif
  if input != null
    sinput = type(input) == v:t_string ? input : (
      type(input) == v:t_list ? join(input, '\n') : null_string
    )
  endif
  var hr: any = ipython.System(cmd, sinput)
  if cwd != null
    ipath.ChdirNoautocmd(previous)
  endif
  shell_error = v:shell_error
  if encoding != null && has('iconv')
    if encoding != &encoding
      try
        hr = iconv(hr, encoding, &encoding)
      catch
      endtry
    endif
  endif
  return hr
enddef


#---------------------------------------------------------------
# safe input
#---------------------------------------------------------------
export def Input(...args: list<any>): string
  var text: string = null_string
  inputsave()
  try
    text = call('input', args)
  catch /^Vim:Interrupt$/
    text = null_string
  endtry
  inputrestore()
  return istring.Strip(text)
enddef

#----------------------------------------------------------------
# safe confirm
#----------------------------------------------------------------
export def Confirm(...args: list<any>): number
  var choice: number = 0
  inputsave()
  try
    choice = call('confirm', args)
  catch /^Vim:Interrupt$/
    choice = 0
  endtry
  inputrestore()
  return choice
enddef

#----------------------------------------------------------------------
# safe inputlist
#----------------------------------------------------------------------
export def Inputlist(textlist: list<string>): number
  var choice: number = 0
  inputsave()
  try
    choice = inputlist(textlist)
  catch /^Vim:Interrupt$/
    choice = 0
  endtry
  inputrestore()
  return choice
enddef


#----------------------------------------------------------------------
# find files in $PATH
#----------------------------------------------------------------------
export def Which(name: string): string
  var sep: string = WIN ? ';' : ':'
  if ipath.IsAbs(name) && filereadable(name)
    return name
  endif
  for path in split($PATH, sep)
    var filename: string = ipath.Join(path, name)
    if filereadable(filename)
      return ipath.Abspath(filename)
    endif
  endfor
  return null_string
enddef


#----------------------------------------------------------------------
# find executable in $PATH
#----------------------------------------------------------------------
export def Executable(name: string): string
  if !WIN
    return Which(name)
  else
    for n in ['.exe', '.cmd', '.bat', '.vbs']
      var nname: string = name .. n
      var npath: string = Which(nname)
      if npath != null
        return npath
      endif
    endfor
  endif
enddef
