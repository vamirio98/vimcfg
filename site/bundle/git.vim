let g:gitgutter_map_keys = 0

let g:gitgutter_sign_priority = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = ''

let g:gitgutter_close_preview_on_escape = 0

let g:gitgutter_grep = 'rg --color=never'

" map {{{
call imodule#keymap#add_group('<leader>g', 'git')
let s:Desc = function('imodule#keymap#add_desc')

nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)
call s:Desc('[h', 'Prev Hunk')
call s:Desc(']h', 'Next Hunk')

command! IvimGitHunk  GitGutterQuickFix | LeaderfQuickFix
nnoremap <leader>gs <Cmd>IvimGitHunk<CR>
call s:Desc('<leader>gs', 'Search Hunk')
nmap <leader>gp <Plug>(GitGutterPrevHunk)
call s:Desc('<leader>gp', 'Preview Hunk')

omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)
call s:Desc('ih', 'Inner Hunk', 'v')
call s:Desc('ah', 'Outer Hunk', 'v')
" }}}

" TODO: add map to change diff base
" let g:gitgutter_diff_base = 'xxx'
