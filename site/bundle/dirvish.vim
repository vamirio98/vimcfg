let g:ivim_dirvish_hide_dotfile = get(g:, 'ivim_dirvish_hide_dotfile', 1)

" sort and hide files, then locate related file
function! s:SetupDirvish()
  " NOTE: because vim only remember location of a buffer when leave it,
  " if the buffer content changed, the cursor will stay in another file
  " when reenter the same buffer. e.g., toggle hide dot-file or files in
  " a directory have changed
  let b:cur_file = get(b:, 'cur_file', getline('.'))
  if g:ivim_dirvish_hide_dotfile
    exec 'silent! keeppatterns g@\v[\/]\.[^\/]+[\/]?$@d _'
    " add current file again if it's dotfile
    if match(b:cur_file, '\v[\/]\.[^\/]+[\/]?$') >= 0
      call setline(line('$') + 1, b:cur_file)
    endif
  endif
  " sort filename
  exec 'sort ,^.*[\/],'
  let cur_file = escape(b:cur_file, '.*[]~\')
  "" locate to current file
  call search(cur_file, 'wc')

  nnoremap <silent><buffer> gh <Cmd>call <SID>ToggleHideDotfile()<CR>
endfunc

function! s:ToggleHideDotfile()
  let g:ivim_dirvish_hide_dotfile = !g:ivim_dirvish_hide_dotfile
  exec 'Dirvish'
endfunc

augroup ivim_dirvish
  au!
  au FileType dirvish call s:SetupDirvish()
  au BufLeave * if &ft == 'dirvish' && exists('b:cur_file') |
        \ unlet b:cur_file | endif
augroup END
