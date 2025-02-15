return {
  {
    "folke/lazydev.nvim",
    opts = function(_, opts)
      table.insert(opts.library, { path = vim.g.vimcfg_home, words = { "vimcfg" } })
    end,
  },
}
