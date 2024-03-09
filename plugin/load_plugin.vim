vim9script noclear

if exists('g:load_plugin_loaded')
	finish
endif
g:load_plugin_loaded = 1

# Get the directory where this file is located.
var cwd = fnamemodify(resolve(expand('<sfile>:p')), ':h')

# Define a command to load the file.
command -nargs=1 LoadPluginScript execute 'source ' .. cwd ..
			\ '/vimscript/' .. '<args>'

# All .vim files under this directory and its subdirectory will be loaded
# automatically, these commands used to specified the order they are loaded.
LoadPluginScript diff_orig.vim
LoadPluginScript restore_view.vim

# Should be loaded before any scripts use python loaded.
LoadPluginScript config_python.vim

LoadPluginScript clean_view.vim
