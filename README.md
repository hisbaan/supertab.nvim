<p align="center">
  <h2 align="center">supertab.nvim</h2>
</p>

<p align="center" style="text-decoration: none; border: none;">
  <a href="https://github.com/saghen/blink.cmp/stargazers" style="text-decoration: none">
    <img alt="Stars" src="https://img.shields.io/github/stars/hisbaan/supertab.nvim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41"></a>
  <a href="https://github.com/saghen/blink.cmp/issues" style="text-decoration: none">
    <img alt="Issues" src="https://img.shields.io/github/issues/hisbaan/supertab.nvim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41"></a>
  <a href="https://github.com/saghen/blink.cmp/contributors" style="text-decoration: none">
    <img alt="Contributors" src="https://img.shields.io/github/contributors/hisbaan/supertab.nvim?color=%23DDB6F2&label=CONTRIBUTORS&logo=git&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41"></a>
</p>

**supertab.nvim** is a neovim plugin for overloading keys with multiple actions. It aims to be easily configurable to avoid the headache of conflicting mappings and configuring supertab functionality manually.

## Features

- Overloading mappings for multiple actions on arbitrary keys.
- Sane default configuration with support for [`luasnip`](https://github.com/L3MON4D3/LuaSnip), [`supermaven`](https://github.com/supermaven-inc/supermaven-nvim), and more!
- Light weight

## Installation

Install with your preferred plugin manager. Here's an example for [`lazy.nvim`](https://github.com/folke/lazy.nvim):

```lua
return {
  "hisbaan/supertab.nvim",
  dependencies = {
    -- optional dependencies for the default configuration
    "L3MON4D3/LuaSnip",
    "supermaven-inc/supermaven-nvim"
  },
  keys = {
    -- mapping for the default configuration
    { "<Tab>", function() require("supertab").trigger("<Tab>") end, mode = "i", desc = "Supertab" }
  },
  --- @module 'supertab'
  --- @type supertab.Config
  opts = {}
}
```

## Configuration

The following is an example of my personal configuration:

```lua
return {
  "hisbaan/supertab.nvim",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "supermaven-inc/supermaven-nvim"
  },
  lazy = false,
  keys = {
    { "<Tab>", function() require("supertab").trigger("<Tab>") end, mode = "i", desc = "Supertab" }
  },
  --- @module 'supertab'
  --- @type fun():supertab.Config
  opts = function()
    local luasnip = require('luasnip')
    local supermaven = require('supermaven-nvim.completion_preview')

    return {
      keys = {
        ['<Tab>'] = {
          {
            condition = function()
              return luasnip.expand_or_jumpable()
            end,
            action = function()
              luasnip.expand_or_jump()
            end
          },
          {
            condition = function()
              return supermaven.has_suggestion()
            end,
            action = function()
              supermaven.on_accept_suggestion()
            end,
          }
        }
      }
    }
  end
}
```
