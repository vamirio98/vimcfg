-- Detect dir ~/.cache/tags, create new one if it doesn't exist.
local tag_cache_dir = vim.fn.expand("~/.cache/tags")
if vim.fn.isdirectory(tag_cache_dir) == 0 then
  vim.fn.mkdir(tag_cache_dir, "p")
end

return {
  {
    "skywind3000/vim-gutentags",
    init = function()
      -- Set root dir of a project.
      vim.g.gutentags_project_root = { ".root", ".svn", ".git", ".project" }

      -- Set ctags file name.
      vim.g.gutentags_ctas_tagfile = ".tags"

      -- Set dir to save the tag file.
      vim.g.gutentags_cache_dir = tag_cache_dir

      -- Use a ctags-compatible program to generate a tags file and
      -- GNU's gtags to generate a code database file.
      local modules = {}
      if vim.fn.executable("ctags") == 1 then
        table.insert(modules, "ctags")
      end
      if vim.fn.executable("gtags-cscope") == 1 and vim.fn.executable("gtags") == 1 then
        table.insert(modules, "gtags_cscope")
      end
      vim.g.gutentags_modules = modules

      -- Set ctags arguments.
      local ctags_extra_args = { "--fields=+niazS", "--extra=+q" }
      table.insert(ctags_extra_args, "--c++-kinds=+px")
      table.insert(ctags_extra_args, "--c-kinds=+px")
      -- Use universal-ctags.
      table.insert(ctags_extra_args, "--output-format=e-ctags")
      vim.g.gutentags_ctags_extra_args = ctags_extra_args

      -- Config gutentags whitelist.
      vim.g.gutentags_exclude_filetypes = { "text" }

      -- Prevent gutentags from autoloading gtags database.
      vim.g.gutentags_auto_add_gtags_cscope = 0

      vim.g.gutentags_cscope_build_inverted_index_maps = 1
    end,
  },

  {
    "skywind3000/gutentags_plus",
    init = function()
      -- To debug, do the following step (https://github.com/skywind3000/gutentags_plus, README.md):
      -- 1. uncomment these two statements:
      -- vim.g.gutentags_trace = 1
      -- vim.g.gutentags_define_advanced_commands = 1
      -- 2. restart vim, open some files and generate gtags again with current project:
      -- `:GutentagsUpdate`
      -- 3. you may see a lot of gutentags logs, after that:
      -- `message`

      -- Disable default keymaps
      vim.g.gutentags_plus_nomap = 1

      -- Change focus to quickfix window after search.
      vim.g.gutentags_plus_switch = 0

      local keyset = function(lhs, rhs, name)
        local opts = { silent = true }
        opts.desc = name
        vim.keymap.set("n", lhs, rhs, opts)
      end

      keyset("<leader>cgs", "<Plug>GscopeFindSymbol", "Find Symbol")
      keyset("<leader>cgg", "<Plug>GscopeFindDefinition", "Find Definition")
      keyset("<leader>cgc", "<Plug>GscopeFindCallingFunc", "Find CallingFunc")
      keyset("<leader>cgt", "<Plug>GscopeFindText", "Find Text")
      keyset("<leader>cge", "<Plug>GscopeFindEgrep", "Find Egrep")
      keyset("<leader>cgf", "<Plug>GscopeFindFile", "Find File")
      keyset("<leader>cgi", "<Plug>GscopeFindInclude", "Find Include")
      keyset("<leader>cgd", "<Plug>GscopeFindCalledFunc", "Find CalledFunc")
      keyset("<leader>cga", "<Plug>GscopeFindAssign", "Find Assign")
      keyset("<leader>cgz", "<Plug>GscopeFindCtag", "Find Ctag")
      keyset("<leader>cgk", ":GscopeKill<cr>", "Kill All Cscope")
    end,
  },

  -- jumpout brackets
  {
    "abecodes/tabout.nvim",
    opts = {
      tabkey = "",
      backwards_tabkey = "",
    },
    keys = {
      { "<M-n>", "<Plug>(TaboutMulti)", mode = "i" },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    version = "*",
    keys = {
      {
        "<C-j>",
        function()
          if require("luasnip").expandable() then
            require("luasnip").expand()
          end
        end,
        mode = "i",
      },
    },
    dependencies = {
      {
        "honza/vim-snippets",
        config = function()
          require("luasnip.loaders.from_snipmate").lazy_load()
          -- load local snippets
          require("luasnip.loaders.from_snipmate").lazy_load({
            paths = { vim.g.vimcfg_home .. "/snippets", vim.fn.stdpath("config") .. "/snippets" },
          })
        end,
      },
    },
    init = function()
      -- <C-g> changes to VISUAL, s clears and enter INSERT,
      -- see https://github.com/L3MON4D3/LuaSnip/issues/499 for more detail
      vim.keymap.set("s", "<bs>", "<C-g>s")
    end,
  },

  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },

  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.keymap.preset = "default"
    end,
  },

  {
    "axelf4/vim-strip-trailing-whitespace",
  },
}
