if !exists('g:ilib#python#version')
	let g:ilib#python#version = 0
endif


"--------------------------------------------------------------
" detect python version
"--------------------------------------------------------------
let s:py_version = 0
let s:py_cmd = ''
let s:py_eval = ''
let s:py_file = ''
let s:py_inited = 0
let s:py_health = ''
let s:py_ensure = 0  " ensure the `vim` module has been import

if g:ilib#python#version == 0
	if has('python3')
		let s:py_version = 3
		let s:py_cmd = 'py3'
		let s:py_eval = 'py3eval'
		let s:py_file = 'py3file'
	else
		let s:py_health = 'require +python3 feature'
	endif
endif


"--------------------------------------------------------------
" variables
"--------------------------------------------------------------
let g:ilib#python#version = s:py_version
let g:ilib#python#cmd = s:py_cmd
let g:ilib#python#eval = s:py_eval
let g:ilib#python#file = s:py_file
let g:ilib#python#shell_error = 0


"--------------------------------------------------------------
" return if has '+python3'
"--------------------------------------------------------------
function! ilib#python#has_python()
	return s:py_version == 3
endfunc


"--------------------------------------------------------------
" health check
"--------------------------------------------------------------
function! ilib#python#checkhealth()
	if s:py_version == 0
		call ilib#ui#error(s:py_health)
	else
		echo 'Python' . s:py_version . ' is enabled'
	endif
	return s:py_health
endfunc


"--------------------------------------------------------------
" execute code
"--------------------------------------------------------------
function! ilib#python#exec(script)
	if s:py_version == 0
		call ilib#python#checkhealth()
	elseif type(a:script) == v:t_string
		exec s:py_cmd a:script
	elseif type(a:script) == v:t_list
		let code = join(a:script, '\n')
		exec s:py_cmd code
	endif
endfunc


"--------------------------------------------------------------
" eval script
"--------------------------------------------------------------
function! ilib#python#eval(script)
	if s:py_version == 0
		call ilib#python#checkhealth()
		return -1
	else
		if type(a:script) == v:t_string
			let code = a:script
		elseif type(a:script) == v:t_list
			let code = join(a:script, '\n')
		else
			let code = '0'
		endif
		return py3eval(code)
	endif
endfunc


"--------------------------------------------------------------
" py3file
"--------------------------------------------------------------
function! ilib#python#file(filename) abort
	if s:py_version == 0
		call ilib#python#checkhealth()
	else
		exec s:py_file . ' ' . fnameescape(a:filename)
	endif
endfunc

"--------------------------------------------------------------
" python call
"--------------------------------------------------------------
function! ilib#python#call(funcname, args)
	if s:py_version == 0
		call ilib#python#checkhealth()
		return
	endif
	if s:py_ensure == 0
		exec s:py_cmd 'import vim'
		let s:py_ensure = 1
	endif
	py3 __py_args = vim.eval('a:args')
	return py3eval(a:funcname . '(*__py_args)')
endfunc

"----------------------------------------------------------------------
" python system
"----------------------------------------------------------------------
function! ilib#python#system(cmd, ...)
	let has_input = 0
	if a:0 > 0
		if type(a:1) == type('')
			let sinput = a:1
			let has_input = 1
		elseif type(a:1) == type([])
			let sinput = join(a:1, "\n")
			let has_input = 1
		endif
	endif
	if g:ilib#core#windows == 0 || s:py_version == 0
		let text = !has_input ? system(a:cmd) : system(a:cmd, sinput)
		let g:ilib#python#shell_error = v:shell_error
		return text
	endif
	exec s:py_cmd 'import subprocess, vim'
	exec s:py_cmd '__argv = {"args": vim.eval("a:cmd")}'
	exec s:py_cmd '__argv["shell"] = True'
	exec s:py_cmd '__argv["stdout"] = subprocess.PIPE'
	exec s:py_cmd '__argv["stderr"] = subprocess.STDOUT'
	if has_input
		exec s:py_cmd '__argv["stdin"] = subprocess.PIPE'
	endif
	exec s:py_cmd '__pp = subprocess.Popen(**__argv)'
	if has_input
		exec s:py_cmd . '__si = vim.eval("sinput")'
		exec s:py_cmd . '__pp.stdin.write(__si.encode("latin1"))'
		exec s:py_cmd . '__pp.stdin.close()'
	endif
	exec s:py_cmd '__return_text = __pp.stdout.read()'
	exec s:py_cmd '__return_code = __pp.wait()'
	let g:ilib#python#shell_error = ilib#python#eval('__return_code')
	return ilib#python#eval('__return_text')
endfunc
