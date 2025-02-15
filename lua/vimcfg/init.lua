---@class vimcfg
---@field path vimcfg.path
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require("vimcfg." .. k)
    return t[k]
  end,
})

function M.is_win()
  return vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
end

--- Notify a message
---@param msg string | string[]
---@param level integer | nil
---@param opts table
-- Use nvim-notify
function M.notify(msg, level, opts)
  msg = type(msg) == "table" and msg or { msg }
  opts = opts or {}
  opts.title = opts.title or "Vimcfg"
  local msgstr = ""
  for i, line in ipairs(msg) do
    msgstr = msgstr .. (i == 1 and "" or "\n") .. line
  end
  vim.notify(msgstr, level, opts)
end

function M.error(msg, opts)
  M.notify(msg, vim.log.levels[string.upper("error")], opts)
end
function M.warn(msg, opts)
  M.notify(msg, vim.log.levels[string.upper("warn")], opts)
end
function M.info(msg, opts)
  M.notify(msg, vim.log.levels[string.upper("info")], opts)
end

return M
