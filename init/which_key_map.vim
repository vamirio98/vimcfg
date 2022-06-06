"-
" which_key_map.vim
"
" Created by vamirio on 2021 Dec 23
"-
let g:leader_map = {}
let g:space_map = {}

nnoremap <silent> <leader> :<C-u>WhichKey '\'<CR>
nnoremap <silent> <space> :<C-u>WhichKey ' '<CR>

let g:leader_map = { 'name' : '+Leader',
			\ '1' : 'switch to tab 1',
			\ '2' : 'switch to tab 2',
			\ '3' : 'switch to tab 3',
			\ '4' : 'switch to tab 4',
			\ '5' : 'switch to tab 5',
			\ '6' : 'switch to tab 6',
			\ '7' : 'switch to tab 7',
			\ '8' : 'switch to tab 8',
			\ '9' : 'switch to tab 9',
			\ '0' : 'switch to tab 10',
			\ }

let g:leader_map.c = {
			\ 'name' : '+close-tab/cscope',
			\ '1' : 'close tab 1',
			\ '2' : 'close tab 2',
			\ '3' : 'close tab 3',
			\ '4' : 'close tab 4',
			\ '5' : 'close tab 5',
			\ '6' : 'close tab 6',
			\ '7' : 'close tab 7',
			\ '8' : 'close tab 8',
			\ '9' : 'close tab 9',
			\ '0' : 'close tab 10',
			\ 'a' : 'where-current-symbol-is-assiagned',
			\ 'c' : 'functions-calling-this-function',
			\ 'd' : 'functions-called-by-this-function',
			\ 'e' : 'egrep-pattern-under-curosr',
			\ 'f' : 'filename-under-cursor',
			\ 'g' : 'symbol-definition',
			\ 'i' : 'files-#including-the-filename-under-cursor',
			\ 't' : 'text-string',
			\ 's' : 'symbol-reference',
			\ 'z' : 'current-word',
			\ }

let g:leader_map.r = {
			\ 'name' : '+rename-symbol',
			\ 'n' : 'rename-symbol',
			\ }

let g:space_map.a = {
			\ 'name' : '+asynctasks',
			\ 'a' : 'query-available-tasks',
			\ 'c' : 'compile-single-file',
			\ 'C' : 'compile-single-file-with-debug-info',
			\ 'd' : 'debug-program',
			\ 'D' : 'delete-program',
			\ 'm' : {
				\ 'name' : '+make',
				\ 'b' : 'make-build',
				\ 'c' : 'make-clean',
				\ 'd' : 'make-debug',
				\ 'r' : 'make-run',
				\ },
			\ 'q' : 'open/close-quickfix-window',
			\ 'r' : 'run-program',
			\ }

let g:space_map.c = {
			\ 'name': '+coc',
			\ 'l' : {
				\ 'name' : '+coc-list',
				\ 'c' : 'show-commands',
				\ 'd' : 'show-all-diagnostics',
				\ 'e' : 'manage-extensions',
				\ 'j' : 'do-default-action-for-next-item',
				\ 'k' : 'do-default-action-for-prev-item',
				\ 'o' : 'find-symbol-of-current-document',
				\ 'p' : 'resum-latest-coc-list',
				\ 's' : 'search-workspace-symbol',
				\ },
			\ }

let g:space_map.e = {
			\ 'name' : '+edit-vim-profile',
			\ 'v' : {
				\ 'name' : '+edit-vim-profile',
				\ 'b' : 'basic',
				\ 'k' : 'keymaps',
				\ 'w' : 'which-key-map',
				\ 'p' : 'plugins',
				\ 't' : 'terminal',
				\ 'u' : 'ui',
				\ },
			\ }

let g:space_map.f = {
			\ 'name' : '+format-code',
			\ 't' : 'format-code',
			\ }

let g:space_map.l = {
			\ 'name' : '+translation',
			\ 't' : 'popup',
			\ 'e' : 'echo',
			\ 'r' : 'replace',
			\ }

let g:space_map.q = {
			\ 'name' : '+quick-fix',
			\ 'f' : 'quick-fix',
			\ }

let g:space_map.s = {
			\ 'name' : '+source-curr-vimscript',
			\ 'v' : 'source-curr-vimscript',
			\ }

let g:space_map.t = {
			\ 'name' : '+float-terminal',
			\ 'a' : 'a-new-terminal',
			\ 'c' : 'close-terminal',
			\ 'n' : 'next-terminal',
			\ 'p' : 'prev-terminal',
			\ 't' : 'open/hide-terminal',
			\ }

call which_key#register('\', "g:leader_map")
call which_key#register(' ', "g:space_map")
