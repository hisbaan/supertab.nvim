local M = {}

local has_setup = false
function M.setup(opts)
  if has_setup then return end
  has_setup = true

  opts = opts or {}
  local config = require('supertab.config')
  config.merge_with(opts)
end

--- Trigger the given key along with its supertab mappings
---@param key string The vim keycode of the key you want to trigger
function M.trigger(key)
  if not key then error("argument key not defined") end

  --- @type supertab.ConfigStrict
  local config = require('supertab.config')
  local key_config_rules = config.keys[key]

  if key_config_rules then
    for _, value in pairs(key_config_rules) do
      if value.condition() then
        value.action()
        return
      end
    end
  end

  local k = vim.api.nvim_replace_termcodes(key, true, false, true)
  vim.api.nvim_feedkeys(k, "n", false)
end

return M
