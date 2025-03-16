let s:Desc = function('imodule#keymap#add_desc')
call imodule#keymap#add_group('<leader>d', 'debug')

nmap <silent> <leader>db <Plug>VimspectorToggleBreakpoint
call s:Desc('<leader>db', 'Toggle Breakpoint')
nmap <silent> <leader>dB <Plug>VimspectorToggleConditionalBreakpoint
call s:Desc('<leader>dB', 'Toggle Cond Breakpoint')

nmap <silent> <leader>dc <Plug>VimspectorContinue
call s:Desc('<leader>dc', 'Start/Continue')

nmap <silent> <leader>df <Plug>VimspectorAddFunctionBreakpoint
call s:Desc('<leader>df', 'Toggle Func Breakpoint')

nmap <silent> <leader>dp <Plug>VimspectorPause
call s:Desc('<leader>dp', 'Pause Debug')

nmap <silent> <leader>dr <Plug>VimspectorRestart
call s:Desc('<leader>dr', 'Restart')

nmap <silent> <leader>ds <Plug>VimspectorStop
call s:Desc('<leader>ds', 'Stop')

augroup ivim_vimspector
  au!
  au User VimSpectorUICreated call s:CustomizeWinBar()
  au User VimSpectorJumpedToFrame call s:OnJumpToFrame()
  au User VimSpectorDebugEnded ++nested call s:OnDebugEnd()
augroup END

" customize UI {{{
func! s:CustomizeWinBar() abort
  call win_gotoid(g:vimspector_session_windows.code)
  " clear the existing WinBar create by vimspector
  aunmenu WinBar

  " create new WinBar
  nnoremenu WinBar.▷ <Cmd>call vimspector#Continue()<CR>
  nnoremenu WinBar.↷ <Cmd> vimspector#StepOver()<CR>
  nnoremenu WinBar.↓ <Cmd> vimspector#StepInto()<CR>
  nnoremenu WinBar.↑ <Cmd> vimspector#StepOut()<CR>
  nnoremenu WinBar.● <Cmd> vimspector#ToggleBreakpoint()<CR>
  nnoremenu WinBar.‖ <Cmd> vimspector#Pause()<CR>
  nnoremenu WinBar.□ <Cmd> vimspector#Stop()<CR>
  nnoremenu WinBar.⟲ <Cmd> vimspector#Restart()<CR>
  nnoremenu WinBar.✕ <Cmd> vimspector#Reset()<CR>
endfunc
" }}}

" custom mappings while debuggins {{{
let s:buffers = {}
const s:MAPS = {
      \ '<F5>': '<Plug>VimSpectorContinue',
      \ '<F3>': '<Plug>VimspectorStop',
      \ '<localleader>b': '<Plug>VimspectorToggleBreakpoint',
      \ '<localleader>B': '<Plug>VimspectorBreakpoints',
      \ '<localleader>d': '<Plug>VimspectorDisassemble',
      \ '<localleader>i': '<Plug>VimspectorBalloonEval',
      \ '<localleader>J': '<Plug>VimspectorDownFrame',
      \ '<localleader>K': '<Plug>VimspectorUpFrame',
      \ '<localleader>j': '<Plug>VimspectorJumpToNextBreakpoint',
      \ '<localleader>k': '<Plug>VimspectorJumpToPreviousBreakpoint',
      \ '<localleader>p': '<Plug>VimspectorJumpToProgramCounter',
      \ '<localleader>r': '<Plug>VimspectorRunToCursor',
      \ '<localleader>R': '<Plug>VimspectorGoToCurrentLine',
      \ '<F10>': '<Plug>VimspectorStepOver',
      \ '<F11>': '<Plug>VimspectorStepInto',
      \ '<F12>': '<Plug>VimspectorStepOut',
      \ }

func! s:OnJumpToFrame() abort
  if has_key(s:buffers, string(bufnr()))
    return
  endif

  for [k, v] in items(s:MAPS)
    exec 'nmap <silent><buffer>' k v
  endfor

  let s:buffers[string(bufnr())] = {'modifiable': &modifiable}
  setlocal nomodifiable
endfunc

func! s:OnDebugEnd() abort
  let orig_buf = bufnr()
  let hidden = &hidden

  augroup ivim_vimspector_swap_exists
    au!
    au SwapExists * v:swapchoice = 'o'
  augroup END

  try
    set hidden
    for bufnr in keys(s:buffers)
      try
        exec 'buffer' bufnr
        for k in keys(s:MAPS)
          exec 'silent! nunmap <buffer>' k
        endfor
        let &modifiable = s:buffers[bufnr]['modifiable']
      finally
      endtry
    endfor
  finally
    exec 'noautocmd buffer' orig_buf
    let &hidden = hidden
  endtry

  au! ivim_vimspector_swap_exists
  let s:buffers = {}
endfunc
" }}}
