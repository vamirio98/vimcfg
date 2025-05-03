vim9script

var s_msg_queue = []

def Show(what: any, color: string = 'Normal', keep: bool = false): void
  var msg = type(what) == v:t_list ? join(what, '\n') : what
  if !v:vim_did_enter
    s_msg_queue += [function('Show', [msg, color])]
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

augroup ivim_ilib_ui
  au!
  au VimEnter * for Msg in s_msg_queue | Msg() | endfor | s_msg_queue = []
augroup END
