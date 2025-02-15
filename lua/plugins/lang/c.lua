return {
  -- Syntax highlight
  {
    "bfrg/vim-c-cpp-modern",
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.clangd.cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=never",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      }
    end,
  },
}
