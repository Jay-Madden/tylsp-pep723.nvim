# tylsp-pep723.nvim

A VERY small plugin that adds LSP support for [pep-723](https://peps.python.org/pep-0723/) inline metadata scripts.

Use this for convenience while we wait on the resolution of https://github.com/astral-sh/ty/issues/691. If you don't want a full plugin dependency

## Requirements

* [ty](https://docs.astral.sh/ty/installation/) to be installed and available on your PATH.
* [uv](https://docs.astral.sh/uv/getting-started/installation/) to be installed and available on your PATH.

#### Lazy
```lua
return {
  "Jay-Madden/tylsp-pep723.nvim",
  event = "VeryLazy",

  config = function()
    require("tylsp-pep723").setup({})
  end
}
```

## ⚙️ Configuration

#### Defaults
```lua
require("tylsp-pep723").setup({
  -- Enable or disable the plugin
  enabled = true,

  -- Default logging level for the plugin, if the plugin does not behave as it should
  -- set this to vim.log.levels.DEBUG
  log_level = vim.log.levels.INFO
})
```
