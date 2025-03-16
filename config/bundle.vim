if !exists('g:ivim_bundle')
  let g:ivim_bundle = [
        \ 'coding',
        \ 'debug',
        \ 'editor',
        \ 'ui',
        \ 'tags',
        \ ]
endif

let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
if !exists(':IncScript')
  command! -nargs=1 IncScript exec 'so ' . fnameescape(s:home .'/<args>')
endif
function s:LoadConf(script)
  exec "augroup ivim_" . a:script
  exec "au!"
  exec "au User IvimBundleLoadPost IncScript " . a:script
  exec "augroup END"
endfunc
command! -nargs=1 LoadConf call s:LoadConf('<args>')

let s:bundle = {}
for key in g:ivim_bundle
  let s:bundle[key] = 1
endfor
if !exists('g:ivim_lsp_provider')
  let g:ivim_lsp_provider = 'ycm'
endif

" specify a directory for plugins
let s:bundle_home = get(g:, 'bundle_home', '~/.vim/bundle')
call plug#begin(s:bundle_home)

"--------------------------------------------------------------
" coding
"--------------------------------------------------------------
" {{{ coding
if has_key(s:bundle, 'coding')
  Plug 'LunarWatcher/auto-pairs'
  LoadConf site/bundle/auto_pairs.vim

  Plug 'axelf4/vim-strip-trailing-whitespace'
  LoadConf site/bundle/strip_trailing_whitespace.vim

  Plug 'andymass/vim-matchup'
  LoadConf site/bundle/match_up.vim

  if has('python3')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    LoadConf site/bundle/ultisnips.vim
  else
    call imodule#ui#error("no python3 support")
  endif

  if g:ivim_lsp_provider == 'ycm'
    Plug 'ycm-core/YouCompleteMe', {'do': 'python3 install.py --clangd-completer --cs-completer --go-completer --rust-completer --java-completer --ts-completer'}
    " for lsp config examples
    Plug 'ycm-core/lsp-examples'
    LoadConf site/bundle/ycm.vim
  elseif g:ivim_lsp_provider == 'coc'
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
    LoadConf site/bundle/coc.vim
  endif
endif
" }}}

if has_key(s:bundle, 'debug')
  Plug 'puremourning/vimspector'
  LoadConf site/bundle/vimspector.vim
endif

" {{{ editor
if has_key(s:bundle, 'editor')
  Plug 'monkoose/vim9-stargate'
  LoadConf site/bundle/easy_motion.vim

  Plug 'liuchengxu/vim-which-key'
  LoadConf site/bundle/which_key.vim

  Plug 'voldikss/vim-floaterm'
  LoadConf site/bundle/floaterm.vim
  " TODO: use myself terminal manager

  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  LoadConf site/bundle/git.vim

  Plug 'justinmk/vim-dirvish'
  LoadConf site/bundle/dirvish.vim

  Plug 'skywind3000/asyncrun.vim'
  Plug 'skywind3000/asynctasks.vim'
  LoadConf site/bundle/asynctasks.vim

  Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
  Plug 'Yggdroot/LeaderF-marks'
  Plug 'FahimAnayet/LeaderF-map'
  LoadConf site/bundle/leaderf.vim

  " text opeartor
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-speeddating'
  Plug 'svermeulen/vim-yoink'
  " TODO: create map
endif
" }}}

if has_key(s:bundle, 'tags')
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'skywind3000/gutentags_plus'
  LoadConf site/bundle/tags.vim
endif

" {{{ ui
if has_key(s:bundle, 'ui')
  Plug 'sainnhe/gruvbox-material'
  LoadConf site/bundle/gruvbox_material.vim

  Plug 'ryanoasis/vim-devicons'

  Plug 'luochen1990/rainbow'
  LoadConf site/bundle/rainbow.vim
  Plug 'bfrg/vim-cpp-modern'
  Plug 'preservim/vim-indent-guides'
  LoadConf site/bundle/indent_guides.vim

  Plug 'itchyny/lightline.vim'
  Plug 'mengelbrecht/lightline-bufferline'
  LoadConf site/bundle/lightline.vim
endif
" }}}

" initialize plugin system
call plug#end()

doautocmd <nomodeline> User IvimBundleLoadPost
