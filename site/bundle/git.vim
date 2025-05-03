vim9script

import autoload "../../autoload/imodule/keymap.vim" as ikeymap

g:gitgutter_map_keys = 0

g:gitgutter_sign_priority = 1
g:gitgutter_sign_added = '▎'
g:gitgutter_sign_modified = '▎'
g:gitgutter_sign_removed = ''

g:gitgutter_close_preview_on_escape = 0

g:gitgutter_grep = 'rg --color=never'

# map {{{
var AddGroup: func = ikeymap.AddGroup
var AddDesc: func = ikeymap.AddDesc

AddGroup('<leader>g', 'git')

nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)
AddDesc('[h', 'Prev Hunk')
AddDesc(']h', 'Next Hunk')

command! IvimGitHunk  GitGutterQuickFix | LeaderfQuickFix
nnoremap <leader>gs <Cmd>IvimGitHunk<CR>
AddDesc('<leader>gs', 'Search Hunk')
nmap <leader>gp <Plug>(GitGutterPrevHunk)
AddDesc('<leader>gp', 'Preview Hunk')

omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)
AddDesc('ih', 'Inner Hunk', 'v')
AddDesc('ah', 'Outer Hunk', 'v')
# }}}

# TODO: add map to change diff base
# let g:gitgutter_diff_base = 'xxx'
