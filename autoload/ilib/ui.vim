vim9script

var msg_queue = []
export var vim_enter: bool = false

def Show(what: any, color: string = 'Normal', keep: bool = false): void
  var msg = type(what) == v:t_list ? join(what, '\n') : what
  if !vim_enter
    msg_queue += [function('Show', [msg, color])]
    return
  endif

  redraw
  exec 'echohl ' .. color
  exec printf('echo%s "%s"', (keep ? 'm' : ''), msg)
  echohl None
enddef

export def Error(what: any, keep: bool = true)
  Show(what, 'ErrorMsg', keep)
enddef

export def Warn(what: any, keep: bool = true)
  Show(what, 'WarningMsg', keep)
enddef

export def Info(what: any, keep: bool = false)
  Show(what, 'Identifier', keep)
enddef
