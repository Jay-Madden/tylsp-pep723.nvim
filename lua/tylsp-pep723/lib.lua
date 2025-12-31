local M = {}

function M.setup_autocmd()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function(_)

      local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] or ""
      local has_inline_metadata = first_line:match("^# /// script")

      local cmd, name, root_dir
      if has_inline_metadata then
        if vim.lsp.is_enabled("ty") then
          log("TylspPep723: failed to start ephemeral venv, 'ty' LSP is already globally enabled", vim.log.levels.ERROR)
          return
        end

        local filepath = vim.fn.expand("%:p")
        local filename = vim.fn.fnamemodify(filepath, ":t")

        name = "ty-" .. filename

        local relpath = vim.fn.fnamemodify(filepath, ":.")

        cmd = { "uvx", "--with-requirements", relpath, "ty", "server" }
        root_dir = vim.fn.fnamemodify(filepath, ":h")
      else

        if vim.lsp.is_enabled("ty") then
          log("TylspPep723: 'ty' LSP is already globally enabled", vim.log.levels.WARN)
          return
        end

        -- From https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ty.lua
        name = "ty"
        cmd = { "ty", "server" }
        root_dir = vim.fs.root(
          0,
          { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" }
        )
      end

      vim.lsp.start({
        name = name,
        cmd = cmd,
        root_dir = root_dir,
      })
    end,
  })
end

return M
