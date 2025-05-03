vim9script

import autoload "../ilib/ui.vim" as iui

type GetFunc = func(): bool
type SetFunc = func(any): void
type ToggleFunc = func(): void

export class Option
  var Get: GetFunc = null_function
  var Set: SetFunc = null_function
  var on: any = null
  var off: any = null
  var Toggle: ToggleFunc = null_function

  static def _GenGet(name: string): GetFunc
    return (): bool => eval('&' .. name)
  enddef

  static def _GenSet(name: string): SetFunc
    return (on: bool): void => {
      exec 'setlocal' (on ? '' : 'no') .. name
    }
  enddef

  static def _GenToggle(name: string, opt: Option): ToggleFunc
    return (): void => {
      if opt.on == null
        opt.Set(!opt.Get())
        iui.Info((opt.Get() ? 'enable ' : 'disable ') .. name)
      else
        exec 'setlocal' name .. '=' .. (opt.Get() == opt.on ? opt.off : opt.on)
        iui.Info('set ' .. name .. ' = ' .. opt.Get())
      endif
    }
  enddef

  def new(name: string, this.Get = v:none, this.Set = v:none,
      this.on = v:none, this.off = v:none)
    if this.Get == null
      this.Get = _GenGet(name)
    endif
    if this.Set == null
      this.Set = _GenSet(name)
    endif
    this.Toggle = _GenToggle(name, this)
  enddef

  def newOnOff(name: string, this.on, this.off)
    Option.new(name, v:none, v:none, this.on, this.off)
  enddef
endclass
