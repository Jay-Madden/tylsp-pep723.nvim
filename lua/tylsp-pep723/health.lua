local M = {}

M.check = function()
  vim.health.start("tylsp-pep723")

  -- Check for uv installation
  if vim.fn.executable("uv") == 1 then
    vim.health.ok("`uv` is installed")
  else
    vim.health.error("`uv` is not installed or not on PATH", {
      "Install uv: https://docs.astral.sh/uv/getting-started/installation/",
      "Ensure `uv` is available in your PATH",
    })
  end

  -- Check for ty installation
  if vim.fn.executable("ty") == 1 then
    vim.health.ok("`ty` is installed")
  else
    vim.health.error("`ty` is not installed or not on PATH", {
      "Install ty: https://github.com/astral-sh/ty",
      "Or install via uv: `uv tool install ty`",
      "Ensure `ty` is available in your PATH",
    })
  end

  -- Check that ty LSP is not globally enabled
  if vim.lsp.is_enabled("ty") then
    vim.health.error("`ty` LSP is globally enabled", {
      "This plugin manages `ty` LSP startup automatically",
      "Remove `vim.lsp.enable('ty')` from your config to avoid conflicts",
      "See :help tylsp-pep723 for more information",
    })
  else
    vim.health.ok("`ty` LSP is not globally enabled")
  end
end

return M
