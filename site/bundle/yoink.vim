vim9script

import autoload "../../autoload/imodule/keymap.vim" as ikeymap
import autoload "../../autoload/imodule/plug.vim" as iplug

var AddGroup = ikeymap.AddGroup
var AddDesc = ikeymap.AddDesc

nmap <C-n> <plug>(YoinkPostPasteSwapBack)
nmap <C-p> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)

nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)
AddDesc('[y', 'Rotate Back Yank History')
AddDesc(']y', 'Rotate Forward Yank History')
