" => Vimrc settings {{{

" wrap up vimrc
" set foldmethod=marker
" set foldlevel=0
" set modelines=1
" set nofoldenable " don't fold by default

" " automatic reload vimrc when modified
autocmd! bufwritepost $MYVIMRC silent source $MYVIMRC
" source virc
nnoremap <leader>sv :so $MYVIMRC<CR>
nnoremap <leader>vv :so $MYVIMRC<CR>
" source colors
nnoremap <leader>sc1 :so ~/.vim/colors/trikai.vim<CR>
nnoremap <leader>sc2 :so ~/.vim/colors/trikai_light.vim<CR>

" edit vimrc
map <leader>ev :vertical split ~/.vimrc<cr>
" }}}
" => General {{{
let mapleader = '\'
inoremap <C-w><C-e> <Esc>:w<CR>
nnoremap <C-w><C-e> :w<CR>

" inoremap <C-w><C-e> <Esc>:w<CR>
set history=1000 " default 20

set clipboard=unnamed
" set spell " spell check
set nocompatible " not compatible with vi
set autoread " detect when a file is changed

" make backspace behave in a sane manner
set backspace=indent,eol,start

" faster redrawing
set ttyfast
" }}}
" => User Interface {{{
set ruler
set mouse=a
set visualbell
set wildmenu
set showmode
set showcmd

 " show buffer number
set statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2 " show the satus line all the time

set number
set relativenumber

set whichwrap+=<,>,h,l,[,] " free cursor betweem lines
set scrolloff=10 " minumum lines before/after cursor
set autoindent " automatically set indent of new line
set smartindent
filetype indent on

" Tab control
set noexpandtab " tabs ftw
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4 " the visible width of tabs
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'
" }}}
" => Look / Theme {{{
syntax on

colorscheme trikai
" night theme
let hour = strftime("%H")
if 6 <= hour && hour < 18
	colorscheme trikai_light
endif

" Code
set encoding=utf8
let base16colorspace=256  " Access colors present in 256 colorspace"
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors"
"
" }}}
" => Highlights / match {{{
" highlight OverLength ctermbg=203 ctermfg=white guibg=#592928
" match OverLength /\%81v.\+/

" show traling whitespaces
"highlight WhiteSpaceTrim ctermbg=203 ctermfg=white guibg=#592928
highlight TrailingWhiteSpace ctermbg=203 guibg=red
match TrailingWhiteSpace /\s\+$/
autocmd BufWinEnter * match TrailingWhiteSpace /\s\+$/
autocmd InsertEnter * match TrailingWhiteSpace /\s\+\%#\@<!$/
autocmd InsertLeave * match TrailingWhiteSpace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"highlight ColorColumn ctermbg=9
set colorcolumn=81
" let &colorcolumn=join(range(82,999),",")
"if exists('+colorcolumn')
"  set colorcolumn=80
"else
"  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif
"
set mat=2 " how many tenths of a second to blink
" }}}
" => File automation {{{
" autosave file upon modification
autocmd TextChanged,TextChangedI <buffer> silent write
set autoread " detect when a file is changed

" open file where it was closed
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif

" filetype recognition
au FileType c setl ofu=ccomplete#CompleteCpp
au FileType css setl ofu=csscomplete#CompleteCSS
au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
au FileType php setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby setl ofu=rubycomplete#Complete

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
" }}}
" => Code folding settings {{{
" set foldmethod=syntax " fold based on indent
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1
" automatily save and restore views (folding state of files)
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf
" }}}
" => Quickfix {{{
" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
nnoremap <Leader>cm :make re<CR><CR><CR>
nnoremap <Leader>cc :cc<CR>
nnoremap <Leader>cn :cn<CR>
nnoremap <Leader>cp :cp<CR>
nnoremap <Leader>cl :clist<CR>
nnoremap <Leader>cw :cwindow<CR>
autocmd QuickFixCmdPost [^l]* nested botright copen
autocmd QuickFixCmdPost    l* nested botright lwindo
" }}}
" => Netrw {{{
" Toggle Vexplore with <leader>f
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
	  setlocal winfixwidth
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
nnoremap <silent> <leader>f :call ToggleVExplorer()<CR>

