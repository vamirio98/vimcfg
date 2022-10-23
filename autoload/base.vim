vim9script
#-
# base.vim - Some base functions.
#
# Created by vamirio on 2021 Oct 14
#-

# Add file header.
export def AddFileHead(commentSymbol: string, line: number): void
	setline(line, commentSymbol .. ' ' .. expand('%:t'))
	append(line, commentSymbol .. ' Author: vamirio')
	cursor(line, 1000)
	execute 'startinsert!'
enddef
defcompile
