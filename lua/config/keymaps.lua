-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
Snacks.toggle.option("expandtab", { name = "Expand Tab" }):map("<leader>ue")

local map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent or true
  vim.keymap.set(mode, lhs, rhs, opts)
end

map({ "i", "n", "s", "x" }, "<C-s>", "<cmd>update<CR><ESC>")
