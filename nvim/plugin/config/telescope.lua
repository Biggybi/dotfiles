local actions = require('telescope.actions')
require('telescope').setup {

-- Prevent entering buffers in insert mode.
vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
      if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
      end
    end,
    group = vim.api.nvim_create_augroup("TelescopePreventStartInsert", {clear = true}),
  }
)
  defaults = {
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<c-f>"] = function() vim.cmd [[normal <right>]] end,
        ["<c-b>"] = function() vim.cmd [[normal <left>]] end,
        ["<Esc>"] = actions.close
      },
    },
    file_ignore_patterns = { "node_modules", "%.out" },
    prompt_prefix = "> ",
  }
}

require("telescope").load_extension "file_browser"
