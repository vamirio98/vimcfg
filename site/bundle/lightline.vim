" {{{ setting
set noshowmode
set laststatus=2
set hidden " allow buffer switching without saving
set showtabline=2

let g:lightline#bufferline#filter_by_tabpage = 1
let g:lightline#bufferline#enable_devicons = 1

function LightlineBufferlineFilter(buffer)
  return getbufvar(a:buffer, '&buftype') !=# 'terminal'
endfunction

if !exists('g:lightline')
  let g:lightline = {}
endif

let g:lightline.subseparator = {'left': '|', 'right': '|'}
let g:lightline.tabline_subseparator = g:lightline.subseparator

let g:lightline#bufferline#buffer_filter = "LightlineBufferlineFilter"

let g:lightline.colorscheme = 'gruvbox_material'

let g:lightline.active = {
      \ 'left': [ ['mode', 'paste'],
      \   ['gitbranch', 'lspdiag', 'filename', 'modified'],
      \ ],
      \ 'right': [ ['lineinfo'], ['percent'],
      \   ['gitsummary', 'fileformat', 'filetype'],
      \ ]
      \}
let g:lightline.tabline = {
      \ 'left': [ ['buffers'] ],
      \ 'right': [ ['tabs'] ],
      \}

let g:lightline.component_function = {
      \}
let g:lightline.component_expand = {
      \ 'buffers': 'lightline#bufferline#buffers',
      \ 'gitsummary': 'IvimStlGitSummary',
      \ 'lspdiag': 'IvimStlLspDiag',
      \ 'gitbranch': 'IvimStlGitBranch',
      \}
let g:lightline.component_type = {
      \ 'buffers': 'tabsel',
      \}
" }}}

" {{{ component utils
augroup ivim_lighline_stl_color
  au!
  " wait for colorscheme loaded
  au VimEnter * call s:SetupStlColor()
  au CursorHold * call lightline#update()
  au User GitGutter call lightline#update()
augroup END
function! s:SetupStlColor()
  hi! link IvimStlA LightlineLeft_normal_0
  hi! link IvimStlB LightlineLeft_normal_1
  hi! link IvimStlC LightlineRight_normal_2
  hi! link IvimStlX LightlineRight_normal_2
  hi! link IvimStlY LightlineRight_normal_1
  hi! link IvimStlZ LightlineRight_normal_0

  call s:SetupStlGitSumColor()
  call s:SetupStlLspDiagColor()
  call s:SetupStlGitBranchColor()
endfunc

function! s:NewColor(name, bg, fg)
  let bg = hlget(a:bg, 1)[0]
  let fg = hlget(a:fg, 1)[0]
  exec printf('hi! %s ctermbg=%s ctermfg=%s guibg=%s guifg=%s',
        \ a:name, bg.ctermbg, fg.ctermfg, bg.guibg, fg.guifg)
endfunc

"---------------------------------------------------------------
" git summary
"---------------------------------------------------------------
function! s:SetupStlGitSumColor()
  call s:NewColor('IvimStlGitSumAdd', 'IvimStlX', 'GitGutterAdd')
  call s:NewColor('IvimStlGitSumChange', 'IvimStlX', 'GitGutterChange')
  call s:NewColor('IvimStlGitSumDelete', 'IvimStlX', 'GitGutterDelete')
endfunc
function! IvimStlGitSummary()
  let [a, m, r] = GitGutterGetHunkSummary()
  return printf('%s%s%s%s%s',
        \ (a == 0 ? '' : '%#IvimStlGitSumAdd#+'.string(a).'%*'),
        \ (m + r > 0 ? ' ' : ''),
        \ (m == 0 ? '' : '%#IvimStlGitSumChange#~'.string(m).'%*'),
        \ (m > 0 && r > 0 ? ' ' : ''),
        \ (r == 0 ? '' : '%#IvimStlGitSumDelete#-'.string(r).'%*')
        \)
endfunc

"---------------------------------------------------------------
" git branch
"---------------------------------------------------------------
function! s:SetupStlGitBranchColor()
  call s:NewColor('IvimStlGitBranch', 'IvimStlB', 'Blue')
endfunc
function! IvimStlGitBranch()
  let br = FugitiveHead()
  return printf('%s', len(br) == 0 ? '' : '%#IvimStlGitBranch# '.br.'%#IvimStlB#')
endfunc

"---------------------------------------------------------------
" lsp diag
"---------------------------------------------------------------
function! s:SetupStlLspDiagColor()
  call s:NewColor('IvimStlLspDiagError', 'IvimStlB', 'Red')
  call s:NewColor('IvimStlLspDiagWarn', 'IvimStlB', 'Yellow')
endfunc
function! IvimStlLspDiag()
  let error = youcompleteme#GetErrorCount()
  let warn = youcompleteme#GetWarningCount()
  return printf('%s%s%s',
        \ (error == 0 ? '' : '%#IvimStlLspDiagError# '.string(error).'%#IvimStlB#'),
        \ (error > 0 && warn > 0 ? ' ' : ''),
        \ (warn == 0 ? '' : '%#IvimStlLspDiagWarn# '.string(warn).'%#IvimStlB#')
        \)
endfunc
" }}}

" {{{ keymap
let s:Desc = function('imodule#keymap#add_desc')

nmap H <Plug>lightline#bufferline#go_previous()
nmap L <Plug>lightline#bufferline#go_next()
nmap [b <Plug>lightline#bufferline#go_previous()
nmap ]b <Plug>lightline#bufferline#go_next()

call imodule#keymap#add_group('<leader>b', 'buffer')

nmap <leader>bH <Plug>lightline#bufferline#move_first()
call s:Desc('<leader>bH', 'Reorder to First')
nmap <leader>bL <Plug>lightline#bufferline#move_last()
call s:Desc('<leader>bL', 'Reorder to Last')

nmap <leader>bh <Plug>lightline#bufferline#move_previous()
call s:Desc('<leader>bh', 'Reorder to Prev')
nmap <leader>bl <Plug>lightline#bufferline#move_next()
call s:Desc('<leader>bl', 'Reorder to Next')

nmap <leader>br <Plug>lightline#bufferline#reset_order()
call s:Desc('<leader>br', 'Reorder')
" }}}

augroup ivim_lightline
  au!
  " update bufferline when buffer list change, or a deleted buffer may remain
  " in bufferline
  if has('timers')
    func! s:ReloadBufline(timer)
      call lightline#bufferline#reload()
    endfunc
    au BufDelete * if timer_start(200, function('s:ReloadBufline')) == -1 |
          \ call ilib#ui#error('cannot refresh bufferline') | endif
  endif
augroup END
