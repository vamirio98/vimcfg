" all directories in vim runtimepath whose name is as follow will be search
" for snippet
let g:UltiSnipsSnippetDirectories=["ultisnips", "UltiSnips"]
" add site to runtimepath so that UltiSnips can recognize the snippets
exec printf("set runtimepath+=%s/site", g:ivim_home)

let g:UltiSnipsEditSplit = "horizontal"

" keymap
let g:UltiSnipsExpandTrigger = "<C-J>"
let g:UltiSnipsJumpForwardTrigger = "<C-J>"
let g:UltiSnipsJumpBackwardTrigger = "<C-K>"
let g:UltiSnipsListSnippets = "<C-X><C-X>"
