local M = {}

function M.setup_autocmd()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function(_)
      local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] or ""
      local has_inline_metadata = first_line:match("^# /// script")

      local cmd, name, root_dir
      local conf
      if has_inline_metadata then
        local filepath = vim.fn.expand("%:p")
        local filename = vim.fn.fnamemodify(filepath, ":t")

        name = "ty-" .. filename

        local relpath = vim.fn.fnamemodify(filepath, ":.")

        cmd = { "uvx", "--with-requirements", relpath, "ty", "server" }
        root_dir = vim.fn.fnamemodify(filepath, ":h")
        conf = {
          name = name,
          cmd = cmd,
          root_dir = root_dir,
        }
      else
        conf = vim.lsp.config["ty"]
      end

      vim.lsp.start(conf)
    end,
  })
end

return M
