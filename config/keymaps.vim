" {{{ make sure function work normally
" set Alt and function key in terminal

" disable ALT on GUI, make it can be used for mapping
set winaltkeys=no

set timeoutlen=500

" turn on function key timeout detection (the function key in the
" terminal is a charset starts with ESC)
set ttimeout

" function key timeout detection: 50ms
set ttimeoutlen=50

if $TMUX != ''
	set ttimeoutlen=30
elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
	set ttimeoutlen=80
endif
" use ALT in terminal, should set ttimeout and ttimeoutlen at first
" refer: http://www.skywind.me/blog/archives/2021
if has('nvim') == 0 && has('gui_running') == 0
	function! s:SetMetacode(key)
		execute "set <M-" .. a:key .. ">=\e" .. a:key
		execute "imap \e" .. a:key .. " <M-" .. a:key .. ">"
	endfunction
	for i in range(10)
		call s:SetMetacode(nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		call s:SetMetacode(nr2char(char2nr('a') + i))
		call s:SetMetacode(nr2char(char2nr('A') + i))
	endfor
	for c in [',', '.', '/', ';', '{', '}']
		call s:SetMetacode(c)
	endfor
	for c in ['?', ':', '-', '_', '+', '=', "'"]
		call s:SetMetacode(c)
	endfor
endif

" use function key in terminal
function! s:SetFunctionKey(name, code)
	execute "set " .. a:name .. "=\e" .. a:code
endfunction
if has('nvim') == 0 && has('gui_running') == 0
	call s:SetFunctionKey('<F1>', 'OP')
	call s:SetFunctionKey('<F2>', 'OQ')
	call s:SetFunctionKey('<F3>', 'OR')
	call s:SetFunctionKey('<F4>', 'OS')
	call s:SetFunctionKey('<S-F1>', '[1;2P')
	call s:SetFunctionKey('<S-F2>', '[1;2Q')
	call s:SetFunctionKey('<S-F3>', '[1;2R')
	call s:SetFunctionKey('<S-F4>', '[1;2S')
	call s:SetFunctionKey('<S-F5>', '[15;2~')
	call s:SetFunctionKey('<S-F6>', '[17;2~')
	call s:SetFunctionKey('<S-F7>', '[18;2~')
	call s:SetFunctionKey('<S-F8>', '[19;2~')
	call s:SetFunctionKey('<S-F9>', '[20;2~')
	call s:SetFunctionKey('<S-F10>', '[21;2~')
	call s:SetFunctionKey('<S-F11>', '[23;2~')
	call s:SetFunctionKey('<S-F12>', '[24;2~')
endif
" }}}

" cursor moving {{{
" move in insert mode.
inoremap <C-a> <home>
inoremap <C-e> <end>

" move in command mode.
cnoremap <C-h> <left>
cnoremap <C-j> <down>
cnoremap <C-k> <up>
cnoremap <C-l> <right>
cnoremap <C-a> <home>
cnoremap <C-e> <end>

" move between windows.
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
" }}}

" terminal
if has('nvim')
	tnoremap <esc><esc> <C-\><C-n>
elseif has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
	set termwinkey=<C-_>
	tnoremap <esc><esc> <C-\><C-n>
endif

let s:GenOption = function('imodule#option#gen')
let s:GetOption = function('imodule#option#get')
let s:Toggle = function('imodule#option#toggle')
let s:Group = function('imodule#keymap#add_group')
let s:Desc = function('imodule#keymap#add_desc')

" resize window {{{
" increase window height
nnoremap <C-up> <Cmd>resize +2<CR>
" decrease window height
nnoremap <C-down> <Cmd>resize -2<CR>
" decrease window width
nnoremap <C-left> <Cmd>vertical resize -2<CR>
" increase window width
nnoremap <C-right> <Cmd>vertical resize +2<CR>
" }}}

" move lines {{{
" move down
nnoremap <M-J> <Cmd>exec 'move .+'.v:count1<CR>==
" move up
nnoremap <M-K> <Cmd>exec 'move .-'.(v:count1 + 1)<CR>==
inoremap <M-J> <Esc><Cmd>m .+1<CR>==gi
inoremap <M-K> <Esc><Cmd>m .-2<CR>==gi
vnoremap <M-J> :<C-u>exec "'<,'>move '>+".v:count1<CR>gv=gv
vnoremap <M-K> :<C-u>exec "'<,'>move '<-".(v:count1 + 1)<CR>gv=gv
" }}}

" buffers {{{
" prev buffer
nnoremap <S-h> <Cmd>bprevious<CR>
" next buffer
nnoremap <S-l> <Cmd>bnext<CR>
nnoremap [b <Cmd>bprevious<CR>
nnoremap ]b <Cmd>bnext<CR>

call s:Group('<leader>b', 'buffer')
" switch to other buffer
nnoremap <leader>bb <Cmd>e #<CR>
call s:Desc('<leader>bb', 'Switch to Other Buffer')

" delete buffer
nnoremap <leader>bd <Cmd>call imodule#ui#buf_delete()<CR>
call s:Desc('<leader>bd', 'Delete Buffer')
" delete other buffers
nnoremap <leader>bo <Cmd>call imodule#ui#buf_delete_other()<CR>
call s:Desc('<leader>bo', 'Delete Other Buffers')
" delete buffer and window
nnoremap <leader>bD <cmd>:bd<cr>
call s:Desc('<leader>bD', 'Delete Buffer & Window')
" }}}

" clear search on escape
nnoremap <Esc> <Esc><Cmd>nohlsearch<CR>
call s:Group('<leader>u', 'ui')
" clear search, diff update and redraw, taken from runtime/lua/_editor.lua
nnoremap <leader>ur <Cmd>noh<bar>diffupdate<bar>normal! <C-l><CR>
call s:Desc('<leader>ur', 'Clear Hlsearch / Diff Update / Redraw')

" next search result {{{
" https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
nnoremap <expr> n 'Nn'[v:searchforward].'zv'
xnoremap <expr> n 'Nn'[v:searchforward]
onoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward].'zv'
xnoremap <expr> N 'nN'[v:searchforward]
onoremap <expr> N 'nN'[v:searchforward]
" }}}

