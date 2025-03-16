let s:Desc = function('imodule#keymap#add_desc')
let s:Group = function('imodule#keymap#add_group')

" ensure the following extensions will be install auto
let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-vimlsp']

" some servers have issues with backup files,
" see https://github.com/neoclide/coc.nvim/issues/649
set nobackup
set nowritebackup

" having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ (<SID>check_backspace() ? "\<Tab>" :
      \ coc#refresh())
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Make <C-CR> to always feedkeys <CR>
function! s:ForceEnter()
  if coc#pum#visible()
    call coc#float#close_all()
  endif
  call feedkeys("\<cr>", 'n')
endfunc
inoremap <silent> <C-CR> <cmd>call <SID>force_enter()<cr>

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
call s:Map('n', '[d', '<Plug>(coc-diagnostic-prev',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Prev Diagnostic'})
call s:Map('n', ']d', '<Plug>(coc-diagnostic-next',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Next Diagnostic'})
call s:Map('n', '[e', '<Plug>(coc-diagnostic-prev-error',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Prev Error'})
call s:Map('n', ']e', '<Plug>(coc-diagnostic-next-error',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Next Error'})

" GoTo code navigation
call s:Map('n', 'gd', '<Plug>(coc-definition)',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Go to Definition'})
call s:Map('n', 'gD', '<Plug>(coc-declaration)',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Go to Declaration'})
call s:Map('n', 'gy', '<Plug>(coc-type-definition)',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Go to Type Definition'})
call s:Map('n', 'gi', '<Plug>(coc-implementation)',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Go to Implementation'})
call s:Map('n', 'gr', '<Plug>(coc-references)',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Go to References'})

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

call s:Group(['n', 'v'], '<leader>c', 'code')
" Symbol renaming
call s:Map('n', '<leader>cr', '<Plug>(coc-rename)',
      \ {'noremap': 0, 'desc': 'Rename Symbol'})

" Remap keys for applying code actions at the cursor position
call s:Map('n', '<leader>ca', '<Plug>(coc-codeaction-cursor)',
      \ {'noremap': 0, 'desc': 'Apply Code Action at Cursor'})
" Remap keys for apply code actions affect whole buffer
call s:Map('n', '<leader>cA', '<Plug>(coc-codeaction-source)',
      \ {'noremap': 0, 'desc': 'Apply Code Action for Source'})
" Apply the most preferred quickfix action to fix diagnostic on the current line
call s:Map('n', '<leader>cq', '<Plug>(coc-fix-current)',
      \ {'noremap': 0, 'desc': 'Quick Fix'})

" Remap keys for applying refactor code actions
call s:Group('n', '<leader>r', 'refactor')
call s:Map('n', '<leader>rf', '<Plug>(coc-codeaction-refactor)',
      \ {'noremap': 0, 'desc': 'Refactor'})
call s:Map('x', '<leader>rf', '<Plug>(coc-codeaction-refactor)',
      \ {'noremap': 0, 'desc': 'Refactor'})

" Run the Code Lens action on the current line
call s:Map('n', '<leader>cl', '<Plug>(coc-codelens-action)',
      \ {'noremap': 0, 'desc': 'Run Code Lens'})

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

call s:Map('n', '<leader>cf', '<cmd>call CocActionAsync("format")<CR>',
      \ {'noremap': 0, 'desc': 'Format'})
" Formatting selected code
call s:Map(['n', 'v'], '<leader>cF', '<Plug>(coc-format-selected)',
      \ {'noremap': 0, 'desc': 'Format Selected'})

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
call s:Map('n', '<leader>co',
      \ "<cmd>call CocActionAsync('runCommand', 'editor.action.organizeImport')<CR>",
      \ {'noremap': 0, 'desc': 'Organize Imports'})

" selections ranges
" Requires 'textDocument/selectionRange' support of language server
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

" Mappings for CoCList
" Show all diagnostics
call s:Map('n', '<leader>Ca', ':<C-u>CocList diagnostics<CR>',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Show all Diagnostics'})
" Manage extensions
call s:Map('n', '<leader>Ce', ':<C-u>CocList extensions<CR>',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Show all Extensions'})
" Show commands
call s:Map('n', '<leader>Cc', ':<C-u>CocList commands<CR>',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Show all Commands'})
" Find symbol of current document
call s:Map('n', '<leader>ss', ':<C-u>CocList outline<CR>',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Find Symbols (Current Document)'})
" Search workspace symbols
call s:Map('n', '<leader>sS', ':<C-u>CocList -I symbols<CR>',
      \ {'nowait': 1, 'noremap': 0, 'desc': 'Find symbols (Workspace)'})
" Do default action for next item
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

augroup ivim_coc
  au!
  " Highlight symbol and its references when holding the cursor
  au CursorHold * silent call g:CocActionAsync('highlight')
  " Setup formatexpr specified filetype(s)
  au FileType json,typescript setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  au User CocJumpPlaceholder call g:CocActionAsync('showSignatureHelp')
augroup END
