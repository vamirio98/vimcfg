-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

_G.vimcfg = require("vimcfg")

vim.g.root_spec = { { ".git", ".root", ".svn", ".project" }, "lsp", "cwd" }
vim.g.ai_cmp = false

local opt = vim.opt

opt.background = "light"
