vim9script

import autoload "../../autoload/ilib/path.vim" as ipath
import autoload "../../autoload/ilib/platform.vim" as iplatform
import autoload "../../autoload/imodule/plug.vim" as iplug
import autoload "../../autoload/imodule/keymap.vim" as ikeymap

g:asynctasks_extra_config = get(g:, 'asynctasks_extra_config', [])
g:asynctasks_extra_config += [
  ipath.Abspath(ipath.Join(g:ivim_home,
    'site/third_party/asynctasks/tasks.ini')
  )
]

g:asyncrun_open = 6
g:asyncrun_rootmarks = g:ivim_rootmarkers
g:asyncrun_shell = iplatform.WIN ? 'bash' : 'pwsh'
g:asynctasks_rtp_config = "asynctasks.ini"

# python will buffer everything written to stdout when running as a backgroup
# process, this can see the realtime output without calling `flush()`
$PYTHONUNBUFFERED = 1

# {{{ LeaderF integration
# https://github.com/skywind3000/asynctasks.vim/wiki/UI-Integration
if iplug.Has('LeaderF')
  nnoremap <leader>pt <Cmd>Leaderf --nowrap task<CR>
  ikeymap.AddGroup('<leader>p', 'project')
  ikeymap.AddDesc('<leader>pt', 'Query Tasks')

  def LfTaskSource(..._): list<string>
    var rows: list<list<string>> = asynctasks#source(&columns * 48 / 100)
    var source: list<string> = []
    for row in rows
      var name: string = row[0]
      source += [name .. '  ' .. row[1] .. '  : ' .. row[2]]
    endfor
    return source
  enddef


  def LfTaskAccept(line: string, ..._): void
    var pos: number = stridx(line, '<')
    if pos < 0
      return
    endif
    var name: string = strpart(line, 0, pos)
    name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
    if name != ''
      exec "AsyncTask " .. name
    endif
  enddef

  def LfTaskDigest(line: string, ..._): list<any>
    var pos: number = stridx(a:line, '<')
    if pos < 0
      return [line, 0]
    endif
    var name: string = strpart(line, 0, pos)
    return [name, 0]
  enddef


  g:Lf_Extensions = get(g:, 'Lf_Extensions', {})
  g:Lf_Extensions.task = {
    'source': string(function('s:LfTaskSource'))[10 : -3],
    'accept': string(function('s:LfTaskAccept'))[10 : -3],
    'get_digest': string(function('s:LfTaskDigest'))[10 : -3],
    'highlights_def': {
        'Lf_hl_funcScope': '^\S\+',
        'Lf_hl_funcDirname': '^\S\+\s*\zs<.*>\ze\s*:',
    },
    'help': 'navigate available tasks from asynctasks.vim',
  }
endif
# }}}
