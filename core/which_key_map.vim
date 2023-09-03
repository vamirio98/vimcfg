" which_key_map.vim
" Must be loaded after plugins.vim
" Author: vamirio

let g:leader_map = {}
let g:space_map = {}

nnoremap <silent> <leader> :<C-u>WhichKey '\'<CR>
nnoremap <silent> <space> :<C-u>WhichKey ' '<CR>

let g:leader_map = {
			\ 'name': '+Leader',
			\ '1': 'which_key_ignore',
			\ '2': 'which_key_ignore',
			\ '3': 'which_key_ignore',
			\ '4': 'which_key_ignore',
			\ '5': 'which_key_ignore',
			\ '6': 'which_key_ignore',
			\ '7': 'which_key_ignore',
			\ '8': 'which_key_ignore',
			\ '9': 'which_key_ignore',
			\ '0': 'which_key_ignore',
			\ }

let g:leader_map.a = 'apply-code-action'

let g:leader_map.c = {
			\ 'name': '+cscope',
			\ '1': 'which_key_ignore',
			\ '2': 'which_key_ignore',
			\ '3': 'which_key_ignore',
			\ '4': 'which_key_ignore',
			\ '5': 'which_key_ignore',
			\ '6': 'which_key_ignore',
			\ '7': 'which_key_ignore',
			\ '8': 'which_key_ignore',
			\ '9': 'which_key_ignore',
			\ '0': 'which_key_ignore',
			\ 'a': 'where-current-symbol-is-assigned',
			\ 'c': 'functions-calling-this-function',
			\ 'd': 'functions-called-by-this-function',
			\ 'e': 'egrep-pattern-under-cursor',
			\ 'f': 'filename-under-cursor',
			\ 'g': 'symbol-definition',
			\ 'i': 'files-#including-the-filename-under-cursor',
			\ 't': 'text-string',
			\ 's': 'symbol-reference',
			\ 'z': 'current-word',
			\ }

let g:leader_map.f = 'search-1-char'

let g:leader_map.F = 'search-2-char'

let g:leader_map.o = 'toggle-outline'

let g:leader_map.r = {
			\ 'name': '+refactor/rename symbol',
			\ 'f': 'refactor',
			\ 'n': 'rename-symbol',
			\ }

let g:leader_map.w = 'move-to-window'

let g:space_map.a = 'query-available-tasks'

let g:space_map.c = 'show-coc-commands'

let g:space_map.d = "show-all-diagnostics"

let g:space_map.f = {
			\ 'name': '+search/format-code',
			\ 'b': 'search buffer',
			\ 'c': 'format code',
			\ 'f': 'search file',
			\ 'n': 'search function'
			\ }

let g:space_map.j = 'do-default-action-for-next-item'

let g:space_map.k = 'do-default-action-for-prev-item'

let g:space_map.p = 'resume-latest-coc-list'

let g:space_map.q = {
			\ 'name': '+quick-fix',
			\ 'f': 'quick-fix',
			\ }

let g:space_map.s = 'search-document-symbols'

let g:space_map.S = 'search-workspace-symbols'

let g:space_map.t = 'translate'

call which_key#register('\', "g:leader_map")
call which_key#register(' ', "g:space_map")
