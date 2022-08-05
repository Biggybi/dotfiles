set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
let &packpath = &runtimepath

" let g:plugin_darklight = 1

        " local adjust = s:len() % 2 == 0 and 1 or 0
        " local left_padd = math.floor(padd / 2) - adjust

colorscheme onehalfdark

lua << EOL
require'nvim-treesitter.configs'.setup {
  ensure_installed = { all },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    -- disable = { "vim", "markdown" },
    additional_vim_regex_highlighting = true,
    },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '[v',
      node_incremental = '[v',
      node_decremental = ']v',
      scope_incremental = "[V", 
      },
    },
  indent = { enable = true }
  -- vim.cmd([[
  -- set foldmethod=expr
  -- set foldexpr=nvim_treesitter#foldexpr()
  -- ]])
}
EOL

source ~/.vim/vimrc
