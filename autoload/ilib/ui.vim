" set to 1 after vim finish initializing
let g:ilib#ui#init = get(g:, 'ivim_loaded', 0)
let s:msg_queue = []

function! ilib#ui#echo(what)
	let l:what = type(a:what) == v:t_list ? join(a:what, '\n') : a:what
	redraw
	echo l:what
endfunc

function! ilib#ui#echom(what)
	let l:what = type(a:what) == v:t_list ? join(a:what, '\n') : a:what
	redraw
	echom l:what
endfunc

function! ilib#ui#show(what, ...)
	let l:what = type(a:what) == v:t_list ? join(a:what, '\n') : a:what
  let l:color = get(a:000, 0, 'Normal')
  if !g:ilib#ui#init
    let s:msg_queue += [function('ilib#ui#show', [l:what, l:color])]
    return
  endif

	redraw
	exec 'echohl ' . l:color
	echom l:what
	echohl None
endfunc

function! ilib#ui#error(what, ...)
	let l:title = a:0 > 0 ? a:1 : ''
	if l:title != ''
		call ilib#ui#show(l:title, 'Title')
	endif
	call ilib#ui#show(a:what, 'ErrorMsg')
endfunc

function! ilib#ui#warn(what)
	let l:title = a:0 > 0 ? a:1 : ''
	if l:title != ''
		call ilib#ui#show(l:title, 'Title')
	endif
	call ilib#ui#show(a:what, 'WarningMsg')
endfunc

function! ilib#ui#info(what)
	let l:title = a:0 > 0 ? a:1 : ''
	if l:title != ''
		call ilib#ui#show(l:title, 'Title')
	endif
	call ilib#ui#show(a:what, 'Normal')
endfunc

augroup ivim_module_ui
  au!
  au VimEnter * let g:ilib#ui#init = 1 | for Msg in s:msg_queue |
        \ call Msg() | endfor | let s:msg_queue = []
augroup END
