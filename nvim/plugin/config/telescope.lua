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

local actions = require('telescope.actions')
require("telescope").setup({
  defaults = {
    initial_mode = 'insert',
    layout_stategy = 'vertical',
    layout_config = { height = 0.85 },
    pickers = { find_files = { hidden = true } },
    dynamic_preview_title = true,
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
    -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- borderchars = { "─", "│", "─", "│", "├", "┤", "┘", "└", },
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        layout_stategy = 'bottom_pane'
        -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└", "├", "┤" }
        -- even more opts
      },
      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      specific_opts = {
        --   [kind] = {
        --     make_indexed = function(items) -> indexed_items, width,
        --     make_displayer = function(widths) -> displayer
        --     make_display = function(displayer) -> function(e)
        --     make_ordinal = function(e) -> string
        --   },
        --   -- for example to disable the custom builtin "codeactions" display
        --      do the following
        codeactions = false,
      }
    },
    ["undo"] = {
      use_delta = true,
      use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
      side_by_side = true,
      diff_context_lines = vim.o.scrolloff,
      entry_format = "state #$ID, $STAT, $TIME",
      mappings = {
        i = {
          -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
          -- you want to replicate these defaults and use the following actions. This means
          -- installing as a dependency of telescope in it's `requirements` and loading this
          -- extension from there instead of having the separate plugin definition as outlined
          -- above.
          ["<cr>"]   = require("telescope-undo.actions").yank_additions,
          ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
          ["<C-cr>"] = require("telescope-undo.actions").restore,
        }
      }
    }
  }
})
require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("undo")
