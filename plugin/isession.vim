vim9script

if exists('g:isession_loaded')
  finish
endif
g:isession_loaded = 1

import autoload "../autoload/ilib/core.vim" as icore
import autoload "../autoload/ilib/path.vim" as ipath
import autoload "../autoload/ilib/project.vim" as iproject
import autoload "../autoload/ilib/ui.vim" as iui
import autoload "../autoload/imodule/plug.vim" as iplug
import autoload "../autoload/imodule/keymap.vim" as ikeymap

g:ivim_cache_dir = get(g:, 'ivim_cache_dir', resolve(expand('~/.cache/vim')))
g:ivim_session_dir = get(g:, 'ivim_session_dir',
  ipath.Join(g:ivim_cache_dir, 'session'))
# auto update session when leave vim
g:ivim_auto_update_session = get(g:, 'ivim_auto_update_session', 1)

var s_session_dir = resolve(expand(g:ivim_session_dir))
var s_auto_update_session = g:ivim_auto_update_session

def g:SessionList(arglead: string, ..._): list<string>
  if !isdirectory(s_session_dir)
    return []
  endif

  var files: list<string> = map(
    split(globpath(s_session_dir, arglead .. '*'), '\n'),
    'fnamemodify(v:val, ":t")'
  )
  return files
enddef

def WriteSessionFile(name: string): void
  var new_name: string = fnamemodify(name, ':t')
  exec 'silent mksession!' ipath.Join(s_session_dir, new_name)
enddef

# SessionSave({bang} [, {name} [, {silent}]])
def g:SessionSave(bang: bool = false, name: string = null_string,
    silent: bool = false): void
  # ensure session directory exists
  if !isdirectory(s_session_dir)
    var choice: number = icore.Confirm(
      s_session_dir .. ' is not exists, create it?', "&Yes\n&No", 1)
    if choice == 1
      silent mkdir(s_session_dir, 'p')
    else
      iui.Error('The session directory does not exist: ' .. s_session_dir)
      return
    endif
  endif

  var new_name: string = name
  if new_name == null
    new_name = icore.Input('Session name: ',
      fnamemodify(iproject.CurRoot(), ':t'), 'customlist,g:SessionList'
    )
  endif
  if empty(new_name)
    iui.Error('Need session name')
    return
  endif

  var file: string = ipath.Join(s_session_dir, new_name)

  if filereadable(file) && !bang
    var choice: number = icore.Confirm(
      new_name .. ' is already exist, overwrite?', "&Yes\n&No", 2)
    if choice != 1
      return
    endif
  endif

  WriteSessionFile(new_name)

  if !silent
    iui.Info('Saved session [' .. new_name .. ']')
  endif
enddef

# TODO: support load_last_session
# SessionLoad({load_last_session} [, {name} [, {silent}]])
def g:SessionLoad(load_last_session: bool = false, name: string = null_string,
    silent: bool = false): void
  if !isdirectory(s_session_dir)
    iui.Error('The session direcotry does not exist: ' .. s_session_dir)
    return
  endif

  var new_name: string = name
  if new_name == null
    new_name = icore.Input('Session name: ', '', 'customlist,g:SessionList')
  endif
  if empty(new_name)
    iui.Error('Need session name')
    return
  endif

  var file: string = ipath.Join(s_session_dir, new_name)
  if !filereadable(file)
    iui.Error('The session file does not exist: ' .. file)
    return
  endif

  # remove all buffers first
  bufdo bd
  exec 'source' file
  if !silent
    iui.Info('Loaded session [' .. new_name .. ']')
  endif
enddef

# SessionDelete({bang} [, {name} [, {silent}]])
def g:SessionDelete(bang: bool = false, name: string = null_string,
    silent: bool = false): void
  if !isdirectory(s_session_dir)
    iui.Error('The session direcotry does not exist: ' .. s_session_dir)
    return
  endif

  var new_name: string = name
  if new_name == null
    new_name = icore.Input('Session name: ', '', 'customlist,g:SessionList')
  endif
  if empty(new_name)
    iui.Error('Need session name')
    return
  endif

  var file: string = ipath.Join(s_session_dir, new_name)
  if !filereadable(file)
    iui.Error('No such file: ' .. file)
    return
  endif
  if !bang
    var choice: number = icore.Confirm(
      'Delete session ' .. new_name .. '?', "&Yes\n&No", 2)
    if choice != 1
      return
    endif
  endif
  delete(file)
  if !silent
    iui.Warn('Delete session [' .. new_name .. ']')
  endif
enddef

def g:SessionClose(): void
  if exists('v:this_session') && filereadable(v:this_session)
    WriteSessionFile(fnameescape(v:this_session))
    v:this_session = ''
  endif
  bufdo bd
enddef

command! -nargs=? -bar -bang -complete=customlist,g:SessionList
      \ IvimSessionSave g:SessionSave(<bang>0, <f-args>)
command! -nargs=? -bar -bang -complete=customlist,g:SessionList
      \ IvimSessionLoad g:SessionLoad(<bang>0, <f-args>)
command! -nargs=? -bar -bang -complete=customlist,g:SessionList
      \ IvimSessionDelete g:SessionDelete(<bang>0, <f-args>)
command! -nargs=0 -bar IvimSessionClose g:SessionClose()
command! -nargs=0 IvimRoot iui.Info(iproject.CurRoot())

augroup ivim_plugin_isession
  au!
  au VimLeavePre * if g:ivim_auto_update_session &&
        \ exists('v:this_session') && filewritable(v:this_session)
    | WriteSessionFile(fnameescape(v:this_session)) | endif
augroup END

# {{{ leaderf integration
if iplug.Has('LeaderF')
  nnoremap <leader>sp <Cmd>Leaderf project<CR>
  ikeymap.AddDesc('<leader>sp', 'Project')

  def LfProjectSource(..._): list<string>
    return g:SessionList('')
  enddef

  def LfPorjectAccept(line: string, arg: any): void
    if !empty(line)
      g:SessionLoad(0, line)
    endif
  enddef

  g:Lf_Extensions = get(g:, 'Lf_Extensions', {})
  g:Lf_Extensions.project = {
    'source': string(function('LfProjectSource'))[10 : -3],
    'accept': string(function('LfPorjectAccept'))[10 : -3],
    'help': 'navigate available project from session_mgr.vim',
  }
endif

# }}}
