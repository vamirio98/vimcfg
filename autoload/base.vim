vim9script
#-
# base.vim - Some base functions.
#
# Created by vamirio on 2021 Oct 14
#-

# Add file header.
export def AddFileHead(head: string, suffix: string,
		tail: string, line: number): void
	setline(line, head)
	cursor(line, 0)
	append(line, suffix .. ' ' .. expand('%:t'))
	append(line + 1, suffix)
	append(line + 2, suffix .. ' Created by vamirio on '
		.. strftime('%Y %b %d'))
	append(line + 3, tail)
	execute 'normal! j'
	execute 'startinsert!'
enddef
defcompile

def RestoreMode(mode: string)
	if mode ==? 'i'
		startinsert!
	endif
enddef
defcompile

# Jump to comment.
export def JumpOutComment(mode: string, dir: string, id: string): void
	var curPos = getcurpos()[1 : 2]
	cursor(curPos[0], dir ==# '' ? 1000 : 1)
	var nextLine = search(id, dir .. 'cn')
	if nextLine == 0 || (dir ==# '' && curPos[0] > nextLine)
			|| (dir ==# 'b' && curPos[0] < nextLine)
		cursor(curPos)
		RestoreMode(mode)
		return
	endif

	call cursor(nextLine, 1000)
	call RestoreMode(mode)
enddef
defcompile
