let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let g:ivim_home = s:home
command! -nargs=1 IncScript exec 'so ' . fnameescape(s:home . '/<args>')
exec 'set rtp+=' . fnameescape(s:home)
set rtp+=~/.vim

" check for depend
let s:dependency = ['rg', 'fd']
for dep in s:dependency
  if !executable(dep)
    call lib#ui#error('no ['.dep.'] be found in PATH, some plugins may broken')
  endif
endfor

IncScript config/options.vim
IncScript config/ignores.vim
IncScript config/bundle.vim
IncScript config/keymaps.vim
IncScript config/autocmds.vim

let g:ivim_loaded = 1
