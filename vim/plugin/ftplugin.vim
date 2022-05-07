if exists('g:plugin_ftplugin')
  finish
endif
let g:plugin_ftplugin = 1

let g:ftplugin_path = get(g:, 'ftplugin_path', "~/dotfiles/vim/after/ftplugin/")

command Ftplugin       exe printf("e %s.vim",      g:ftplugin_path.&filetype)
command FtpluginVsplit exe printf("vs %s.vim",     g:ftplugin_path.&filetype)
command FtpluginSplit  exe printf("sp %s.vim",     g:ftplugin_path.&filetype)
command FtpluginTab    exe printf("tabnew %s.vim", g:ftplugin_path.&filetype)
