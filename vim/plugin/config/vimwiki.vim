if exists('g:plugin_vimwiki')
  finish
endif
let plugin_vimwiki = 1

let g:vimwiki_list = [{'path': '~/vimwiki/',
      \ 'syntax': 'markdown', 'ext': '.md'}]

" no vimwiki filetype outside wiki folder
let g:vimwiki_global_ext = 0

" do not conceal syntax characters
let g:vimwiki_conceallevel = 0
