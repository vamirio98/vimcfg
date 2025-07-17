vim9script

import autoload "../autoload/term/term.vim" as term

g:ivim_term_shell = get(g:, 'ivim_term_shell', &shell)
g:ivim_term_autoclose = get(g:, 'ivim_term_autoclose', false)
g:ivim_term_width = get(g:, 'ivim_term_width', 0.6)
g:ivim_term_height = get(g:, 'ivim_term_height', 0.4)
g:ivim_term_title_pos = get(g:, 'ivim_term_title_pos', 'left')
g:ivim_term_win_type = get(g:, 'ivim_term_win_type', 'popup')
g:ivim_term_win_pos = get(g:, 'ivim_term_win_pos', 'botright')
g:ivim_term_borderchars = get(g:, 'ivim_term_borderchars', ['─', '│', '─', '│', '╭', '╮', '╯', '╰'])

type Term = term.Term

def g:Test(): void
  var t = Term.new()
  t.Start()
enddef
