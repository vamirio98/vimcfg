" set root dir of a project
let g:gutentags_project_root = get(g:, 'ivim_rootmarkers', ['.root', '.svn', '.hg', '.git', '.project'])

" set ctags file name
let g:gutentags_ctas_tagfile = '.tags'

" if has LeaderF, set tags directory by LeaderF
if !imodule#plug#has('LeaderF')
  " detect dir ~/.cache/tags, create new one if it doesn't exist
  let s:tag_cache_dir = ilib#path#join(g:ivim_cache_dir, 'tags')
  if !isdirectory(s:tag_cache_dir)
    silent! call mkdir(s:tag_cache_dir, 'p')
  endif
  " set dir to save the tag file
  let g:gutentags_cache_dir = s:tag_cache_dir
endif

" use a ctags-compatible program to generate a tags file and
" GNU's gtags to generate a code database file
let g:gutentags_modules = []
if executable('ctags')
  let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
  let g:gutentags_modules += ['gtags_cscope']
endif
if empty(g:gutentags_modules)
  call imodule#ui#error('No ctags/gtags found')
endif

" set ctags arguments
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" use universal-ctags
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" config gutentags whitelist
let g:gutentags_exclude_filetypes = ['text']

" prevent gutentags from autoloading gtags database
let g:gutentags_auto_add_gtags_cscope = 0

" change focus to quickfix window after search
let g:gutentags_plus_switch = 1

let g:gutentags_plus_nomap = 1
