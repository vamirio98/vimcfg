vim9script

import autoload "../lib/platform.vim" as platform

export class Term
  var bufnr: number

  var shell: string
  var autoclose: bool
  var width: any
  var height: any
  var title: string  # TODO: string or func(?): string
  var title_pos: string
  var win_type: string
  var win_pos: string
  var borderchars: list<string>

  def new(option: dict<any> = null_dict)
    var opt: dict<any> = option == null ? deepcopy(option) : {}

    # TODO: check type
    this.shell = get(opt, 'shell', g:ivim_term_shell)
    this.autoclose = get(opt, 'autoclose', g:ivim_term_autoclose)
    this.width = get(opt, 'width', g:ivim_term_width)
    this.height = get(opt, 'height', g:ivim_term_height)
    this.title = get(opt, 'title', 'term')
    this.title_pos = get(opt, 'win_type', g:ivim_term_win_type)
    this.win_type = get(opt, 'win_type', g:ivim_term_win_type)
    this.win_pos = get(opt, 'win_pos', g:ivim_term_win_pos)
    this.borderchars = get(opt, 'borderchars', g:ivim_term_borderchars)
  enddef

  def Start(): number
    this.bufnr = term_start(this.shell, {})
    return this.bufnr
  enddef
endclass
