return {
  {
    "tpope/vim-fugitive",
  },

  {
    "voldikss/vim-floaterm",
    init = function()
      if vimcfg.is_win() then
        vim.g.floaterm_shell = vim.fn.executable("pwsh") and "pwsh" or "powershell"
      end

      vim.g.floaterm_borderchars = "─│─│╭╮╯╰"

      -- Close window if the job exits normally.
      vim.g.floaterm_autoclose = 1

      -- Autocmds
      local autogroup = vim.api.nvim_create_augroup("vimcfg_floaterm", { clear = true })

      -- Kill all floaterm instance when quit vim.
      vim.api.nvim_create_autocmd("QuitPre", {
        group = autogroup,
        command = "FloatermKill!",
      })

      ---@param mode string|string[]
      ---@param lhs string
      ---@param rhs string|function
      ---@param desc? string
      ---@param opts? table
      local function keyset(mode, lhs, rhs, desc, opts)
        opts = opts or { silent = true }
        opts.desc = desc or nil
        vim.keymap.set(mode, lhs, rhs, opts)
      end

			-- stylua: ignore start
			-- New terminal
			keyset("n", "<M-+>", ":FloatermNew --cwd=<root><CR>", "Open New Terminal in Project Root")
			keyset("t", "<M-+>", "<C-\\><C-n>:FloatermNew --cwd=<root><CR>", "Open New Terminal in Project Root")
			keyset("n", "<M-->", ":FloatermNew --cwd=<buffer><CR>", "Open New Terminal in Current File Directory")
			keyset("t", "<M-->", "<C-\\><C-n>:FloatermNew --cwd=<buffer><CR>", "Open New Terminal in Current File Directory")
			keyset("n", "<M-_>", ":FloatermNew --cwd=<buffer-root><CR>", "Open New Terminal in Current File's Project Root")
			keyset("t", "<M-_>", "<C-\\><C-n>:FloatermNew --cwd=<buffer-root><CR>", "Open New Terminal in Current File's Project Root")

			-- Toggle terminal
			keyset("n", "<M-=>", ":FloatermToggle<CR>", "Toggle Terminal")
			keyset("t", "<M-=>", "<C-\\><C-n>:FloatermToggle<CR>", "Toggle Terminal")

			-- Navigate terminal
			keyset("n", "<M-,>", ":FloatermPrev<CR>", "Prev Terminal")
			keyset("t", "<M-,>", "<C-\\><C-n>:FloatermPrev<CR>", "Next Terminal")
			keyset("n", "<M-.>", ":FloatermNext<CR>", "Prev Terminal")
			keyset("t", "<M-.>", "<C-\\><C-n>:FloatermNext<CR>", "Next Terminal")
      -- stylua: ignore end
    end,
  },
}
