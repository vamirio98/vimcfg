vim9script

import autoload "./ui.vim" as iui
import autoload "./path.vim" as ipath

# for anonymous buffers
var s_anon: list<number> = []
# for named buffers
var s_named: dict<number> = {}  # all buffers have key 'name'


#---------------------------------------------------------------
# buffer local object
#---------------------------------------------------------------
export def Object(bid: number): dict<any>
  if !bufexists(bid)
    return null_dict
  endif

  var name: string = '__ivim__'
  var obj: dict<any> = null_dict
  if type(getbufvar(bid, name, 0)) != v:t_dict
    setbufvar(bid, name, {})
    obj = getbufvar(bid, name)
  else
    obj = getbufvar(bid, name)
  endif

  return obj
enddef


#---------------------------------------------------------------
# check whether buffer has variable
#---------------------------------------------------------------
export def Has(bid: number, varname: string): bool
  var obj: dict<any> = Object(bid)
  if obj == null
    return false
  endif
  return has_key(obj, varname)
enddef


#---------------------------------------------------------------
# setbufvar
#---------------------------------------------------------------
export def SetVar(bid: number, varname: string, value: any): void
  var obj: dict<any> = Object(bid)
  if obj != null
    obj[varname] = value
  endif
enddef


#---------------------------------------------------------------
# getbufvar
#---------------------------------------------------------------
export def GetVar(bid: number, varname: string, default: any): any
  var obj: dict<any> = Object(bid)
  return get(obj, varname, default)
enddef


#---------------------------------------------------------------
# autocmd
#---------------------------------------------------------------
export def Autocmd(bid: number, event: string, funcname: string): void
  exe printf("autocmd %s <buffer=%d> %s()", event, bid, funcname)
enddef


#---------------------------------------------------------------
# remove all autocmd
#---------------------------------------------------------------
export def RemoveAutocmd(bid: number, event: string): void
  exe printf("autocmd! %s <buffer=%d>", event, bid)
enddef


#---------------------------------------------------------------
# check whether the buffer is a named buffer
#---------------------------------------------------------------
def IsNamed(bid: number): bool
  var obj: dict<any> = Object(bid)
  return has_key(obj, 'name')
enddef


#---------------------------------------------------------------
# sync buffer to disk
#---------------------------------------------------------------
def Sync(bid: number): void
  var cur_bid: number = bufnr('%')
  silent exe 'buffer' bid
  silent exe 'update'
  silent exe 'buffer' cur_bid
enddef


def MakeTextList(textlist: any): list<string>
  if type(textlist) == v:t_list
    return textlist
  elseif type(textlist) == v:t_string
    return split(textlist, '\n', 1)
  else
    return split(string(textlist), '\n', 1)
  endif
enddef


#---------------------------------------------------------------
# update buffer content
#---------------------------------------------------------------
export def Update(bid: number, textlist: any): number
  var text: list<string> = MakeTextList(textlist)

  var modifiable: bool = getbufvar(bid, '&modifiable', 0)
  setbufvar(bid, '&modifiable', 1)
  var ret: number =
    (!deletebufline(bid, 1, '$') && setbufline(bid, 1, text)) ? 0 : -1
  setbufvar(bid, '&modifiable', modifiable)

  return ret
enddef


#---------------------------------------------------------------
# clear buffer content
#---------------------------------------------------------------
export def Clear(bid: number): number
  return Update(bid, [])
enddef


#---------------------------------------------------------------
# append text to buffer
#---------------------------------------------------------------
export def Append(bid: number, lnum: number, textlist: any): number
  var text: list<string> = MakeTextList(textlist)

  var modifiable: bool = getbufvar(bid, '&modifiable', 0)
  setbufvar(bid, '&modifiable', 1)
  var ret: number = appendbufline(bid, lnum, text)
  setbufvar(bid, '&modifiable', modifiable)

  return ret
enddef


#---------------------------------------------------------------
# delete line [first, last]
#---------------------------------------------------------------
export def DeleteLine(bid: number, first: number, last: any): number
  var modifiable: bool = getbufvar(bid, '&modifiable', 0)
  setbufvar(bid, '&modifiable', 1)
  var ret: number = deletebufline(bid, first, last)
  setbufvar(bid, '&modifiable', modifiable)

  return ret
enddef


#---------------------------------------------------------------
# setbufline
#---------------------------------------------------------------
export def SetLine(bid: number, lnum: number, textlist: any): number
  var text: list<string> = MakeTextList(textlist)

  var modifiable: bool = getbufvar(bid, '&modifiable', 0)
  setbufvar(bid, '&modifiable', 1)
  var ret: number = setbufline(bid, lnum, text)
  setbufvar(bid, '&modifiable', modifiable)

  return ret
enddef


#---------------------------------------------------------------
# getbufline [first, last]
#---------------------------------------------------------------
export def GetLine(bid: number, first: number, last: any): list<string>
  return getbufline(bid, first, last)
enddef


#---------------------------------------------------------------
# alloc a new buffer
#
# Alloc([named [, name]])
# {named}: allocate a anonymous buffer or a named buffer
# {name}: buffer name, only used when {named} is `true`
#---------------------------------------------------------------
export def Alloc(named: bool = false, name: string = null_string): number
  var bid: number = -1
  var filepath: string = null_string
  var new_name: string = name
  var new: bool = false

  if !named
    if len(s_anon) > 0
      bid = remove(s_anon, -1)
    else
      silent bid = bufadd('')
      new = true
    endif
  else
    if len(s_named) > 0 && (name == null || has_key(s_named, name))
      bid = s_named[name]
      remove(s_named, name)
    else
      if name != null
        filepath = ipath.Join(ipath.Tmpdir(), name)
      else
        filepath = ipath.Tmpfile()
        new_name = ipath.Basename(filepath)
      endif
      silent bid = bufadd(filepath)
      new = true
    endif
  endif

  if new
    silent bufload(bid)

    # make buffer a scratch buffer, see :h scratch
    setbufvar(bid, '&buflisted', 0)
    setbufvar(bid, '&bufhidden', 'hide')
    setbufvar(bid, '&buftype', 'nofile')
    setbufvar(bid, 'noswapfile', 1)
  endif

  setbufvar(bid, '&modifiable', 1)

  silent deletebufline(bid, 1, '$')
  if named
    SetVar(bid, 'name', new_name)
    SetVar(bid, 'path', filepath)
  endif
  setbufvar(bid, '&modifiable', 0)
  setbufvar(bid, '&filetype', '')

  return bid
enddef


#---------------------------------------------------------------
# free a buffer
#---------------------------------------------------------------
export def Free(bid: number): void
  var named: bool = IsNamed(bid)
  if !named
    add(s_anon, bid)
  else
    s_named[Object(bid)['name']] = bid
  endif
  Clear(bid)
enddef
