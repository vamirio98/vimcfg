vim9script

import autoload "./platform.vim" as platform

const WIN: bool = platform.WIN
export const SEP: string = WIN ? '\' : '/'


#----------------------------------------------------------------------
# get CD command
#----------------------------------------------------------------------
export def GetCdCmd(): string
  var cmd: string = haslocaldir() ? ((haslocaldir() == 1) ? 'lcd' : 'tcd') : 'cd'
  return cmd
enddef


#----------------------------------------------------------------------
# change directory in proper way
#----------------------------------------------------------------------
export def Chdir(path: string): void
  var cmd: string = GetCdCmd()
  # FIXME: it's strange that Vim can only cd to relative path on Windows
  var cwd: string = getcwd()
  var relpath: string = Relpath(path, cwd)
  silent exec cmd fnameescape(relpath)
enddef


#----------------------------------------------------------------------
# change dir with noautocmd prefix
#----------------------------------------------------------------------
export def ChdirNoautocmd(path: string): void
  noautocmd Chdir(path)
enddef


export def Abspath(path: string): string
  var p: string = path
  if p =~ "'."
    try
      var m: string = null_string
      redir => m
      silent exe ':marks' p[1]
      redir END
      p = split(split(m, '\n')[-1])[-1]
      p = filereadable(p) ? p : null_string
    catch
      p = '%'
    endtry
  endif
  if p == '%'
    p = expand('%')
    if &bt == 'terminal'
      p = null_string
    elseif &bt != ''
      var is_directory: bool = false
      if p =~ '\v^fugitive\:[\\\/]{3}'
        return Abspath(p)
      elseif p =~ '[\/\\]$'
        if p =~ '^[\/\\]' || p =~ '^.:[\/\\]'
          is_directory = isdirectory(p)
        endif
      endif
      p = is_directory ? p : null_string
    endif
  elseif p =~ '^\~[\/\\]'
    p = expand(p)
  elseif p =~ '\v^fugitive\:[\\\/]{3}'
    p = strpart(p, WIN ? 12 : 11)
    var pos: number = stridx(p, '.git')
    if pos >= 0
      p = strpart(p, 0, pos)
    endif
    p = fnamemodify(p, ':h')
  endif
  p = fnamemodify(p, ':p')
  p = substitute(p, '\v[\/\\]+', (WIN ? '\\\\' : '/'), 'g')
  if p =~ '\/$'
    p = fnamemodify(p, ':h')
  endif
  return p
enddef


#----------------------------------------------------------------------
# check absolute path name
#----------------------------------------------------------------------
export def IsAbs(path: string): bool
  var head: string = null_string
  if strpart(path, 0, 1) == '~'
    return true
  endif
  if WIN
    if path =~ '^.:[\/\\]' | return true | endif
    head = strpart(path, 0, 1)
    if head == '\' | return true | endif
    return false
  endif
  head = strpart(path, 0, 1)
  return head == '/'
enddef


#----------------------------------------------------------------------
# join two path
#----------------------------------------------------------------------
def JoinTwoPath(home: string, name: string): string
  if empty(home) | return name | endif
  if empty(name) | return home | endif

  if IsAbs(name)
    return name
  endif
  var path = null_string
  var size: number = strlen(home)
  var last: string = strpart(home, size - 1, 1)
  if last == SEP || (WIN && last == '/')
    path = home .. name
  else
    path = home .. SEP .. name
  endif
  path = substitute(path, '\v[\/\\]+', (WIN ? '\\\\' : '/'), 'g')
  return path
enddef


#--------------------------------------------------------------
# python: os.path.join
#--------------------------------------------------------------
export def Join(...paths: list<string>): string
  var ret: string = null_string
  for p in paths
    ret = JoinTwoPath(ret, p)
  endfor
  return ret
enddef


#----------------------------------------------------------------------
# dirname
#----------------------------------------------------------------------
export def Dirname(path: string): string
  return fnamemodify(path, ':h')
enddef


#----------------------------------------------------------------------
# basename of /foo/bar is bar
#----------------------------------------------------------------------
export def Basename(path: string): string
  return fnamemodify(path, ':t')
enddef


