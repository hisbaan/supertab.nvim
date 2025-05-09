--- @class (exact) supertab.ConfigStrict
--- @field keys supertab.Keys list of keys and their corresponding triggers/actions lists

--- @class supertab.Config : supertab.ConfigStrict
--- @field keys supertab.Keys list of keys and their corresponding triggers/actions lists

--- @alias (exact) supertab.Keys table<string, supertab.TriggerActionItem[]> A list of keys and their corresponding triggers/actions lists

--- @class (exact) supertab.TriggerActionItem
--- @field condition fun(): boolean A function that returns true if the action should be triggered.
--- @field action fun() A function to be executed if the trigger returns true.

--- @type supertab.ConfigStrict
local config = {
  keys = {
    -- TODO setup some sane defaults with popular plugins
    -- use pcall to ensure it works if the user doesn't include the plugin
    ["<Tab>"] = {
      {
        condition = function() return true end,
        action = function() end,
      },
    },
    ["<S-Tab>"] = {
      condition = function() return true end,
      action = function() end,
    },
  },
}

local M = {}

--- @param user_config supertab.Config
function M.merge_with(user_config)
  config = vim.tbl_deep_extend('force', config, user_config)
end

--- @type supertab.ConfigStrict
return setmetatable(M, {
  __index = function(_, k) return config[k] end,
})
