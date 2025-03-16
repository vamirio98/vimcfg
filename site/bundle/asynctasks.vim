let g:asynctasks_extra_config = get(g:, 'asynctasks_extra_config', [])
let g:asynctasks_extra_config += [
      \ ilib#path#abspath(ilib#path#join(g:ivim_home,
      \   'site/third_party/asynctasks/tasks.ini'))
      \]

let g:asyncrun_open = 6
let g:asyncrun_rootmarks = g:ivim_rootmarkers

let g:asyncrun_shell = ilib#platform#is_win() ? 'bash' : 'pwsh'

let g:asynctasks_rtp_config = "asynctasks.ini"

" python will buffer everything written to stdout when running as a backgroup
" process, this can see the realtime output without calling `flush()`
let $PYTHONUNBUFFERED = 1

" {{{ LeaderF integration
" https://github.com/skywind3000/asynctasks.vim/wiki/UI-Integration
if imodule#plug#has('LeaderF')
  nnoremap <leader>pt <Cmd>Leaderf --nowrap task<CR>
  call imodule#keymap#add_group('<leader>p', 'project')
  call imodule#keymap#add_desc('<leader>pt', 'Query Tasks')

  function! s:lf_task_source(...)
    let rows = asynctasks#source(&columns * 48 / 100)
    let source = []
    for row in rows
      let name = row[0]
      let source += [name . '  ' . row[1] . '  : ' . row[2]]
    endfor
    return source
  endfunction


  function! s:lf_task_accept(line, arg)
    let pos = stridx(a:line, '<')
    if pos < 0
      return
    endif
    let name = strpart(a:line, 0, pos)
    let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
    if name != ''
      exec "AsyncTask " . name
    endif
  endfunction

  function! s:lf_task_digest(line, mode)
    let pos = stridx(a:line, '<')
    if pos < 0
      return [a:line, 0]
    endif
    let name = strpart(a:line, 0, pos)
    return [name, 0]
  endfunction

  function! s:lf_win_init(...)
    setlocal nonumber
    setlocal nowrap
  endfunction


  let g:Lf_Extensions = get(g:, 'Lf_Extensions', {})
  let g:Lf_Extensions.task = {
        \ 'source': string(function('s:lf_task_source'))[10:-3],
        \ 'accept': string(function('s:lf_task_accept'))[10:-3],
        \ 'get_digest': string(function('s:lf_task_digest'))[10:-3],
        \ 'highlights_def': {
        \     'Lf_hl_funcScope': '^\S\+',
        \     'Lf_hl_funcDirname': '^\S\+\s*\zs<.*>\ze\s*:',
        \ },
        \ 'help' : 'navigate available tasks from asynctasks.vim',
      \ }
endif
" }}}
