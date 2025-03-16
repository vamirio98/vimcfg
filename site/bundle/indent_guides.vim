let g:indent_guides_default_mapping = 0
let g:indent_guides_guide_size = 0
let g:indent_guides_start_level = 1
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_exclude_buftype = 0
let g:indent_guides_exclude_filetypes = ['help', 'startify', 'nerdtree']
let g:indent_guides_tab_guides = 0

if !has('gui_running')
  let g:indent_guides_auto_colors = 0
  augroup ivim_indent_guides
    au!
    au VimEnter,Colorscheme * :hi link IndentGuidesOdd DiffAdd
    au VimEnter,Colorscheme * :hi link IndentGuidesEven ToolbarLine
    au BufReadPost,BufNewFile * if &expandtab |
          \ call IvimIndentGuidesEnable() | endif
  augroup END
endif

" {{{ keymap
function! s:StripListchars(listchars)
  let listchars = a:listchars
  if ilib#string#contains(listchars, 'tab:')
    let listchars = substitute(listchars, '\vtab:.{-},', 'tab:\\ \\ ,', '')
  endif
  if ilib#string#contains(listchars, 'lead:')
    let listchars = substitute(listchars, 'lead:.{-},', 'lead:\\ ,', '')
  endif
  return listchars
endfunc
function! IvimIndentGuidesEnable() abort
  exec 'IndentGuidesEnable'
  exec 'setlocal listchars=' . s:StripListchars(g:ivim_listchars)
endfunc
function! IvimIndentGuidesDisable() abort
  exec 'IndentGuidesDisable'
  exec 'setlocal listchars=' . g:ivim_listchars
endfunc
function! s:ToggleIndentGuides() abort
  let b:ivim_indent_guide_enabled = !get(b:, 'ivim_indent_guide_enabled', 0)
  if b:ivim_indent_guide_enabled
    call IvimIndentGuidesEnable()
  else
    call IvimIndentGuidesDisable()
  endif
endfunc

call imodule#keymap#add_group('<leader>u', 'ui')
call imodule#keymap#add_desc('<leader>ui', 'Toggle Indent Guides')
nnoremap <leader>ui <Cmd>call <SID>ToggleIndentGuides()<CR>
" }}}