#----------------------------------------------------------------------
# Normalize({path} [, {lower}])
# normalize, translate path to unix format absoute path
# {lower} Whether to translate to uppercase to lowercase, useful when
#         on Windows, default: false
#----------------------------------------------------------------------
export def Normalize(path: string, lower: bool = false): string
  if empty(path) | return '' | endif

  var new_path: string = path
  if (!WIN && new_path !~ '^/') || (WIN && new_path !~ '^.:[\/\\]')
    new_path = fnamemodify(new_path, ':p')
  endif
  if WIN
    new_path = tr(new_path, '\', '/')
  endif
  if lower && (WIN || has('win32unix'))
    new_path = tolower(new_path)
  endif
  new_path = substitute(new_path, '\v/+', '/', 'g')
  if new_path =~ '^/$' || (WIN && new_path =~ '^.:/$')
    return new_path
  endif
  if new_path[-1] == '/'
    new_path = fnamemodify(new_path, ':h')
  endif
  return new_path
enddef


#----------------------------------------------------------------------
# normal case, if on Windows and path contains uppercase letter,
# change it to lowercase
#----------------------------------------------------------------------
export def Normcase(path: string): string
  return (WIN && !has('win32unix')) ? tolower(path) : path
enddef


export def Equal(path1: string, path2: string): bool
  if path1 == path2
    return true
  endif
  var p1: string = Normcase(Abspath(path1))
  var p2: string = Normcase(Abspath(path2))
  return p1 == p2
enddef


#----------------------------------------------------------------------
# return true if base directory contains child
#----------------------------------------------------------------------
export def Contains(base: string, child: string): bool
  var new_base: string = Abspath(base)
  var new_child: string = Abspath(child)
  new_base = Normalize(new_base)
  new_child = Normalize(new_child)
  new_base = Normcase(new_base)
  new_child = Normcase(new_child)
  return stridx(new_child, new_base) == 0
enddef


#----------------------------------------------------------------------
# return a relative version of a path
#----------------------------------------------------------------------
export def Relpath(path: string, base: string): string
  var new_path: string = Abspath(path)
  var new_base: string = Abspath(base)
  new_path = Normalize(new_path)
  new_base = Normalize(new_base)
  var head: string = null_string
  while true
    if Contains(new_base, new_path)
      var size: number = strlen(new_base) + (new_base =~ '/$' ? 0 : 1)
      var relpath: string = head .. strpart(new_path, size)
      if WIN
        relpath = substitute(relpath, '/', '\\\\', 'g')
      endif
      # FIXME: if remove the '.', vim will jump to home directory when
      # call `cd Relpath('.')`, no current directory
      return Join(relpath, '.')
    endif
    var prev: string = new_base
    head = '../' .. head
    new_base = fnamemodify(new_base, ':h')
    if new_base == prev
      break
    endif
  endwhile
  return null_string
enddef


#----------------------------------------------------------------------
# python: os.path.split
#----------------------------------------------------------------------
export def Split(path: string): tuple<string, string>
  var p1 = fnamemodify(path, ':h')
  var p2 = fnamemodify(path, ':t')
  return (p1, p2)
enddef


#----------------------------------------------------------------------
# split externsion, return (main, ext)
#----------------------------------------------------------------------
export def SplitExt(path: string): tuple<string, string>
  var pos: number = strridx(path, '.')
  if pos <= 0
    return (path, null_string)
  endif
  var p: number = strridx(path, SEP)
  if p > pos || p == pos - 1
    return (path, null_string)
  endif
  var main: string = strpart(path, 0, pos)
  var ext: string = strpart(path, pos + 1)
  return (main, ext)
enddef


#----------------------------------------------------------------------
# strip ending slash
#----------------------------------------------------------------------
export def StripSlash(path: string): string
  if path =~ '\v[\/\\]$'
    return fnamemodify(path, ':h')
  endif
  return path
enddef


#----------------------------------------------------------------------
# exists
#----------------------------------------------------------------------
export def Exists(path: string): bool
  return isdirectory(path) || filereadable(path) || !empty(glob(path, 1))
enddef


#----------------------------------------------------------------------
# Win2Unix({winpath} [, {prefix}])
# {prefix} Path prefix, will be add to `winpath`,
#          default: ''
#----------------------------------------------------------------------
export def Win2Unix(winpath: string, prefix: string = null_string): string
  var p: string = null_string
  if winpath =~ '^\a:[/\\]'
    var drive: string = tolower(strpart(winpath, 0, 1))
    var name: string = strpart(winpath, 3)
    name = substitute(name, '\v[\/\\]+', '/', 'g')
    p = Join(prefix, drive, name)
    return substitute(p, '\v[\/\\]+', '/', 'g')
  elseif winpath =~ '^[/\\]'
    var drive: string = tolower(strpart(getcwd(), 0, 1))
    var name: string = strpart(winpath, 1)
    name = substitute(name, '\v[\/\\]+', '/', 'g')
    p = Join(prefix, drive, name)
    return substitute(p, '\v[\/\\]+', '/', 'g')
  else
    return substitute(winpath, '\v[\/\\]+', '/', 'g')
  endif
enddef


#----------------------------------------------------------------------
# Shorten({path} [, {limit}])
# shorten path
# {limit} The path length limit, default: 40
#----------------------------------------------------------------------
export def Shorten(path: string, limit: number = 40): string
  var home: string = expand('~')
  var new_path: string = path
  var size: number = 0
  if Contains(home, path)
    size = strlen(home)
    new_path = Join('~', strpart(new_path, size + 1))
  endif
  size = strlen(new_path)
  if size > limit
    var t: string = pathshorten(new_path, 2)
    size = strlen(t)
    if size > limit
      return pathshorten(new_path)
    endif
    return t
  endif
  return new_path
enddef


#---------------------------------------------------------------
# return the temporary directory path
#---------------------------------------------------------------
export def Tmpdir(): string
  return fnamemodify(tempname(), ':h')
enddef


#---------------------------------------------------------------
# return the temporary file path
#---------------------------------------------------------------
export def Tmpfile(): string
  return tempname()
enddef
