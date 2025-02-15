vim.g.vimcfg_config_dir = vim.fn.expand("~/.config/nvim")
---@diagnostic disable-next-line
vim.g.vimcfg_data_dir = vim.fn.expand(vim.fn.stdpath("data"))
vim.g.vimcfg_plugin_dir = vim.fn.expand(vim.g.vimcfg_data_dir .. "/lazy")

local lazypath = vim.g.vimcfg_plugin_dir .. "/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  root = vim.g.vimcfg_plugin_dir, -- directory where plugins will be installed
  lockfile = vim.g.vimcfg_config_dir .. "/lazy-lock.json",
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "gruvbox-material", "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  rocks = {
    root = vim.g.vimcfg_data_dir .. "/lazy-rocks",
  },
  performance = {
    rtp = {
      -- NOTE: `paths` only accpet directory that exists and does NOT end with separator
      ---@type string[]
      paths = { vim.g.vimcfg_home }, -- add any custom paths here that you want to includes in the rtp
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  readme = {
    root = vim.g.vimcfg_data_dir .. "/lazy/readme",
  },
  state = vim.g.vimcfg_data_dir .. "/lazy/state.json",
})
