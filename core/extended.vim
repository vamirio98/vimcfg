vim9script
#-
# extended.vim - Extended config.
#
# Created by vamirio on 2021 Nov 08
#-

if $TMUX != ''
	set ttimeoutlen=30
elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
	set ttimeoutlen=80
endif

# Use ALT in terminal, should set ttimeout (in basic.vim) and ttimeoutlen at
# first.
# Refer: http://www.skywind.me/blog/archives/2021
if has('nvim') == 0 && has('gui_running') == 0
	def SetMetacode(key: string): void
		execute "set <M-" .. key .. ">=\e" .. key
	enddef
	for i in range(10)
		SetMetacode(nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		SetMetacode(nr2char(char2nr('a') + i))
		SetMetacode(nr2char(char2nr('A') + i))
	endfor
	for c in [',', '.', '/', ';', '{', '}']
		SetMetacode(c)
	endfor
	for c in ['?', ':', '-', '_', '+', '=', "'"]
		SetMetacode(c)
	endfor
endif

# Use function key in terminal.
def SetFunctionKey(name: string, code: string): void
	execute "set " .. name .. "=\e" .. code
enddef
if has('nvim') == 0 && has('gui_running') == 0
	SetFunctionKey('<F1>', 'OP')
	SetFunctionKey('<F2>', 'OQ')
	SetFunctionKey('<F3>', 'OR')
	SetFunctionKey('<F4>', 'OS')
	SetFunctionKey('<S-F1>', '[1;2P')
	SetFunctionKey('<S-F2>', '[1;2Q')
	SetFunctionKey('<S-F3>', '[1;2R')
	SetFunctionKey('<S-F4>', '[1;2S')
	SetFunctionKey('<S-F5>', '[15;2~')
	SetFunctionKey('<S-F6>', '[17;2~')
	SetFunctionKey('<S-F7>', '[18;2~')
	SetFunctionKey('<S-F8>', '[19;2~')
	SetFunctionKey('<S-F9>', '[20;2~')
	SetFunctionKey('<S-F10>', '[21;2~')
	SetFunctionKey('<S-F11>', '[23;2~')
	SetFunctionKey('<S-F12>', '[24;2~')
endif

# Prevent the backgroud color of Vim in tmux from displaying abnormally.
# Refer: http://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color' && $TMUX != ''
	# Disable background color erase (BCE) so that color schemes render
	# properly when inside 256-color tmux and GNU screen.
	set t_ut=
endif

# Backup.
var backupDir = expand('~/.cache/vim/backup')
if isdirectory(backupDir) == 0
	call mkdir(backupDir, 'p', 0755)
endif

# Allow backup.
set backup
# Backup when saving.
set writebackup
execute 'set backupdir=' .. backupDir
# Backup file extension.
set backupext=.bak
# Disable swap file.
set noswapfile
# Disable undofile.
set noundofile

def ReturnLastPos()
	var lastPos = [line("'\""), col("'\"")]
	if lastPos[0] > 1 && lastPos[1] <= line('$') && &ft !~# 'commit'
		cursor(lastPos)
	endif
enddef

# Jump to the last position when reopening a file and auto load change.
set autoread
augroup MyExtendedGroup
	au!
	au BufReadPost * ReturnLastPos()
	# Trigger autoread when cursor stop moving, buffer change or terminal focus.
	au CursorHold,CursorHoldI,BufEnter,FocusGained *
			\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
			\ | checktime | endif
	# Notification after file change
	au FileChangedShellPost * echohl WarningMsg
			\ | echo 'File changed on disk. Buffer reloaded.'
			\ | echohl None
augroup END

# Define a command to show diff.
if !exists(':DiffOrigin')
	command DiffOrigin vert new | set buftype=nofile | r ++edit # | 0d_
			\ | diffthis | wincmd p | diffthis
endif
