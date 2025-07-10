vim9script

import autoload "./platform.vim" as platform
import autoload "./path.vim" as path

const WIN: bool = platform.WIN

#----------------------------------------------------------------------
# guess root
#----------------------------------------------------------------------
def GuessRoot(filename: string, markers: list<string>): string
  var fullname: string = path.Abspath(filename)
  var pivot: string = fullname
  if !isdirectory(pivot)
    pivot = fnamemodify(pivot, ':h')
  endif
  while true
    var prev: string = pivot
    for marker in markers
      var newname: string = path.Join(pivot, marker)
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
    pivot = fnamemodify(pivot, ':h')
    if pivot == prev
      break
    endif
  endwhile
  return null_string
enddef


#----------------------------------------------------------------------
# FindRoot({name}, {markers}, {strict})
# find project root
# {name} path, bufnr or '%'
# {markers} root markers
# {strict} if true, return null_string when not found, otherwise the cwd
#----------------------------------------------------------------------
def FindRoot(name: any, markers: list<string> = null_list,
    strict: bool = false): string
  var fpath: string = null_string
  var root: string = null_string
  if type(name) == v:t_number
    var bid: number = (name < 0) ? bufnr('%') : name
    fpath = bufname(bid)
    root = getbufvar(bid, 'ivim_root', null_string)
    if root != null
      return root
    elseif exists('g:ivim_root') && g:ivim_root != null_string
      return g:ivim_root
    elseif exists('g:ivim_root_locator')
      root = call(g:ivim_root_locator, [bid])
      if root != null
        return root
      endif
    endif
    if getbufvar(bid, '&buftype') != null_string
      fpath = getcwd()
      return path.Abspath(fpath)
    endif
  elseif name == '%'
    fpath = name
    if exists('b:ivim_root') && b:ivim_root != null
      return b:ivim_root
    elseif exists('t:ivim_root') && t:ivim_root != null
      return t:ivim_root
    elseif exists('g:ivim_root') && g:ivim_root != null
      return g:ivim_root
    elseif exists('g:ivim_root_locator')
      root = call(g:ivim_root_locator, [name])
      if root != null
        return root
      endif
    endif
  else
    fpath = printf('%s', name)
  endif
  root = GuessRoot(fpath, markers)
  if root != null
    return path.Abspath(root)
  elseif strict
    return null_string
  endif
  # Not found: return parent directory of current file / file itself.
  var fullname: string = path.Abspath(fpath)
  if isdirectory(fullname)
    return fullname
  endif
  return path.Abspath(fnamemodify(fullname, ':h'))
enddef


#----------------------------------------------------------------------
# GetRoot({path} [, {markers}, {strict}])
# get project root
# {name} path, bufnr or '%'
# {markers} root markers
# {strict} if true, return null_string if not found, otherwise the cwd
#----------------------------------------------------------------------
export def GetRoot(fpath: string, markers: list<string> = null_list,
    strict: bool = false): string
  var new_markers: list<string> = get(g:, 'ivim_rootmarkers',
    ['.root', '.git', '.hg', '.svn', '.project'])
  if markers != null
    new_markers = markers
  endif
  var hr: string = FindRoot(fpath, new_markers, strict)
  return hr
enddef


#----------------------------------------------------------------------
# current root
#----------------------------------------------------------------------
export def CurRoot(): string
  return GetRoot('%')
enddef
