"==============================================================
" add map through vim-which-key or which-key.nvim
"==============================================================

" {{{  ensure which-key
let s:has_wk = 0

if !has('nvim')
	if imodule#plug#has('vim-which-key')
    let s:has_wk = 1
	endif
else
	lua << END
	ok, error = pcall(require, 'which-key')
	vim.g['imodule#keymap#has_wk'] = ok and 1 or 0
END
endif

if !s:has_wk
	call lib#ui#error('has no which-key plugin')
  finish
endif  " }}}

" {{{ global variable
let g:imodule#keymap#desc = {'n': {}, 'v': {}}
let s:desc = g:imodule#keymap#desc
let s:NEED_ESCAPE_CHAR = ['''']
let s:WHICH_KEY = {
      \ '<leader>': g:mapleader,
      \ '<localleader>': g:maplocalleader,
      \ '<esc>': '<Esc>',
      \ '<tab>': '<Tab>',
      \ '<cr>': '<CR>',
      \ '<del>': '<Del>',
      \ '<bs>': '<BS>',
      \ '<space>': '<Space>'
      \ }
" }}}

"--------------------------------------------------------------
" split keys string to key list
"--------------------------------------------------------------
function! s:Split(keys)
	let key_seq = a:keys
	let keys = []
	let in_key = 0

	let i = 0
	while i < len(key_seq)
		let c = key_seq[i]
		if c == '<' && match(key_seq, '<[^<]\{-}>', i) == i
			let j = stridx(key_seq, '>', i + 1)
			let keys += [key_seq[i : j]]
			let i = j + 1
		else
			let keys += [c]
			let i = i + 1
		endif
	endwhile

	return keys
endfunc

"function! s:TestSplit()
"	echom s:Split("ab")
"	echom s:Split("<tab><space>abc")
"	echom s:Split("<tab>abc<space>abc")
"	echom s:Split("abc<tab>abc<space>")
"	echom s:Split("abc<tababc<space>")
"	echom s:Split("abc<tab>space>")
"	echom s:Split("abc<sp")
"	echom s:Split("abc>sp")
"	echom s:Split("abc>s>p")
"	echom s:Split("abc<s<p")
"	echom s:Split("abc<<p")
"	echom s:Split("abc>>p")
"endfunc
"call s:TestSplit()

function! s:GenDict(mode, keys) abort
  let dict = 'g:imodule#keymap#desc["'.a:mode.'"]'
  for k in a:keys
    if !eval(printf('has_key(%s, "%s")', dict, k))
      exec printf("let %s['%s'] = {}", dict, k)
    endif
    let dict .= "['".k."']"
  endfor
  return dict
endfunc

" imodule#keymap#add_group({keys}, {group} [, {mode}, {overwrite}])
function! imodule#keymap#add_group(keys, group, ...) abort
  let keys = s:Split(a:keys)
  if len(a:keys) == 0
    call lib#ui#error('{keys} should not be empty')
    return
  endif

  let mode = get(a:000, 0, 'n')
  let overwrite = get(a:000, 1, 0)
  let desc = s:GenDict(mode, keys)
  if !eval('has_key('.desc.', "name")') || overwrite
    exec printf("let %s.name = '%s'", desc,
          \ empty(a:group) ? 'which_key_ignore' : '+'.a:group)
  else
    let groups = eval('split('.desc.'.name, "[\+/]")')
    for g in groups
      if g ==? a:group
        return
      endif
    endfor
    exec printf("let %s.name .= '%s'", desc, empty(a:group) ? '' : '/'.a:group)
  endif
endfunc

function! imodule#keymap#add_desc(keys, desc, ...) abort
  let keys = s:Split(a:keys)
  if len(a:keys) == 0
    call lib#ui#error('{keys} should not be empty')
    return
  endif

  let mode = get(a:000, 0, 'n')
  let desc = s:GenDict(mode, keys)
  exec printf("let %s = '%s'", desc, empty(a:desc) ? 'which_key_ignore' : a:desc)
endfunc

function! s:RegisterWhichKey()
  for mode in keys(g:imodule#keymap#desc)
    for k in keys(s:desc[mode])
      let which_key = get(s:WHICH_KEY, k, k)
      call which_key#register(which_key, g:imodule#keymap#desc[mode][k], mode)
      exec printf("%snoremap <silent> %s :<C-u>WhichKey%s '%s'<CR>",
            \ mode, k, (mode ==? 'n' ? '' : 'Visual'), which_key)
    endfor
  endfor
endfunc
augroup ivim_imodule_keymap
  au!
  au VimEnter * call s:RegisterWhichKey()
augroup END
