vim9script

g:ycm_auto_trigger = 1

g:ycm_enable_semantic_highlighting = 1

g:ycm_enable_inlay_hints = 0
g:ycm_clear_inlay_hints_in_insert_mode = 0
g:ycm_auto_hover = ""
g:ycm_open_loclist_on_ycm_diags = 0

g:ycm_error_symbol = ''
g:ycm_warning_symbol = ''
g:ycm_echo_current_diagnostic = 'virtual-text'
g:ycm_update_diagnostics_in_insert_mode = 0
g:ycm_keep_logfiles = 0
g:ycm_log_level = 'info'
g:ycm_key_invoke_completion = '<C-Space>'
g:ycm_disable_for_files_larger_than_kb = 1000
g:ycm_signature_help_disable_syntax = 0

# lsp
g:ycm_clangd_args = [ '--header-insertion=never' ]

# {{{ map

imodule#keymap#add_group('<leader>c', 'code')
var Desc = function('imodule#keymap#add_desc')

imap <C-l> <Plug>(YCMToggleSignatureHelp)

nmap K <Plug>(YCMHover)

# {{{ code
nmap <leader>cc <Plug>(YCMCallHierarchy)
Desc('<leader>cc', 'Call Hierarchy')

def FindDiag(): void
  exec 'YcmDiags'
  exec 'Leaderf --bottom loclist'
enddef
nnoremap <leader>cd <Cmd>call <SID>FindDiag()<CR>
Desc('<leader>cd', 'Show All Diags')
g:ycm_key_detailed_diagnostics = '<leader>cD'
Desc('<leader>cD', 'Show Diag Detail')

nnoremap <leader>cf <Cmd>YcmCompleter Format<CR>
Desc('<leader>cf', 'Format')
vnoremap <leader>cf <Cmd>'<,'>YcmCompleter Format<CR>
Desc('<leader>cf', 'Format', 'v')

nnoremap <leader>ch <Cmd>YcmCompleter GoToAlternateFile<CR>
Desc('<leader>ch', 'Switch Header/Source')

nnoremap <leader>cq <Cmd>YcmCompleter FixIt<CR>
Desc('<leader>cq', 'Quick Fix')

def RenameSymbol(): void
  let new_name = ilib#core#input('New name: ')
  if empty(new_name)
    return
  endif
  exec 'YcmCompleter RefactorRename' new_name
enddef
nnoremap <leader>cr <ScriptCmd>call RenameSymbol()<CR>
Desc('<leader>cr', 'Rename Symbol')
nnoremap <leader>cR <Cmd>YcmForceCompileAndDiagnostics<CR>
Desc('<leader>cR', 'Refresh Diags')

nmap <leader>ct <Plug>(YCMTypeHierarchy)
Desc('<leader>ct', 'Type Hierarchy')
# }}}

# {{{ search
def FindSymbolCurDoc()
  exec 'YcmCompleter GoToDocumentOutline'
  cclose
  exec 'Leaderf --nameOnly quickfix'
enddef
nnoremap <leader>ss <ScriptCmd>call FindSymbolCurDoc()<CR>
imodule#keymap#add_group('<leader>s', 'search')
Desc('<leader>ss', 'Symbol (Current File)')
# }}}

# {{{ toggle
nmap <leader>uh <Plug>(YCMToggleInlayHints)
imodule#keymap#add_group('<leader>u', 'ui')
Desc('<leader>uh', 'Toggle Inlay Hints')
# }}}

# {{{ goto
nnoremap gd <Cmd>YcmCompleter GoToDeclaration<CR>
Desc('gd', 'Go to Declaration')
nnoremap gD <Cmd>YcmCompleter GoToDefinition<CR>
Desc('gD', 'Go to Definition')
nnoremap gi <Cmd>YcmCompleter GoToImplementation<CR>
Desc('gi', 'Go to Implementation')
def FindReferences()
  exec 'YcmCompleter GoToReferences'
  silent! cclose
  exec 'Leaderf quickfix'
enddef
nnoremap gr <ScriptCmd>call FindReferences()<CR>
Desc('gr', 'Go to References')
# }}}

# }}}

# load lsp config
exec 'so ' .. fnameescape(g:bundle_home .. '/lsp-examples/vimrc.generated')
# setup lsp {{{
const LSP = [
       # {
       #   'exe': 'vim-language-server',
       #   'config': {
       #     'name': 'vim',
       #     'filetypes': ['vim'],
       #     'cmdline': ['vim-language-server', '--stdio']
       #   },
       # },
      ]
g:ycm_language_server = get(g:, 'ycm_language_server', [])
for lsp in LSP
  if executable(lsp.exe)
    g:ycm_language_server += [lsp.config]
  endif
endfor
# }}}

augroup ivim_ycm
  au!
  au FileType c,cpp b:ycm_hover = { 'command': 'GetDoc', 'syntax': &ft, }
  au FileType python b:ycm_hover = { 'command': 'GetHover', 'syntax': &ft, }
  au FileType vim b:ycm_hover = {'command': 'GetHover', 'syntax': 'help'}
augroup END

command! -nargs=0 IvimLspRestart exec 'YcmRestartServer'
command! -nargs=0 IvimLspRefresh exec 'YcmForceCompileAndDiagnostics'
command! -nargs=0 IvimShowDiags  FindDiag()
command! -nargs=0 IvimShowLspLog exec 'YcmDebugInfo'