" add undo break-points
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ; ;<C-g>u

" save file
nnoremap <C-s> <Cmd>update<CR>
inoremap <C-s> <Cmd>update<CR>

" keywordprg
nnoremap <silent> <leader>K <Cmd>norm! K<CR>

" better indenting
vnoremap < <gv
vnoremap > >gv

" new file
call s:Group('<leader>f', 'file')
nnoremap <leader>fn <Cmd>enew<CR>
call s:Desc('<leader>fn', 'New File')

" {{{ location list/ quickfix list
call s:Group('<leader>x', 'location')
" location list
function! s:ToggleLocList() abort
  let ll = getloclist(bufnr('%'))
	if len(ll) == 0
		call ilib#ui#warn('location list is empty')
    lclose
	else
		lopen
	endif
endfunc
nnoremap <leader>xl <Cmd>call <SID>ToggleLocList()<CR>
call s:Desc('<leader>xl', 'Toggle Location List')

call s:Group('<leader>x', 'quickfix')
" quickfix list
function! s:ToggleQfList() abort
  let qf = getqflist({'bufnr': bufnr('%')})
	if len(qf) == 0
		call ilib#ui#warn('quickfix list is empty')
		cclose
	else
		copen
	endif
endfunc
nnoremap <leader>xq <Cmd>call <SID>ToggleQfList()<CR>
call s:Desc('<leader>xq', 'Toggle QuickFix List')

" previous quickfix
nnoremap [q <Cmd>cprev<CR>
" next quickfix
nnoremap ]q <Cmd>cnext<CR>
" }}}

" {{{ option
call s:Group('<leader>u', 'option')
call s:GenOption('spell')
nnoremap <leader>us <Cmd>call <SID>GetOption('spell')-><SID>Toggle()<CR>
call s:Desc('<leader>us', 'Toggle Spell')

call s:GenOption('wrap')
nnoremap <leader>uw <Cmd>call <SID>GetOption('wrap')-><SID>Toggle()<CR>
call s:Desc('<leader>uw', 'Toggle Wrap')

call s:GenOption('relativenumber')
nnoremap <leader>uL <Cmd>call <SID>GetOption('relativenumber')->
      \<SID>Toggle()<CR>
call s:Desc('<leader>uL', 'Toggle Relative Line No')

function! s:SetLineNo(enable)
  let b:ivim_rnu = get(b:, 'ivim_rnu', &relativenumber)
  if !a:enable
    let b:ivim_rnu = &relativenumber
    setlocal norelativenumber
  else
    exec 'setlocal '.(b:ivim_rnu ? '' : 'no').'relativenumber'
  endif
  setlocal number!
