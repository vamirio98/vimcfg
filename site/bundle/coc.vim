vim9script

import autoload "../../autoload/imodule/keymap.vim" as ikeymap
import autoload "../../autoload/ilib/path.vim" as ipath
import autoload "../../autoload/imodule/plug.vim" as iplug
import autoload "../../autoload/ilib/ui.vim" as iui

# some servers have issues with backup files,
# see https://github.com/neoclide/coc.nvim/issues/649
set nobackup
set nowritebackup

# having longer updatetime (default is 4000 ms = 4s) leads to noticeable
# delays and poor user experience
set updatetime=300

# always show the signcolumn, otherwise it would shift the text each time
# diagnostics appear/become resolved
set signcolumn=yes

# ensure the following extensions will be install auto
g:coc_global_extensions = [
  'coc-json', 'coc-clangd',
  'coc-pyright',
  'coc-snippets', 'coc-highlight'
]

# global coc-settings.json
g:coc_config_home = ipath.Join(g:ivim_home, 'site', 'third_party', 'coc')
# global settings
g:coc_user_config = get(g:, 'coc_user_config', {})
g:coc_user_config['workspace.rootPatterns'] = g:ivim_rootmarkers

# use UltiSnip
if iplug.Has('ultisnips')
  g:coc_snippet_next = ''
  g:coc_snippet_prev = ''
  g:coc_selectmode_mapping = 0
else
  g:coc_snippet_next = '<C-j>'
  g:coc_snippet_prev = '<C-k>'
  g:coc_selectmode_mapping = 1
endif

g:coc_status_error_sign = ' '
g:coc_status_warning_sign = ' '
g:coc_notify_error_icon = ''
g:coc_notify_warning_icon = ''
g:coc_notify_info_icon = ''

g:coc_borderchars = ['─', '│', '─', '│', '╭', '╮', '╯', '╰', ]

# {{{ keymap
var AddGroup = ikeymap.AddGroup
var AddDesc = ikeymap.AddDesc

def ShowDoc(): void
  if g:CocHasProvider('hover')
    g:CocActionAsync('doHover')
  else
    feedkeys('K', 'in')
  endif
enddef
nnoremap K <ScriptCmd>ShowDoc()<CR>

nmap <silent> <M-s> <Plug>(coc-range-select)
nmap <silent> <M-S> <Plug>(coc-range-select-backward)
vmap <silent> <M-s> <Plug>(coc-range-select)
vmap <silent> <M-S> <Plug>(coc-range-select-backward)

# {{{ goto
AddGroup('g', 'goto')

def CocAction(keys: string, ability: string, ...action: list<any>)
  if g:CocHasProvider(ability)
    call(g:CocActionAsync, action)
  else
    feedkeys(keys, 'in')
  endif
enddef

nnoremap gd <ScriptCmd>CocAction('gd', 'definition', ['jumpDefinition'])<CR>
AddDesc('gd', 'Go to Definition')
nnoremap gD <ScriptCmd>CocAction('gD', 'declaration', ['jumpDeclaration'])<CR>
AddDesc('gD', 'Go to Declaration')

nnoremap gi <Cmd>call g:CocActionAsync('jumpImplementation', v:false)<CR>
AddDesc('gi', 'Go to implementation')

nnoremap gr <Cmd>call g:CocActionAsync('jumpUsed', v:false)<CR>
AddDesc('gr', 'Go to References')

nnoremap gy <Cmd>call g:CocActionAsync('jumpTypeDefinition')<CR>
AddDesc('gy', 'Go to Type Definition')

# }}}

# use tab for navigate
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) :
      \ (pumvisible() ? "\<C-n>" : "\<Tab>")
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) :
      \ (pumvisible() ? "\<C-p>" : "\<C-h>")
inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"
inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"
inoremap <silent><expr> <down> coc#pum#visible() ? coc#pum#next(1) : "\<down>"
inoremap <silent><expr> <up> coc#pum#visible() ? coc#pum#prev(1) : "\<up>"
inoremap <silent><expr> <PageDown> coc#pum#visible() ? coc#pum#scroll(1) : "\<PageDown>"
inoremap <silent><expr> <PageUp> coc#pum#visible() ? coc#pum#scroll(0) : "\<PageUp>"
inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<C-e>"
inoremap <silent><expr> <C-y> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"

# use <c-space> to toggle completion
if !has('gui_running')
  inoremap <silent><expr> <C-@> coc#pum#visible() ? coc#pum#cancel() : coc#refresh()
else
  inoremap <silent><expr> <C-space> coc#pum#visible() ? coc#pum#cancel() : coc#refresh()
endif

# {{{ navigate
nmap [d <Plug>(coc-diagnostic-prev)
nmap ]d <Plug>(coc-diagnostic-next)
nmap [e <Plug>(coc-diagnostic-prev-error)
nmap ]e <Plug>(coc-diagnostic-next-error)
AddDesc('[d', 'Prev Diag')
AddDesc(']d', 'Next Diag')
AddDesc('[e', 'Prev Error')
AddDesc(']e', 'Prev Error')

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
AddDesc('if', 'Inside Func', 'v')
AddDesc('af', 'Around Func', 'v')
AddDesc('ic', 'Inside Class', 'v')
AddDesc('ac', 'Around Class', 'v')

