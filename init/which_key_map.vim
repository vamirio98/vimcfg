"-
" which_key_map.vim
"
" Created by Vamirio on 2021 Dec 23
" Last Modified: 2021 Dec 23 20:12:46
"-
let g:leader_map = {}
let g:space_map = {}

nnoremap <silent> <leader> :<C-u>WhichKey '\'<CR>
nnoremap <silent> <space> :<C-u>WhichKey ' '<CR>

let g:leader_map = { 'name' : '+Leader',
			\ '1' : 'tab 1',
			\ '2' : 'tab 2',
			\ '3' : 'tab 3',
			\ '4' : 'tab 4',
			\ '5' : 'tab 5',
			\ '6' : 'tab 6',
			\ '7' : 'tab 7',
			\ '8' : 'tab 8',
			\ '9' : 'tab 9',
			\ '0' : 'tab 10',
			\ }

let g:leader_map.c = {
			\ 'name' : '+close-tab',
			\ '1' : 'tab 1',
			\ '2' : 'tab 2',
			\ '3' : 'tab 3',
			\ '4' : 'tab 4',
			\ '5' : 'tab 5',
			\ '6' : 'tab 6',
			\ '7' : 'tab 7',
			\ '8' : 'tab 8',
			\ '9' : 'tab 9',
			\ '0' : 'tab 10',
			\ }

let g:leader_map.f = {
			\ 'name' : '+float-terminal',
			\ 'a' : 'a-new-terminal',
			\ 'c' : 'close-terminal',
			\ 'n' : 'next-terminal',
			\ 'p' : 'prev-terminal',
			\ 't' : 'open/hide-terminal',
			\ }

let g:leader_map.r = {
			\ 'name' : '+rename-symbol',
			\ 'n' : 'rename-symbol',
			\ }

let g:leader_map.t = {
			\ 'name' : '+asynctasks',
			\ 'c' : 'compile-single-file',
			\ 'C' : 'compile-single-file-with-debug-info',
			\ 'd' : 'debug-program',
			\ 'D' : 'delete-program',
			\ 'q' : 'query-available-tasks',
			\ 'm' : {
				\ 'name' : '+make',
				\ 'b' : 'make-build',
				\ 'c' : 'make-clean',
				\ 'd' : 'make-debug',
				\ 'r' : 'make-run',
				\ },
			\ 'r' : 'run-program',
			\ }

let g:space_map.c = {
			\ 'name': '+coc-list',
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

let g:space_map.q = {
			\ 'name' : '+quick-fix',
			\ 'f' : 'quick-fix',
			\ }

let g:space_map.r = {
			\ 'name' : '+REPL',
			\ 't' : 'open/exit-REPL-enviroment',
			\ 'h' : 'hide-REPL-enviroment',
			\ 's' : 'send-code-to-REPL-enviroment',
			\ }

let g:space_map.s = {
			\ 'name' : '+source-curr-vimscript',
			\ 'v' : 'source-curr-vimscript',
			\ }

let g:space_map.t = {
			\ 'name' : '+translation',
			\ 't' : 'popup',
			\ 'e' : 'echo',
			\ 'r' : 'replace',
			\ }

call which_key#register('\', "g:leader_map")
call which_key#register(' ', "g:space_map")
