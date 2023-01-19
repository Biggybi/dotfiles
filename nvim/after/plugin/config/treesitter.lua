
require("nvim-treesitter.install").prefer_git = true
require("nvim-treesitter.configs").setup {
  -- refactor = {
  --   highlight_definitions = {
  --     enable = true,
  --     -- Set to false if you have an `updatetime` of ~100.
  --     clear_on_cursor_move = false,
  --   },
  -- },
  ensure_installed = { all },
  -- ignore_install = { 'gitcommit' },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    -- disable = { "vim", "markdown" },
    disable = { "gitcommit" },
    additional_vim_regex_highlighting = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '[v',
      node_incremental = '[v',
      node_decremental = ']v',
      scope_incremental = '[V',
    },
  },
  indent = { enable = true }
  -- vim.cmd([[
  -- set foldmethod=expr
  -- set foldexpr=nvim_treesitter#foldexpr()
  -- ]])
}
