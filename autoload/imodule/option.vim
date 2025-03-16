let s:options = {}
let g:imodule#option#options = s:options

function! s:GenGet(name)
  return {-> eval('&'.a:name)}
endfunc

function! s:GenSet(name)
  return {on -> execute('setlocal '.(on ? '' : 'no').a:name)}
endfunc

function! s:ToggleAndNotify(name, opt)
  let opt = a:opt
  if !has_key(opt, 'on')
    call opt.set(!opt.get())
    call lib#ui#info((opt.get() ? 'enable' : 'disable').' '.a:name)
  else
    execute('setlocal '.a:name.'='.(opt.get() == opt.on ? opt.off : opt.on))
    call lib#ui#info('set '.a:name.' = '.opt.get())
  endif
endfunc

" imodule#option#toggle(name, opt)
" {name}: string, option name, should be a unique identity
" [{opt}]:
"   [{get}]: funcref, to get option
"   [{set}]: funcref, to set option
"   [{on}]: any, used as true in {get}
"   [{off}]: any, used as false in {get}
function! imodule#option#gen(name, ...) abort
  let opt = a:0 > 0 ? deepcopy(a:1) : {}
  " check for unique, it not, show a warn message
  if has_key(s:options, a:name)
    call lib#ui#warn('already has a '.a:name)
  endif
  if xor(has_key(opt, 'on'), has_key(opt, 'off'))
    throw '{on} and {off} should appear in pairs'
  endif

  let s:options[a:name] = opt

  let opt.get = get(opt, 'get', s:GenGet(a:name))
  let opt.set = get(opt, 'set', s:GenSet(a:name))

  let s:options[a:name].toggle = function('s:ToggleAndNotify', [a:name, opt])
  return s:options[a:name]
endfunc

function! imodule#option#get(name) abort
  if has_key(s:options, a:name)
    return s:options[a:name]
  else
    return {'toggle':
          \ function('lib#ui#error', ['option '''.a:name.''' not found']) }
  endif
endfunc

function! imodule#option#toggle(option) abort
  call a:option.toggle()
endfunc
