vim.opt.runtimepath:prepend('~/.vim')
vim.opt.runtimepath:append('~/.vim/after')
vim.o.packpath = vim.o.runtimepath

-- Exclude some plugins
vim.g.plugin_tabline = 1
vim.g.plugin_statusline = 1
vim.g.plugin_modecolor = 1

vim.cmd("source ~/.vim/vimrc")