endfunc
call s:GenOption('number', {'set': function('s:SetLineNo')})
nnoremap <leader>ul <Cmd>call <SID>GetOption('number')-><SID>Toggle()<CR>
call s:Desc('<leader>ul', 'Toggle Line No')

call s:GenOption('conceallevel', {'on': &cole > 0 ? &cole : 2, 'off': 0})
nnoremap <leader>uc <Cmd>call <SID>GetOption('conceallevel')-><SID>Toggle()<CR>
call s:Desc('<leader>uc', 'Toggle Conceal Lv')
" }}}

nnoremap Q <Cmd>qa<CR>

" windows {{{
nnoremap <leader>- <C-w>s
call s:Desc('<leader>-', 'Split Window Below')
nnoremap <leader><bar> <C-w>v
call s:Desc('<leader>|', 'Split Window Right')
nnoremap <leader>wd <C-w>c
call s:Group('<leader>w', 'window')
call s:Desc('<leader>wd', 'Close Window')

" toggle window maximize {{{
" https://github.com/szw/vim-maximizer/blob/master/plugin/maximizer.vim
func! s:MaximizeWin()
  let t:ivim_restore_win = {'before': winrestcmd()}
  vert resize | resize
  let t:ivim_restore_win.after = winrestcmd()
  normal! ze
endfunc
func! s:RestoreWin()
  if exists('t:ivim_restore_win')
    silent! exec t:ivim_restore_win.before
    if t:ivim_restore_win.before != winrestcmd()
      exec "wincmd ="
    endif
    unlet t:ivim_restore_win
    normal! ze
  endif
endfunc
func! s:ToggleWinMax()
  if exists('t:ivim_restore_win') && t:ivim_restore_win.after == winrestcmd()
    call s:RestoreWin()
  elseif winnr('$') > 1
    call s:MaximizeWin()
  endif
endfunc
nnoremap <leader>um <Cmd>call <SID>ToggleWinMax()<CR>
call s:Desc('<leader>um', 'Toggle Win Maximize')
augroup ivim_restore_maximize_win_on_winleave
  au!
  au WinLeave * call s:RestoreWin()
augroup END
" }}}

" }}}

" tabs {{{
" vim-which-key only recognize <Tab>, no <tab>
call s:Group('<leader><Tab>', 'tab')
nnoremap <leader><Tab>f <Cmd>tabfirst<CR>
call s:Desc('<leader><Tab>f', 'First Tab')
nnoremap <leader><Tab>l <Cmd>tablast<CR>
call s:Desc('<leader><Tab>l', 'Last Tab')
nnoremap <leader><Tab>o <Cmd>tabonly<CR>
call s:Desc('<leader><Tab>o', 'Close Other Tabs')
nnoremap <leader><Tab>n <Cmd>tabnew<CR>
call s:Desc('<leader><Tab>n', 'New Tab')
nnoremap <leader><Tab>d <Cmd>tabclose<CR>
call s:Desc('<leader><Tab>d', 'Close Tab')
nnoremap [<Tab> <Cmd>tabprevious<CR>
call s:Desc('[<Tab>', 'Prev Tab')
nnoremap ]<Tab> <Cmd>tabnext<CR>
call s:Desc(']<Tab>', 'Next Tab')
" }}}

" {{{ scroll popup window
" https://vi.stackexchange.com/a/21927
nnoremap <expr> <C-F> <SID>scroll_cursor_popup(1) ? '<esc>' : '<C-F>'
nnoremap <expr> <C-B> <SID>scroll_cursor_popup(0) ? '<esc>' : '<C-B>'
function! s:find_cursor_popup(...)
  let radius = get(a:000, 0, 2)
  let srow = screenrow()
  let scol = screencol()

  " it's necessary to test entire rect, as some popup might be quite small
  for r in range(srow - radius, srow + radius)
    for c in range(scol - radius, scol + radius)
      let winid = popup_locate(r, c)
      if winid != 0
        return winid
      endif
    endfor
  endfor

  return 0
endfunction

function! s:scroll_cursor_popup(down)
  let winid = s:find_cursor_popup()
  if winid == 0
    return 0
  endif

  let pp = popup_getpos(winid)
  call popup_setoptions( winid,
        \ {'firstline' : pp.firstline + ( a:down ? 4 : -4 ) } )

  return 1
endfunction
" }}}
