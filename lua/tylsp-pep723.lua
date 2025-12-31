require("tylsp-pep723.log")

local lib = require("tylsp-pep723.lib")

local M = {}

---@class TylspPep723ConfigInternal
---@field enabled boolean
---@field log_level integer

---@return TylspPep723ConfigInternal
function M.get_default_config()
  local config = {
    enabled = true,
    log_level = vim.log.levels.INFO,
  }

  return config
end

---@class TylspPep723Config
---@field enabled boolean|nil
---@field log_level integer|nil

---@param config TylspPep723Config|nil
function M.setup(config)
  config = config or {}
  local default_config = M.get_default_config()
  local final_config = vim.tbl_deep_extend("force", default_config, config)

  set_log_level(final_config.log_level)

  if vim.lsp.is_enabled("ty") then
    log("TylspPep723: 'ty' LSP is already globally enabled", vim.log.levels.WARN)
    return
  end

  lib.setup_autocmd()
end

return M
