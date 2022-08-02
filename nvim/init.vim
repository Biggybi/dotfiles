set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Exclude some plugins
let g:loaded_fzf = 1
let g:loaded_airline = 1
let g:loaded_fzf_vim = 1
let g:plugin_tabline = 1
let g:plugin_statusline = 1
let g:plugin_modecolor = 1
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
    disable = { "vim" },
    additional_vim_regex_highlighting = false,
    },
  incremental_selection = {
    enable = true,
    -- keymaps = {
    --   init_selection = "gnn",
    --   node_incremental = "grn",
    --   scope_incremental = "grc",
    --   node_decremental = "grm",
    --   },
    keymaps = {
      init_selection = "gm",
      node_incremental = "<tab>",
      -- scope_incremental = "<tab>", 
      node_decremental = "<s-tab>",
      },
    },
  indent = { enable = true }
  -- vim.cmd([[
  -- set foldmethod=expr
  -- set foldexpr=nvim_treesitter#foldexpr()
  -- ]])
}
EOL

" lua << eol
" -- require('lualine').refresh()
" -- vim.cmd([[
" -- augroup My_group
" --   autocmd!
" --   autocmd FileType c setlocal cindent
" -- augroup END
" -- ]])
" eol

source ~/.vim/vimrc
