"-
" extended.vim - Extended config.
"
" Created by vamirio on 2021 Nov 08
"-

if $TMUX != ''
	set ttimeoutlen=30
elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
	set ttimeoutlen=80
endif

" Use ALT in terminal, should set ttimeout (in basic.vim) and ttimeoutlen at
" first.
" Refer: http://www.skywind.me/blog/archives/2021
if has('nvim') == 0 && has('gui_running') == 0
	function! s:metacode(key)
		execute "set <M-" . a:key . ">=\e" . a:key
	endfunction
	for i in range(10)
		call s:metacode(nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		call s:metacode(nr2char(char2nr('a') + i))
		call s:metacode(nr2char(char2nr('A') + i))
	endfor
	for c in [',', '.', '/', ';', '{', '}']
		call s:metacode(c)
	endfor
	for c in ['?', ':', '-', '_', '+', '=', "'"]
		call s:metacode(c)
	endfor
endif

" Use function key in terminal.
function! s:SetFunctionKey(name, code)
	if has('nvim') == 0 && has('gui_running') == 0
		execute "set " . a:name . "=\e" . a:code
	endif
endfunction
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

" Prevent the backgroud color of Vim in tmux from displaying abnormally.
" Refer: http://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color' && $TMUX != ''
	" Disable background color erase (BCE) so that color schemes render
	" properly when inside 256-color tmux and GNU screen.
	set t_ut=
endif

" Backup.
if has('unix')
	let s:tmp_dir = expand('~/.vim/tmp')
elseif has('win32')
	let s:tmp_dir = expand('~/vimfiles/tmp')
endif
if isdirectory(s:tmp_dir) == 0
	call mkdir(s:tmp_dir, "p", 0755)
endif

" Allow backup.
set backup
" Backup when saving.
set writebackup
execute "set backupdir=" . s:tmp_dir
" Backup file extension.
set backupext=.bak
" Disable swap file.
set noswapfile
" Disable undofile.
set noundofile

function s:ReturnLastPos()
	let last_pos = [line("'\""), col("'\"")]
	if last_pos[0] > 1 && last_pos[1] <= line("$") && &ft !~# 'commit'
		call cursor(last_pos)
	endif
endfunction

" Jump to the last position when reopening a file and auto load change.
set autoread
augroup MyExtendedGroup
	au!
	au BufReadPost * call s:ReturnLastPos()
	" Trigger autoread when cursor stop moving, buffer change or terminal focus.
	au CursorHold,CursorHoldI,BufEnter,FocusGained *
			\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
			\ | checktime | endif
	" Notification after file change
	au FileChangedShellPost * echohl WarningMsg
			\ | echo "File changed on disk. Buffer reloaded."
			\ | echohl None
augroup END

" Define a command to show diff.
if !exists(":DiffOrigin")
	command DiffOrigin vert new | set buftype=nofile | r ++edit # | 0d_
			\ | diffthis | wincmd p | diffthis
endif
