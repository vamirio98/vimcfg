vim9script

import autoload "../../autoload/imodule/keymap.vim" as ikeymap
import autoload "../../autoload/imodule/plug.vim" as iplug
import autoload "../../autoload/ilib/core.vim" as icore
import autoload "../../autoload/ilib/ui.vim" as iui
import autoload "../../autoload/ilib/project.vim" as iproject
import autoload "../../autoload/ilib/string.vim" as istring

g:gitgutter_map_keys = 0

g:gitgutter_sign_priority = 1
g:gitgutter_sign_added = '▎'
g:gitgutter_sign_modified = '▎'
g:gitgutter_sign_removed = ''

g:gitgutter_close_preview_on_escape = 0

g:gitgutter_grep = 'rg --color=never'

# map {{{
var SetGroup: func = ikeymap.SetGroup
var SetDesc: func = ikeymap.SetDesc

SetGroup('<leader>g', 'git')

nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)
SetDesc('[c', 'Prev Hunk')
SetDesc(']c', 'Next Hunk')

# {{{ git diff base
def IsGitRepo(cwd: string = null_string): bool
  var path = cwd == null ? expand('%:h') : cwd
  var res = icore.System('git rev-parse --is-inside-work-tree', cwd)
  res = istring.Strip(res)
  return res == 'true'
enddef
def GetGitCommits(cwd: string = null_string, reflog: bool = false): list<string>
  var path: string = cwd == null ? iproject.CurRoot() : cwd
  if !IsGitRepo(path)
    return []
  endif

  var cmd: string = reflog ? 'git reflog' : 'git log --oneline'
  var res = icore.System(cmd, path)
  var commits: list<string> = split(res, "\n")
  return commits
enddef
if iplug.Has('LeaderF')
  def LfGitDiffBaseSource(..._): list<string>
    return GetGitCommits(iproject.CurRoot())
  enddef

  def LfGitDiffBaseAccept(line: string, arg: any): void
    if empty(line)
      return
    endif

    var token = split(line, ' ')
    var hash: string = token[0]
    g:gitgutter_diff_base = hash
    iui.Warn(printf('Change git diff base to [ %s ]', line), true)
  enddef

  g:Lf_Extensions = get(g:, 'Lf_Extensions', {})
  g:Lf_Extensions.git_diff_base = {
    'source': string(function('LfGitDiffBaseSource'))[10 : -3],
    'accept': string(function('LfGitDiffBaseAccept'))[10 : -3],
    'highlights_def': {
      'Lf_hl_funcScope': '^\S\+'
    },
    'help': 'navigate git diff base'
  }

  nnoremap <leader>gb <Cmd>Leaderf git_diff_base<CR>
else
  def ChangeGitBase(): void
    var commits: list<string> = GetGitCommits(iproject.CurRoot())
    if empty(commits)
      iui.Warn('No commit found')
      return
    endif

    if len(commits) > 9
      commits = commits[0 : 9]
    endif
    commits = map(commits, (index, value) => printf('%d. %s', index + 1, value))
    commits = insert(commits, 'Select new git diff base:')
    var choice: number = icore.Inputlist(commits)
    if choice <= 0 || choice >= len(commits)
      return
    endif
    var token = split(commits[choice], ' ')
    var hash: string = token[1]
    var log: string = commits[choice][len(token[0]) + 1 : -1]
    g:gitgutter_diff_base = hash
    iui.Warn(printf('Change git diff base to [ %s ]', log), true)
  enddef
  nnoremap <leader>gb <ScriptCmd>ChangeGitBase()<CR>
endif
SetDesc('<leader>gb', 'Change Git Base')
# }}}

def PreviewHunk(): void
  exec 'GitGutterPreviewHunk'
  silent! wincmd P
enddef
nmap <leader>gp <ScriptCmd>PreviewHunk()<CR>
SetDesc('<leader>gp', 'Preview Hunk')

command! IvimGitHunk  GitGutterQuickFix | LeaderfQuickFix
nnoremap <leader>gs <Cmd>IvimGitHunk<CR>
SetDesc('<leader>gs', 'Search Hunk')

omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)
SetDesc('ih', 'Inner Hunk', 'v')
SetDesc('ah', 'Outer Hunk', 'v')

augroup ivim_git
  au!
  au FileType diff nnoremap gq <Cmd>close<CR>
augroup END
# }}}
