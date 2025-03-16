let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''

let g:Lf_WildIgnore = {
        \ 'dir': g:ivim_rootmarkers,
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
        \}

let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_RootMarkers = g:ivim_rootmarkers
let g:Lf_CommandMap = {}
let g:Lf_NormalCommandMap = { '*': { '<F1>': '?' } }
let g:Lf_HideHelp = 1
let g:Lf_RecurseSubmodules = 1 " only work with git 2.11+
let g:Lf_ReverseOrder = 0
let g:Lf_HistoryExclude = {
        \ 'cmd': ['^w!?', '^q!?', '^.\s*$'],
        \ 'search': ['^Plug']
        \}
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_ShowHidden = 1

" {{{ hide help file in MRU
let g:Lf_MruFileExclude = get(g:, 'Lf_MruFileExclude', [])
for plug in values(g:plugs)
  let plug_dir = plug.dir
  let doc = ilib#path#join(plug_dir, 'doc', '*')
  let g:Lf_MruFileExclude += [doc]
endfor
" }}}

" vim-gutentags integration {{{
if imodule#plug#has('vim-gutentags')
  let g:Lf_GtagsGutentags = 1
  let g:Lf_CacheDirectory = g:ivim_cache_dir
  let s:tag_cache_dir = expand(g:Lf_CacheDirectory . '/LeaderF/gtags')
  if !isdirectory(s:tag_cache_dir)
    silent! call mkdir(s:tag_cache_dir, 'p')
  endif
  " set dir to save the tag file
  let g:gutentags_cache_dir = s:tag_cache_dir
endif
" }}}

" {{{ keymap
let s:Desc = function('imodule#keymap#add_desc')

" {{{ file
function! s:SearchFileInProject()
  let root = ilib#project#get_root('.')
  exec 'LeaderfFile ' . root
endfunc

call imodule#keymap#add_group('<leader>f', 'file')

nnoremap <leader>ff <Cmd>call <SID>SearchFileInProject()<CR>
call s:Desc('<leader>ff', 'Search File (Project Root)')
nnoremap <leader>fF <Cmd>LeaderfFile .<CR>
call s:Desc('<leader>fF', 'Search File (Cwd)')

nnoremap <leader>fr <Cmd>LeaderfMru<CR>
call s:Desc('<leader>fr', 'Recent File')
nnoremap <leader>fR <Cmd>LeaderfMruCwd<CR>
call s:Desc('<leader>fR', 'Recent File (Cwd)')
" }}}

" gtags {{{
call imodule#keymap#add_group('<leader>g', 'gtags')
nmap <leader>gd <Plug>LeaderfGtagsDefinition
call s:Desc('<leader>gd', 'Gtags Definition')
nmap <leader>gg <Plug>LeaderfGtagsGrep
call s:Desc('<leader>gg', 'Gtags Word')
nmap <leader>gr <Plug>LeaderfGtagsReference
call s:Desc('<leader>gr', 'Gtags Reference')
nmap <leader>gS <Plug>LeaderfGtagsSymbol
call s:Desc('<leader>gS', 'Gtags Symbol')
" }}}

" {{{ search
call imodule#keymap#add_group('<leader>s', 'search')

nnoremap <leader>sb <Cmd>LeaderfBuffer<CR>
call s:Desc('<leader>sb', 'Buffer')

nnoremap <leader>sc <Cmd>LeaderfHistoryCmd<CR>
call s:Desc('<leader>sc', 'Command History')

nnoremap <leader>sh <Cmd>LeaderfHelp<CR>
call s:Desc('<leader>sh', 'Help Tag')

nnoremap <leader>sk <Cmd>LeaderfMap<CR>
call s:Desc('<leader>sk', 'Keymap')

nnoremap <leader>sl <Cmd>LeaderfLocList<CR>
call s:Desc('<leader>sl', 'Location List')
nnoremap <leader>sL <Cmd>LeaderfSelf<CR>
call s:Desc('<leader>sL', 'Leaderf Command')

nnoremap <leader>sm <Cmd>LeaderfMark<CR>
call s:Desc('<leader>sm', 'Mark')

nnoremap <leader>sq <Cmd>LeaderfQuickFix<CR>
call s:Desc('<leader>sq', 'Quickfix')

nnoremap <leader>sf <Cmd>LeaderfFunction<CR>
call s:Desc('<leader>sf', 'Function (Current File)')

nnoremap <leader>st <Cmd>LeaderfBufTag<CR>
call s:Desc('<leader>st', 'Tag (Current File)')
nnoremap <leader>sT <Cmd>LeaderfTag<CR>
call s:Desc('<leader>sT', 'Tag (Workspace)')

nnoremap <leader>s: <Cmd>LeaderfCommand<CR>
call s:Desc('<leader>s:', 'Command')
nnoremap <leader>s/ <Cmd>LeaderfHistorySearch<CR>
call s:Desc('<leader>s/', 'Search History')
nnoremap <leader>/ <Cmd>Leaderf rg<CR>
call s:Desc('<leader>/', 'Live Search')
" }}}

" }}}
