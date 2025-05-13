vim9script

import autoload "../../autoload/ilib/string.vim" as istring
import autoload "../../autoload/imodule/keymap.vim" as ikeymap

g:indent_guides_default_mapping = 0
g:indent_guides_guide_size = 0
g:indent_guides_start_level = 1
g:indent_guides_enable_on_vim_startup = 0
g:indent_guides_exclude_buftype = 0
g:indent_guides_exclude_filetypes = ['help', 'startify', 'nerdtree']
g:indent_guides_tab_guides = 1

# {{{ keymap
def StripListchars(listchars: string): string
  var lc: string = listchars
  if istring.Contains(lc, 'tab:')
    lc = substitute(lc, '\vtab:.{-},', 'tab:\\ \\ ,', '')
  endif
  if istring.Contains(lc, 'lead:')
    lc = substitute(lc, 'lead:.{-},', 'lead:\\ ,', '')
  endif
  return lc
enddef
def g:IvimIndentGuidesEnable(): void
  exec 'IndentGuidesEnable'
  exec 'setlocal listchars=' .. StripListchars(g:ivim_listchars)
enddef
def g:IvimIndentGuidesDisable(): void
  exec 'IndentGuidesDisable'
  exec 'setlocal listchars=' .. g:ivim_listchars
enddef
def g:ToggleIndentGuides(): void
  b:ivim_indent_guide_enabled = !get(b:, 'ivim_indent_guide_enabled', 0)
  if b:ivim_indent_guide_enabled
    g:IvimIndentGuidesEnable()
  else
    g:IvimIndentGuidesDisable()
  endif
enddef

ikeymap.SetGroup('<leader>u', 'ui')
ikeymap.SetDesc('<leader>ui', 'Toggle Indent Guides')
nnoremap <leader>ui <Cmd>call g:ToggleIndentGuides()<CR>
# }}}

if !has('gui_running')
  g:indent_guides_auto_colors = 0
  augroup ivim_indent_guides
    au!
    au VimEnter,ColorScheme * :hi link IndentGuidesOdd DiffAdd
    au VimEnter,ColorScheme * :hi link IndentGuidesEven ToolbarLine
    au FileType * if &expandtab
      | g:IvimIndentGuidesEnable() | endif
  augroup END
endif
