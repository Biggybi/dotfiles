if exists('g:plugin_darklight')
  finish
endif

let g:dls_theme_list = ['base16-one-light', 'base16-one-lightdim', 'base16-onedark', 'base16-one-lightdim']
" let g:dls_daytime = [7, 17]
let g:dls_theme_source_sensitive = 0

nnoremap <silent> yob :call DarkLightSwitch()<cr>
