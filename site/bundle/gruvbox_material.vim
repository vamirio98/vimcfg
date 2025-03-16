let g:gruvbox_material_enable_italic = 1

" for better performance
let g:gruvbox_material_better_performance = 1

" set contrast
let g:gruvbox_material_background = "medium"

" highlight diagnostic virtual text
let g:gruvbox_material_diagnostic_virtual_text = "colored"

let g:gruvbox_material_enable_bold = 1

let g:gruvbox_material_visual = "reverse"

let g:gruvbox_material_ui_contrast = "high"

let g:gruvbox_material_current_word = "high contrast background"

if has('termguicolors')
  set termguicolors
endif

" {{{ update colortheme for lightline
function! s:UpdateTheme() abort
  if imodule#plug#has('lightline.vim')
    let dst_dir = ilib#path#abspath('~/.vim/autoload/lightline/colorscheme/')
    if !isdirectory(dst_dir)
      silent! call mkdir(dst_dir, 'p')
    endif

    let src = ilib#path#join(imodule#plug#plugin_dir('gruvbox-material'),
          \ 'autoload/lightline/colorscheme/gruvbox_material.vim')
    let dst = ilib#path#join(dst_dir, 'gruvbox_material.vim')
    if !filereadable(dst)
      call filecopy(src, dst)
    elseif getftime(src) > getftime(dst)
      call delete(dst, 'f')
      call filecopy(src, dst)
    endif
  endif
endfunc
call s:UpdateTheme()
"  }}}

colorscheme gruvbox-material
