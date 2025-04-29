vim9script

import autoload "../../autoload/ilib/string.vim" as istring

g:indent_guides_default_mapping = 0
g:indent_guides_guide_size = 0
g:indent_guides_start_level = 1
g:indent_guides_enable_on_vim_startup = 0
g:indent_guides_exclude_buftype = 0
g:indent_guides_exclude_filetypes = ['help', 'startify', 'nerdtree']
g:indent_guides_tab_guides = 0

# {{{ keymap
def StripListchars(listchars: string): string
  var lc = listchars
  if istring.Contains(lc, 'tab:')
    lc = substitute(lc, '\vtab:.{-},', 'tab:\\ \\ ,', '')
  endif
  if istring.Contains(lc, 'lead:')
    lc = substitute(lc, 'lead:.{-},', 'lead:\\ ,', '')
  endif
  return lc
enddef
def IvimIndentGuidesEnable(): void
  exec 'IndentGuidesEnable'
  exec 'setlocal listchars=' .. StripListchars(g:ivim_listchars)
enddef
def IvimIndentGuidesDisable(): void
  exec 'IndentGuidesDisable'
  exec 'setlocal listchars=' .. g:ivim_listchars
enddef
def ToggleIndentGuides(): void
  b:ivim_indent_guide_enabled = !get(b:, 'ivim_indent_guide_enabled', 0)
  if b:ivim_indent_guide_enabled
    IvimIndentGuidesEnable()
  else
    IvimIndentGuidesDisable()
  endif
enddef

imodule#keymap#add_group('<leader>u', 'ui')
imodule#keymap#add_desc('<leader>ui', 'Toggle Indent Guides')
nnoremap <leader>ui <ScriptCmd>call ToggleIndentGuides()<CR>
# }}}

if !has('gui_running')
  g:indent_guides_auto_colors = 0
  augroup ivim_indent_guides
    au!
    au VimEnter,Colorscheme * :hi link IndentGuidesOdd DiffAdd
    au VimEnter,Colorscheme * :hi link IndentGuidesEven ToolbarLine
    au BufReadPost,BufNewFile * if &expandtab
      | IvimIndentGuidesEnable() | endif
  augroup END
endif
