function! imodule#ui#buf_delete(...)
	let btarget = a:0 > 0 ? a:1 : bufnr('%')

	if &modified
		let choice = confirm(printf('Save changes to %s', bufname(btarget)),
					\ '&Yes\n&No\n&Cancel')
		if choice == 0 || choice == 3 " 0 for <Esc>/<C-c> and 3 for Cancel
			return
		endif
		if choice == 1 " Yes
			update
		endif
	endif

	let wins = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
	let curr_win = winnr()
	for w in wins
		" locate to the aim window
		exec w . 'wincmd w'
		" try using alternate buffer or previous buffer
		let alt = bufnr('#')
		if alt > 0 && buflisted(alt) && alt != btarget
			buffer #
		else
			try
				bprevious
			catch /E85: There is no listed buffer/
				" do nothing
			endtry
		endif

		if btarget == bufnr('%')
			" numbers of listed buffers which are not the target to be deleted
			let blisted = filter(range(1, bufnr('$')),
						\ 'buflisted(v:val) && v:val != btarget')
			" listed, not taget and not displayed
			let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
			" take the first buffer, if any (could be more intelligent)
			let bjump = (bhidden + blisted + [-1])[0]
			if bjump > 0
				exec 'buffer ' . bjump
			else
				exec 'enew '
			endif
		endif
	endfor

	exec 'bdelete! ' . btarget
	exec curr_win . 'wincmd w'
endfunc

function imodule#ui#buf_delete_other()
	let bufs = execute('ls')
	let curbuf = bufnr('%')
	for bufline in split(bufs, '\n')
		let buf = split(bufline, ' ')[0]
		if buf != curbuf
			call imodule#ui#buf_delete(buf + 0)
		endif
	endfor
endfunc
