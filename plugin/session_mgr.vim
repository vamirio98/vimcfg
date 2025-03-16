if exists('g:loaded_session_mgr')
  finish
endif
let g:loaded_session_mgr = 1

set sessionoptions=blank,buffers,curdir,folds,help,winpos

let g:ivim_cache_dir = get(g:, 'ivim_cache_dir', resolve(expand('~/.cache/vim')))
let g:ivim_session_dir = get(g:, 'ivim_session_dir',
      \ ilib#path#join(g:ivim_cache_dir, 'session'))
" auto update session when leave vim
let g:ivim_auto_update_session = get(g:, 'ivim_auto_update_session', 1)

let s:session_dir = resolve(expand(g:ivim_session_dir))
let s:auto_update_session = g:ivim_auto_update_session

func! SessionList(arglead, ...) abort
  if !isdirectory(s:session_dir)
    return []
  endif

  let files = map(split(globpath(s:session_dir, a:arglead.'*'), '\n'),
        \ 'fnamemodify(v:val, ":t")')
  return files
endfunc

func! s:WriteSessionFile(name) abort
  let name = fnamemodify(a:name, ':t')
  exec 'silent mksession!' ilib#path#join(s:session_dir, a:name)
endfunc

" SessionSave({bang} [, {name}, {silent}])
func! SessionSave(bang, ...) abort
  " ensure session directory exists
  if !isdirectory(s:session_dir)
    let choice = ilib#core#confirm(s:session_dir.' is not exists, create it?',
          \ "&Yes\n&No", 1)
    if choice == 1
      silent call mkdir(s:session_dir, 'p')
    else
      call ilib#ui#error('The session directory does not exist: '.s:session_dir)
      return
    endif
  endif

  let name = a:0 > 0 ? a:1 : ilib#core#input('Session name: ',
        \ fnamemodify(ilib#project#current_root(), ':t'),
        \ 'customlist,SessionList')
  if empty(name)
    call ilib#ui#error('Need session name')
    return
  endif
  let silent = get(a:000, 1, 0)

  let name = fnamemodify(name, ':t')
  let file = ilib#path#join(s:session_dir, name)

  if filereadable(file) && !a:bang
    let choice = ilib#core#confirm(name.' is already exist, overwrite?',
          \ "&Yes\n&No", 2)
    if choice != 1
      return
    endif
  endif

  call s:WriteSessionFile(name)

  if !silent
    call ilib#ui#info('Saved session ['.name.']')
  endif
endfunc

" TODO: support load_last_session
" SessionLoad({load_last_session} [, {name}, {silent}])
func! SessionLoad(load_last_session, ...) abort
  if !isdirectory(s:session_dir)
    call ilib#ui#error('The session direcotry does not exist: '.s:session_dir)
    return
  endif

  let name = a:0 > 0 ? a:1 : ilib#core#input('Session name: ', '',
        \ 'customlist,SessionList')
  if empty(name)
    call ilib#ui#error('Need session name')
    return
  endif
  let silent = get(a:000, 1, 0)

  let name = fnamemodify(name, ':t')
  let file = ilib#path#join(s:session_dir, name)
  if !filereadable(file)
    call ilib#ui#error('The session file does not exist: '.file)
    return
  endif

  " remove all buffers first
  bufdo bd
  exec 'source' file
  if !silent
    call ilib#ui#info('Loaded session ['.name.']')
  endif
endfunc

" SessionDelete({bang} [, {name}, {silent}])
func! SessionDelete(bang, ...) abort
  if !isdirectory(s:session_dir)
    call ilib#ui#error('The session direcotry does not exist: '.s:session_dir)
    return
  endif

  let name = a:0 > 0 ? a:1 : ilib#core#input('Session name: ', '',
        \ 'customlist,SessionList')
  if empty(name)
    call ilib#ui#error('Need session name')
    return
  endif
  let silent = get(a:000, 1, 0)

  let name = fnamemodify(name, ':t')
  let file = ilib#path#join(s:session_dir, name)
  if !filereadable(file)
    call ilib#ui#error('No such file: '.file)
    return
  endif
  if !a:bang
    let choice = ilib#core#confirm('Delete session '.name.'?', "&Yes\n&No", 2)
    if choice != 1
      return
    endif
  endif
  call delete(file)
  if !silent
    call ilib#ui#warn('Delete session ['.name.']')
  endif
endfunc

func! SessionClose() abort
  if exists('v:this_session') && filereadable(v:this_session)
    call s:WriteSessionFile(fnameescape(v:this_session))
    let v:this_session = ''
  endif
  bufdo bd
endfunc

command! -nargs=? -bar -bang -complete=customlist,SessionList
      \ IvimSessionSave call SessionSave(<bang>0, <f-args>)
command! -nargs=? -bar -bang -complete=customlist,SessionList
      \ IvimSessionLoad call SessionLoad(<bang>0, <f-args>)
command! -nargs=? -bar -bang -complete=customlist,SessionList
      \ IvimSessionDelete call SessionDelete(<bang>0, <f-args>)
command! -nargs=0 -bar IvimSessionClose call SessionClose()

augroup ivim_plugin_session_mgr
  au!
  au VimLeavePre * if g:ivim_auto_update_session &&
        \ exists('v:this_session') && filewritable(v:this_session) |
        \ call s:WriteSessionFile(fnameescape(v:this_session)) | endif
augroup END

" {{{ leaderf integration
if imodule#plug#has('LeaderF')
  nnoremap <leader>sp <Cmd>Leaderf project<CR>
  call imodule#keymap#add_desc('<leader>sp', 'Project')

  func! s:LfProjectSource(...) abort
    return SessionList('')
  endfunc

  func! s:LfPorjectAccept(line, arg)
    if !empty(a:line)
      call SessionLoad(0, a:line)
    endif
  endfunc

  let g:Lf_Extensions = get(g:, 'Lf_Extensions', {})
  let g:Lf_Extensions.project = {
        \ 'source': string(function('s:LfProjectSource'))[10:-3],
        \ 'accept': string(function('s:LfPorjectAccept'))[10:-3],
        \ 'help': 'navigate available project from session_mgr.vim',
        \ }
endif

" }}}
