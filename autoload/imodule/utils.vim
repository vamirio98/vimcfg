vim9script

import autoload "../ilib/core.vim" as icore

export def BufDel(btarget: number = bufnr('%')): void
  if &modified
    var choice: number = icore.Confirm(printf('Save changes to %s',
      bufname(btarget)), "&Yes\n&No\n&Cancel")
    if choice == 0 || choice == 3 # 0 for <Esc>/<C-c> and 3 for Cancel
      return
    endif
    if choice == 1 # Yes
      update
    endif
  endif

  var wins: list<number> = filter(range(1, winnr('$')),
    'winbufnr(v:val) == ' .. btarget)
  var curr_win: number = winnr()
  for w in wins
    # locate to the aim window
    exec printf(':%dwincmd w', w)
    # try using alternate buffer or previous buffer
    var alt: number = bufnr('#')
    if alt > 0 && buflisted(alt) && alt != btarget
      buffer #
    else
      try
        bprevious
      catch /E85: There is no listed buffer/
        # do nothing
      endtry
    endif

    if btarget == bufnr('%')
      # numbers of listed buffers which are not the target to be deleted
      var blisted: list<number> = filter(range(1, bufnr('$')),
        'buflisted(v:val) && v:val != ' .. btarget)
      # listed, not target and not displayed
      var bhidden: list<number> = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      # take the first buffer, if any (could be more intelligent)
      var bjump: number = (bhidden + blisted + [-1])[0]
      if bjump > 0
        exec 'buffer' bjump
      else
        exec 'enew'
      endif
    endif
  endfor

  exec 'bdelete!' btarget
  exec printf(':%dwincmd w', curr_win)
enddef

export def BufDelOther(): void
  var bufs: string = execute('ls')
  var curbuf: number = bufnr('%')
  for bufline in split(bufs, '\n')
    var buf: number = str2nr(split(bufline, ' ')[0])
    if buf != curbuf
      BufDel(buf)
    endif
  endfor
enddef
