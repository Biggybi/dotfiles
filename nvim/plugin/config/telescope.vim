nnoremap <silent> yof            :Telescope file_browser<cr>
nnoremap <silent> <leader>ff     :Telescope find_files cwd=$HOME<cr>
nnoremap <silent> <leader>f.     :Telescope find_files  $DOT<cr>
nnoremap <silent> <leader><c-f>  :Telescope find_files<cr>
nnoremap <silent> <leader>F      :Telescope find_files cwd=/<cr>
nnoremap <silent> <leader>fb     :Telescope buffers<cr>
nnoremap <silent> <leader>j      :Telescope buffers<cr>
nnoremap <silent> <leader>ft     :Telescope tags<cr>
nnoremap <silent> <leader>f<c-t> :Telescope current_buffer_tags<cr>
nnoremap <silent> <leader>fc     :Telescope git_commits<cr>
nnoremap <silent> <leader>f<c-c> :Telescope git_bcommits<cr>
nnoremap <silent> <leader>fg     :Telescope git_files<cr>
nnoremap <silent> <leader>fl     :Telescope current_buffer_fuzzy_find<cr>
nnoremap <silent> <leader>f      :Telescope command_history<cr>
nnoremap <silent> <leader>f;     :Telescope commands<cr>
nnoremap <silent> <leader>f/     :Telescope command_history<cr>
nnoremap <silent> <leader>fh     :Telescope oldfiles<cr>
nnoremap <silent> <leader>fm     :Telescope help_tags<cr>
nnoremap <silent> <leader>fs     :Telescope git_status<cr>
nnoremap <silent> <leader>fr     :Telescope grep_string<cr>

nnoremap <silent> <leader>b :ls<cr>
