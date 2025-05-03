vim9script

augroup ivim_strip_trailing_whitespace
  au!
  au FileType dirvish b:strip_trailing_whitespace_enabled = 0
augrou END
