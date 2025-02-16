return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true

      -- For better performance
      vim.g.gruvbox_material_better_performance = 1

      -- Set contrast
      vim.g.gruvbox_material_background = "medium"

      -- Highlight diagnostic virtual text
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"

      vim.g.gruvbox_material_enable_bold = 1

      vim.g.gruvbox_material_visual = "reverse"

      vim.g.gruvbox_material_ui_contrast = "high"

      vim.g.gruvbox_material_current_word = "high contrast background"

      vim.cmd.colorscheme("gruvbox-material")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = "gruvbox-material"
    end,
  },

  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.preset = "classic"
      table.insert(opts.spec, { "<leader>cg", group = "tags" })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = LazyVim.config.icons

      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
      opts.sections.lualine_c[4] = { LazyVim.lualine.pretty_path({ modified_sign = " [+]" }) }
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    opts = {},
    main = "rainbow-delimiters.setup",
  },
}
