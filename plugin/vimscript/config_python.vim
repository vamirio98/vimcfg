vim9script noclear

if exists('g:config_python_loaded')
	finish
endif
g:config_python_loaded = 1

if !has('python3')
	echohl Error
	echomsg 'Vimcfg requires Vim compiled with python3.'
	echohl None
	finish
endif

if !exists('g:vimcfg_py')
	g:vimcfg_py = 'py3'
endif

execute g:vimcfg_py 'import vim, sys, os, re'
execute g:vimcfg_py 'cwd = vim.eval(''expand("<sfile>:p:h")'')'
execute g:vimcfg_py 'cwd = re.sub(r"(?<=^.)", ":", os.sep.join(cwd.split("/")[1:])) if os.name == "nt" and cwd.startswith("/") else cwd'
execute g:vimcfg_py 'sys.path.insert(0, os.path.join(cwd, "..", "python"))'
execute g:vimcfg_py 'import vimcfg'

def g:ExePy(cmd: string): void
	exe g:vimcfg_py cmd
enddef
