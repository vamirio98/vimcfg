vim9script

import autoload "../../autoload/ilib/path.vim" as ipath
import autoload "../../autoload/ilib/project.vim" as iproject
import autoload "../../autoload/imodule/plug.vim" as iplug
import autoload "../../autoload/imodule/keymap.vim" as ikeymap

g:Lf_ShortcutF = ''
g:Lf_ShortcutB = ''

g:Lf_WildIgnore = {
  'dir': g:ivim_rootmarkers,
  'file': ['*.sw?', '~$*', '*.bak', '*.exe', '*.o', '*.so', '*.py[co]']
}

g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
g:Lf_RootMarkers = g:ivim_rootmarkers
g:Lf_CommandMap = {}
g:Lf_NormalCommandMap = { '*': { '<F1>': '?' } }
g:Lf_HideHelp = 1
g:Lf_RecurseSubmodules = 1 # only work with git 2.11+
g:Lf_ReverseOrder = 0
g:Lf_HistoryExclude = {
  'cmd': ['^w!?', '^q!?', '^.\s*$'],
  'search': ['^Plug']
}
g:Lf_UseVersionControlTool = 0
g:Lf_IgnoreCurrentBufferName = 1
g:Lf_ShowHidden = 1

# {{{ hide help file in MRU
g:Lf_MruFileExclude = get(g:, 'Lf_MruFileExclude', [])
for plug in values(g:plugs)
  var plug_dir: string = plug.dir
  var doc: string = ipath.Join(plug_dir, 'doc', '*')
  g:Lf_MruFileExclude += [doc]
endfor
# }}}

# vim-gutentags integration {{{
if iplug.Has('vim-gutentags')
  g:Lf_GtagsGutentags = 1
  g:Lf_CacheDirectory = g:ivim_cache_dir
  var tag_cache_dir: string = expand(g:Lf_CacheDirectory .. '/LeaderF/gtags')
  if !isdirectory(tag_cache_dir)
    silent! mkdir(tag_cache_dir, 'p')
  endif
  # set dir to save the tag file
  g:gutentags_cache_dir = tag_cache_dir
endif
# }}}

# {{{ keymap
var AddGroup: func = ikeymap.AddGroup
var AddDesc: func = ikeymap.AddDesc

# {{{ file
def SearchFileInProject()
  var root = iproject.GetRoot('.')
  exec 'LeaderfFile' root
enddef

AddGroup('<leader>f', 'file')

nnoremap <leader>ff <ScriptCmd>call SearchFileInProject()<CR>
AddDesc('<leader>ff', 'Search File (Project Root)')
nnoremap <leader>fF <Cmd>LeaderfFile .<CR>
AddDesc('<leader>fF', 'Search File (Cwd)')

nnoremap <leader>fr <Cmd>LeaderfMru<CR>
AddDesc('<leader>fr', 'Recent File')
nnoremap <leader>fR <Cmd>LeaderfMruCwd<CR>
AddDesc('<leader>fR', 'Recent File (Cwd)')
# }}}

# gtags {{{
AddGroup('<leader>g', 'gtags')
nmap <leader>gd <Plug>LeaderfGtagsDefinition
AddDesc('<leader>gd', 'Gtags Definition')
nmap <leader>gg <Plug>LeaderfGtagsGrep
AddDesc('<leader>gg', 'Gtags Word')
nmap <leader>gr <Plug>LeaderfGtagsReference
AddDesc('<leader>gr', 'Gtags Reference')
nmap <leader>gS <Plug>LeaderfGtagsSymbol
AddDesc('<leader>gS', 'Gtags Symbol')
# }}}

# {{{ search
AddGroup('<leader>s', 'search')

nnoremap <leader>sb <Cmd>LeaderfBuffer<CR>
AddDesc('<leader>sb', 'Buffer')

nnoremap <leader>sc <Cmd>LeaderfHistoryCmd<CR>
AddDesc('<leader>sc', 'Command History')

nnoremap <leader>sh <Cmd>LeaderfHelp<CR>
AddDesc('<leader>sh', 'Help Tag')

nnoremap <leader>sj <Cmd>Leaderf jumps<CR>
AddDesc('<leader>sj', 'Jump List')

nnoremap <leader>sk <Cmd>LeaderfMap<CR>
AddDesc('<leader>sk', 'Keymap')

nnoremap <leader>sl <Cmd>LeaderfLocList<CR>
AddDesc('<leader>sl', 'Location List')
nnoremap <leader>sL <Cmd>LeaderfSelf<CR>
AddDesc('<leader>sL', 'Leaderf Command')

nnoremap <leader>sm <Cmd>LeaderfMark<CR>
AddDesc('<leader>sm', 'Mark')

nnoremap <leader>sq <Cmd>LeaderfQuickFix<CR>
AddDesc('<leader>sq', 'Quickfix')

nnoremap <leader>sf <Cmd>LeaderfFunction<CR>
AddDesc('<leader>sf', 'Function (Current File)')

nnoremap <leader>st <Cmd>LeaderfBufTag<CR>
AddDesc('<leader>st', 'Tag (Current File)')
nnoremap <leader>sT <Cmd>LeaderfTag<CR>
AddDesc('<leader>sT', 'Tag (Workspace)')

nnoremap <leader>s: <Cmd>LeaderfCommand<CR>
AddDesc('<leader>s:', 'Command')
nnoremap <leader>s/ <Cmd>LeaderfHistorySearch<CR>
AddDesc('<leader>s/', 'Search History')
def LiveSearchInRoot(): void
  var root: string = iproject.CurRoot()
  exec 'Leaderf rg --live --no-fixed-string' root
enddef
nnoremap <leader>/ <ScriptCmd>LiveSearchInRoot()<CR>
AddDesc('<leader>/', 'Live Search (Root)')
# }}}

# }}}
