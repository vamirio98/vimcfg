" Terminal style
let g:floaterm_position = 'bottomright'

" Close window if the job exits normally
let g:floaterm_autoclose = 1
" Kill all floaterm instance when quit vim.
augroup ivim_floaterm
  au!
  au QuitPre * exec 'FloatermKill!'
augroup END

" Open or hide the floaterm window.
let g:floaterm_keymap_toggle = '<M-=>'
" Open a new floaterm window.
let g:floaterm_keymap_new = '<M-+>'
" Switch to the previous floaterm instance.
let g:floaterm_keymap_prev = '<M-,>'
" Switch to the next floaterm instance
let g:floaterm_keymap_next = '<M-.>'
" Close the current terminal instance.
let g:floaterm_keymap_kill = '<M-->'
