if line('$') == 1 && getline(1) == ''
	call setline(1, '#!/bin/bash')
	call setline(2, '')

	execute 'normal G'
	execute 'startinsert!'
endif
