vim9script

import autoload "./autoload/ilib/ui.vim" as ui

var home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
g:ivim_home = home
command! -nargs=1 IncScript exec 'so' fnameescape(home .. '/<args>')
exec 'set rtp+=' .. fnameescape(home)
set rtp+=~/.vim

# check for depend
const DEPENDENCY = ['rg', 'fd']
for dep in DEPENDENCY
  if !executable(dep)
    lib#ui#error('no ['..dep..'] be found in PATH, some plugins may broken')
  endif
endfor

IncScript config/options.vim
IncScript config/ignores.vim
IncScript config/bundle.vim
IncScript config/keymaps.vim
IncScript config/autocmds.vim

g:ivim_loaded = 1

augroup ivim_loaded
  au!
  au VimEnter * ui.vim_enter = true
augroup END
