let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let g:vimcfg_home = s:home
command! -nargs=1 IncScript exec 'so ' . fnameescape(s:home . '/<args>')
exec 'set rtp+=' . fnameescape(s:home)
set rtp+=~/.vim

if !has('nvim')
  IncScript vim.vim
else
  IncScript nvim.vim
endif
