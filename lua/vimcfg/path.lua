---@class vimcfg.path
local M = {}

--- Transfer `path` to unix format
---@param path string
---@return string
function M.to_unix(path)
  if not path then
    return ""
  end
  path = path:gsub("\\", "/"):gsub("/+", "/")
  return path:sub(-1) == "/" and path:sub(1, -2) or path
end

--- Transfer `path` to windows format
---@param path string
---@return string
function M.to_win(path)
  if not path then
    return ""
  end
  path = path:gsub("/+", "/"):gsub("/", "\\")
  return path:sub(-1) == "\\" and path:sub(1, -2) or path
end

---@param path string?
---@return string
function M.abspath(path)
  if path == nil or path == "" then
    return ""
  end
  path = vim.fn.expand(path)
  path = vim.uv.fs_realpath(path)
  return path or ""
end

--- Get the full absolute path of `buf`
---@param buf number|nil Buffer handle
---@return string
function M.bufpath(buf)
  buf = buf or 0
  return M.abspath(vim.api.nvim_buf_get_name(buf))
end

return M
