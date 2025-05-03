vim9script

import autoload "../../autoload/imodule/keymap.vim" as ikeymap
import autoload "../../autoload/ilib/ui.vim" as iui

# {{{ setting
set noshowmode
set laststatus=2
set hidden # allow buffer switching without saving
set showtabline=2

g:lightline#bufferline#filter_by_tabpage = 1
g:lightline#bufferline#enable_devicons = 1

def g:LightlineBufferlineFilter(buffer: number): bool
  return getbufvar(buffer, '&buftype') !=# 'terminal'
enddef

if !exists('g:lightline')
  g:lightline = {}
endif

g:lightline.subseparator = {'left': '|', 'right': '|'}
g:lightline.tabline_subseparator = g:lightline.subseparator

g:lightline#bufferline#buffer_filter = "g:LightlineBufferlineFilter"

g:lightline.colorscheme = 'gruvbox_material'

g:lightline.active = {
  'left': [ ['mode', 'paste'],
    ['gitbranch', 'lspdiag', 'filename', 'modified'],
  ],
  'right': [ ['lineinfo'], ['percent'],
    ['gitsummary', 'fileformat', 'filetype'],
  ]
}
g:lightline.tabline = {
  'left': [ ['buffers'] ],
  'right': [ ['tabs'] ],
}

g:lightline.component_function = {}
g:lightline.component_expand = {
  'buffers': 'lightline#bufferline#buffers',
  'gitsummary': "g:IvimStlGitSummary",
  'lspdiag': 'g:IvimStlLspDiag',
  'gitbranch': 'g:IvimStlGitBranch',
}
g:lightline.component_type = {
  'buffers': 'tabsel',
}
# }}}

# {{{ component utils
def SetupStlColor()
  hi! link IvimStlA LightlineLeft_normal_0
  hi! link IvimStlB LightlineLeft_normal_1
  hi! link IvimStlC LightlineRight_normal_2
  hi! link IvimStlX LightlineRight_normal_2
  hi! link IvimStlY LightlineRight_normal_1
  hi! link IvimStlZ LightlineRight_normal_0

  SetupStlGitSumColor()
  SetupStlLspDiagColor()
  SetupStlGitBranchColor()
enddef

def NewColor(name: string, bg: string, fg: string): void
  var nbg: dict<any> = hlget(bg, 1)[0]
  var nfg: dict<any> = hlget(fg, 1)[0]
  exec printf('hi! %s ctermbg=%s ctermfg=%s guibg=%s guifg=%s',
    name, nbg.ctermbg, nfg.ctermfg, nbg.guibg, nfg.guifg)
enddef

#---------------------------------------------------------------
# git summary
#---------------------------------------------------------------
def SetupStlGitSumColor(): void
  NewColor('IvimStlGitSumAdd', 'IvimStlX', 'GitGutterAdd')
  NewColor('IvimStlGitSumChange', 'IvimStlX', 'GitGutterChange')
  NewColor('IvimStlGitSumDelete', 'IvimStlX', 'GitGutterDelete')
enddef

def g:IvimStlGitSummary(): string
  var [a, m, r] = g:GitGutterGetHunkSummary()
  return printf('%s%s%s%s%s',
    (a == 0 ? '' : '%#IvimStlGitSumAdd#+' .. string(a) .. '%*'),
    (m + r > 0 ? ' ' : ''),
    (m == 0 ? '' : '%#IvimStlGitSumChange#~' .. string(m) .. '%*'),
    (m > 0 && r > 0 ? ' ' : ''),
    (r == 0 ? '' : '%#IvimStlGitSumDelete#-' .. string(r) .. '%*')
  )
enddef

#---------------------------------------------------------------
# git branch
#---------------------------------------------------------------
def SetupStlGitBranchColor(): void
  NewColor('IvimStlGitBranch', 'IvimStlB', 'Blue')
enddef
def g:IvimStlGitBranch(): string
  var br = g:FugitiveHead()
  return printf('%s', len(br) == 0 ? '' : '%#IvimStlGitBranch# ' ..
    br .. '%#IvimStlB#')
enddef

#---------------------------------------------------------------
# lsp diag
#---------------------------------------------------------------
def SetupStlLspDiagColor(): void
  NewColor('IvimStlLspDiagError', 'IvimStlB', 'Red')
  NewColor('IvimStlLspDiagWarn', 'IvimStlB', 'Yellow')
enddef
def g:IvimStlLspDiag(): string
  var error = youcompleteme#GetErrorCount()
  var warn = youcompleteme#GetWarningCount()
  return printf('%s%s%s',
    (error == 0 ? '' :
      '%#IvimStlLspDiagError# ' .. string(error) .. '%#IvimStlB#'),
    (error > 0 && warn > 0 ? ' ' : ''),
    (warn == 0 ? '' :
      '%#IvimStlLspDiagWarn# ' .. string(warn) .. '%#IvimStlB#')
  )
enddef
# }}}

# {{{ keymap
var AddGroup: func = ikeymap.AddGroup
var AddDesc: func = ikeymap.AddDesc

nmap H <Plug>lightline#bufferline#go_previous()
nmap L <Plug>lightline#bufferline#go_next()
nmap [b <Plug>lightline#bufferline#go_previous()
nmap ]b <Plug>lightline#bufferline#go_next()

AddGroup('<leader>b', 'buffer')

nmap <leader>bH <Plug>lightline#bufferline#move_first()
AddDesc('<leader>bH', 'Reorder to First')
nmap <leader>bL <Plug>lightline#bufferline#move_last()
AddDesc('<leader>bL', 'Reorder to Last')

nmap <leader>bh <Plug>lightline#bufferline#move_previous()
AddDesc('<leader>bh', 'Reorder to Prev')
nmap <leader>bl <Plug>lightline#bufferline#move_next()
AddDesc('<leader>bl', 'Reorder to Next')

nmap <leader>br <Plug>lightline#bufferline#reset_order()
AddDesc('<leader>br', 'Reorder')
# }}}

augroup ivim_lightline
  au!
  # wait for colorscheme loaded
  au VimEnter * SetupStlColor()
  au CursorHold * lightline#update()
  au User GitGutter lightline#update()

  # update bufferline when buffer list change, or a deleted buffer may remain
  # in bufferline
  if has('timers')
    def ReloadBufline(timer: any)
      lightline#bufferline#reload()
    enddef
    au BufDelete * if timer_start(200, function('ReloadBufline')) == -1
      | iui.Error('cannot refresh bufferline') | endif
  endif
augroup END