# remap <C-f> and <C-b> to scroll float windows/popups
if has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
# }}}

# add current word to multi-cursor
nmap <M-c> <Plug>(coc-cursors-word)
nmap <M-C> <Plug>(coc-cursors-position)
vmap <M-c> <Plug>(coc-cursors-range)

# {{{ code
AddGroup('<leader>c', 'code')

nmap <silent> <leader>ca <Plug>(coc-codeaction)
AddDesc('<leader>ca', 'Code Action (cword)')
xmap <silent> <leader>ca <Plug>(coc-codeaction-selected)
nmap <silent> <leader>cA <Plug>(coc-codeaction-source)
AddDesc('<leader>cA', 'Code Action (document)')

nnoremap <leader>cc <Cmd>call g:CocAction('showIncomingCalls')<CR>
nnoremap <leader>cC <Cmd>call g:CocAction('showOutgoingCalls')<CR>
AddDesc('<leader>cc', 'Show Incoming Call')
AddDesc('<leader>cC', 'Show Outgoing Call')

nnoremap <leader>cd <Cmd>CocDiagnostics<CR>
AddDesc('<leader>cd', 'Show Diagnostics')

nnoremap <leader>cf <Cmd>call g:CocActionAsync('format')<CR>
xmap <leader>cf <Plug>(coc-format-selected)
AddDesc('<leader>cf', 'Foramt')
AddDesc('<leader>cf', 'Foramt', 'v')
nmap <silent> <leader>cF <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>cF <Plug>(coc-codeaction-refactor-selected)
AddDesc('<leader>cF', 'Refactor')
AddDesc('<leader>cF', 'Refactor', 'v')

nmap <silent> <leader>cl <Plug>(coc-codelens-action)
AddDesc('<leader>cl', 'Code Lens Action')
nnoremap <leader>cL <Cmd>CocCommand document.checkBuffer<CR>
AddDesc('<leader>cL', 'Show Lsp Info')

def ToggleOutline(): void
  var winid: number = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    g:CocActionAsync('showOutline')
  else
    g:CocActionAsync('hideOutline')
  endif
enddef
nnoremap <leader>co <ScriptCmd>ToggleOutline()<CR>
AddDesc('<leader>co', 'Toggle Outline')
nnoremap <leader>cO <Cmd>call g:CocAction('organizeImport')<CR>
AddDesc('<leader>cO', 'Organize Import')


nmap <leader>cq <Plug>(coc-fix-current)
AddDesc('<leader>cq', 'Quick Fix')

nmap <leader>cr <Plug>(coc-rename)
AddDesc('<leader>cr', 'Rename Symbol')
nnoremap <leader>cR <Cmd>CocCommand workspace.renameCurrentFile<CR>
AddDesc('<leader>cR', 'Rename Cur File')

nnoremap <leader>cy <Cmd>call g:CocAction('showSuperTypes')<CR>
nnoremap <leader>cY <Cmd>call g:CocAction('showSubTypes')<CR>
AddDesc('<leader>cy', 'Show Super Type')
AddDesc('<leader>cY', 'Show Sub Type')

# }}}

# ui
nnoremap <leader>uh <Cmd>CocCommand document.toggleInlayHint<CR>
AddDesc('<leader>uh', 'Toggle Inlay Hint')
nnoremap <leader>ud <Cmd>call g:CocAction('diagnosticToggle')<CR>
AddDesc('<leader>ud', 'Toggle Diagnostic (Global)')
nnoremap <leader>uD <Cmd>call g:CocAction('diagnosticToggleBuffer')<CR>
AddDesc('<leader>uD', 'Toggle Diagnostic (Cur Buffer)')

# {{{ CocList
AddGroup('<leader>C', 'coc-list')
nnoremap <leader>Cc <Cmd>CocList commands<CR>
AddDesc('<leader>Cc', 'Command')
nnoremap <leader>Cd <Cmd>CocList diagnostics<CR>
AddDesc('<leader>Cd', 'Diags')
nnoremap <leader>Ce <Cmd>CocList extensions<CR>
AddDesc('<leader>Ce', 'Extensions')
nnoremap <leader>Cp <Cmd>CocListResume<CR>
AddDesc('<leader>Cp', 'Resume Lastest Command')

nnoremap <leader>ss <Cmd>CocList outline<CR>
AddDesc('<leader>ss', 'Symbols (Cur File)')
nnoremap <leader>sS <Cmd>CocList -I symbols<CR>
AddDesc('<leader>sS', 'Symbols (Workspace)')
# }}}

# }}}

augroup ivim_coc
  au!
  # Highlight symbol and its references when holding the cursor
  au CursorHold * silent g:CocActionAsync('highlight')
  # Setup formatexpr specified filetype(s)
  au FileType json,typescript setl formatexpr=g:CocAction('formatSelected')
  # Update signature help on jump placeholder
  au User CocJumpPlaceholder g:CocActionAsync('showSignatureHelp')
augroup END
