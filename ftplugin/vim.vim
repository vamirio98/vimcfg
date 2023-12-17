vim9script

if line('$') == 1 && getline(1) == ''
	setline(1, 'vim9script')
	setline(2, '')
	execute ':2'
	execute 'startinsert!'
endif