" Netrw customization
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = 20
" open netrw with vim
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END
" autocmd filetype netrw nnoremap <c-a> <cr>:wincmd W<cr>
"
" }}}
" => Shell : shell output in new split {{{
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  vert new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, a:cmdline . '    |    ' . expanded_cmdline)
  call setline(2,substitute(getline(1),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
endfunction
"
" }}}
" => Searching {{{
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch " highlight all searches
set incsearch " set incremental search, like modern browsers
set nolazyredraw " don't redraw while executing macros

set wildchar=<Tab> wildmenu wildmode=full
set switchbuf=useopen " open buffers in their window if exist

set magic " Set magic on, for regex
" auto show autocomplete omnibox
" set completeopt=longest,menuone

"Clear search highlight pressing Enter
nnoremap <silent><CR> :nohlsearch<CR><CR>
" For local sed replace
nnoremap gr gd:s/<C-R>///gc<left><left><left>
" For global sed replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>
" }}}
" => Coding mappings {{{
" auto close bracers
" inoremap (      ();<Left><Left>
" inoremap (;  (<CR>)<Esc>O
" inoremap ((     (
" inoremap ()     ()

" auto close brackets
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" put brackets around paragraph
nmap <leader>{} {S{{<Esc>}S}<c-c>=%

" put semicolon EOL
inoremap <leader>; <C-o>m`<C-o>A;<C-o>``
nnoremap <leader>; i<C-o>m`<C-o>A;<C-o>``<C-c>

" go to name of function you are in (needs a '()')
nnoremap <silent> gid [[k^t(b
" go to next call of function you are in
nnoremap <silent> gin [{kt^(b*
" select all text in function
nnoremap vif [{%v%

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> <leader>'' :<C-B> <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>"" :<C-B> <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
" }}}
" => Mappings {{{

" <c-z> will work in insert mode
inoremap <c-z> <c-c><c-z>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk

" helpers for dealing with other people's code
" nmap \t :set ts=4 sts=4 sw=4 noet<cr>
" nmap \s :set ts=4 sts=4 sw=4 et<cr>

" " enter selects menu element
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
" " better menu behavior (keeps element hihlighted, <CR> (enter) to select always)
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"   \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"
" " open omni completion menu closing previous if open and opening new menu without changing the text
" inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"             \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" " open user completion menu closing previous if open and opening new menu without changing the text
" inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"             \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
"
" }}}
" => Window mapping {{{
"move between windows with ctrl
noremap <C-h> :wincmd h<CR>
noremap <C-j> :wincmd j<CR>
noremap <C-k> :wincmd k<CR>
noremap <C-l> :wincmd l<CR>
imap <C-w> <C-o><C-w>

" resize windows quicker
nnoremap <silent><C-w>. :vertical resize +10<CR>
nnoremap <silent><C-w>, :vertical resize -10<CR>
nnoremap <silent><C-w>= :resize +10<CR>
nnoremap <silent><C-w>- :resize -10<CR>

map <C-w><C-h> :call WinMove('h')<cr>
map <C-w><C-j> :call WinMove('j')<cr>
map <C-w><C-k> :call WinMove('k')<cr>
map <C-w><C-l> :call WinMove('l')<cr>
"  create a new window if can't move to window
function! WinMove(key)
	let t:curwin = winnr()
	exec "wincmd ".a:key
      if (t:curwin == winnr())
          if (match(a:key,'[jk]'))
              wincmd v
          else
              wincmd s
          endif
          exec "wincmd ".a:key
      endif
endfunction
" }}}

" vim:foldmethod=marker:foldlevel=0:modelines=1:foldenable
