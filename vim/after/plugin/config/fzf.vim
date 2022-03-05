if ! exists(':Fzf')
  finish
endif

let g:fzf_buffers_jump = 1      " [Buffers] to existing split

function! s:build_location_list(lines) abort
  call setloclist(0, map(copy(a:lines), '{ "filename": v:val }'))
  lopen
endfunction

function! s:build_quickfix_list(lines) abort
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  bot copen
endfunction

" An action can be a reference to a function that processes selected lines
let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-l': function('s:build_location_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'}

nnoremap <silent> <leader>ff     :FzfFiles $HOME<cr>
nnoremap <silent> <leader>f.     :FzfGFiles $DOT<cr>
nnoremap <silent> <leader><c-f>  :call getcwd() <bar> FzfFiles<cr>
nnoremap <silent> <leader>F      :FzfFiles /<cr>
nnoremap <silent> <leader>fb     :FzfBuffers<cr>
nnoremap <silent> <leader>b      :ls<cr>
nnoremap <silent> <leader>j      :FzfBuffers<cr>
nnoremap <silent> <leader>fw     :FzfWindows<cr>
nnoremap <silent> <leader>ft     :echo ".." <bar> FzfTags<cr>
nnoremap <silent> <leader>f<c-t> :FzfBTags<cr>
nnoremap <silent> <leader>fc     :FzfCommit<cr>
nnoremap <silent> <leader>f<c-c> :FzfBCommit<cr>
nnoremap <silent> <leader>fg     :FzfGFiles<cr>
nnoremap <silent> <leader>f<c-g> :FzfGFiles?<cr>
nnoremap <silent> <leader>fl     :FzfLines<cr>
nnoremap <silent> <leader>f<c-l> :FzfBLines<cr>
nnoremap <silent> <leader>f;     :FzfSearchHistory<cr>
nnoremap <silent> <leader>f/     :FzfCommandHistory<cr>
nnoremap <silent> <leader>fh     :FzfHistory<cr>
nnoremap <silent> <leader>fm     :FzfHelptags<cr>
nnoremap <silent> <leader>fs     :FzfSnippets<cr>
nnoremap <silent> <leader>fR     :FzfRg<cr>
nnoremap <silent> <leader>fr     :FzfRG<cr>
inoremap <silent> <c-x><c-s> <c-o>:FzfSnippets<cr>

" redefine commands to avoid preview-window
command! -bang -nargs=* FzfLines
      \ call fzf#vim#lines(<q-args>, {'options': ['--info=inline', '--preview-window=hidden']}, <bang>0)
command! -bang -nargs=* FzfBLines
      \ call fzf#vim#buffer_lines(<q-args>, {'options': ['--info=inline', '--preview-window=hidden']}, <bang>0)
command! -bar -bang FzfWindows
      \ call fzf#vim#windows({'options': ['--preview-window=hidden']}, <bang>0)
command! -bang -nargs=* FzfHistory
      \ call fzf#vim#history(<bang>0)
command! -bang -nargs=* FzfCommandHistory
      \ call fzf#vim#command_history({'options': ['--preview-window=hidden']}, <bang>0)
command! -bang -nargs=* FzfSearchHistory
      \ call fzf#vim#search_history({'options': ['--preview-window=hidden']}, <bang>0)
command! -bar -bang FzfHelptags
      \ call fzf#vim#helptags({'options': ['--preview-window=hidden']}, <bang>0)
command! -bar -bang FzfSnippets
      \ call fzf#vim#snippets({'options': ['--preview-window=hidden']}, <bang>0)

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_tags_command = 'ctags -R'
" big floating window
" let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'rounded' } }

" See `man fzf-tmux` for available options
if exists('$TMUX') && str2float(system('tmux -V | grep -Eo " [0-9.]*"')) >= 3.2
  let g:fzf_layout = { 'tmux': '-p90%,80%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
endif

let g:fzf_preview_window = ['right', 'ctrl-]']
" let g:fzf_layout = {'heigh': '40%'}

let $FZF_DEFAULT_OPTS = '--info=inline -m --preview "head -n 500 {}" --bind "ctrl-o:toggle+up,ctrl-i:toggle+down,ctrl-a:toggle-all,ctrl-u:preview-up,ctrl-d:preview-down"'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
"-g '!{node_modules,.git}'

" Customize fzf colors to match your color scheme
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'bg+':     ['fg', 'Vertsplit', 'CursorColumn'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['bg', 'Normal'],
      \ 'gutter':  ['bg', 'Normal'],
      \ 'border':  ['fg', 'Vertsplit'],
      \ 'prompt':  ['fg', 'string'],
      \ 'pointer': ['fg', 'Vertsplit'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" Get text in files with Rg
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   "rg --column --line-number --no-heading --color=always --smart-case --glob '!.git/**' ".shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! s:ripgrepFzf(query, fullscreen) abort
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang FzfRG call s:ripgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* FzfGlines
      \ call fzf#vim#grep(
      \   'git grep --line-number '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

