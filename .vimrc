"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" automatic reload vimrc when modified
augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END


" autosave file upon modification
autocmd TextChanged,TextChangedI <buffer> silent write

set scrolloff=10

set nocompatible " not compatible with vi
set autoread " detect when a file is changed

" make backspace behave in a sane manner
set backspace=indent,eol,start

" set a map leader for more key combos
let mapleader = '\'

" Tab control
set noexpandtab " tabs ftw
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4 " the visible width of tabs
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'

set clipboard=unnamed

" faster redrawing
set ttyfast

" code folding settings
set foldmethod=syntax " fold based on indent
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1

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
"-> set in molokai
" set colorcolumn=81
let &colorcolumn=join(range(82,999),",")
"if exists('+colorcolumn')
"  set colorcolumn=80
"else
"  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ruler
set showcmd
set mouse=a
set showmode
set whichwrap+=<,>,h,l,[,]
set visualbell

" Look
syntax on
colorscheme molokai
set background=dark
"colorscheme delek
"colorscheme Kafka

" Searching
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch
set incsearch " set incremental search, like modern browsers
set nolazyredraw " don't redraw while executing macros

set magic " Set magic on, for regex

set showmatch " show matching braces
set mat=2 " how many tenths of a second to blink

set number
set relativenumber

set autoindent " automatically set indent of new line
set smartindent
filetype indent on

set laststatus=2 " show the satus line all the time

" Code
set encoding=utf8
let base16colorspace=256  " Access colors present in 256 colorspace"
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors"


" auto show autocomplete omnibox
" set completeopt=longest,menuone

" netrw
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

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = 10
" open netrw with vim
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END
" autocmd filetype netrw nnoremap <c-a> <cr>:wincmd W<cr>

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
map <Leader>cm :make re<CR><CR>
map <Leader>cc :cc<CR>
map <Leader>cn :cn<CR>
map <Leader>cp :cp<CR>
map <Leader>cl :clist<CR>
autocmd QuickFixCmdPost [^l]* nested botright cwindow
autocmd QuickFixCmdPost    l* nested botright lwindo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <c-z> will work in insert mode
inoremap <c-z> <c-c><c-z>

" edit vimrc
map <leader>ev :vertical split ~/.vimrc<cr>

" select all text in function
nnoremap vif [{%v%

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk

" go to name of function you are in (needs a '()')
nnoremap <silent> gid [{k^t(b

" search next call of function you are in
nnoremap <silent> gin [{kt^(b*

" helpers for dealing with other people's code
nmap \t :set ts=4 sts=4 sw=4 noet<cr>
nmap \s :set ts=4 sts=4 sw=4 et<cr>

" auto close bracers
" inoremap (      ();<Left><Left>
" inoremap (;  (<CR>)<Esc>O
" inoremap ((     (
" inoremap ()     ()

" auto close bracers
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" puts brackets around paragraph
nmap <leader>{} {S{{<Esc>}S}<c-c>=%

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Do not block cursor at first or last character of line

map <C-h> :call WinMove('h')<cr>
map <C-j> :call WinMove('j')<cr>
map <C-k> :call WinMove('k')<cr>
map <C-l> :call WinMove('l')<cr>
"  create a new window if can't move to window
function! WinMove(key)
	let t:curwin = winnr()
	exec "wincmd ".a:key
	"     if (t:curwin == winnr())
	"         if (match(a:key,'[jk]'))
	"             wincmd v
	"         else
	"             wincmd s
	"         endif
	"         exec "wincmd ".a:key
	"     endif
endfunction

" CtrlP ignore patterns
let g:ctrlp_custom_ignore = {
			\ 'dir': '\.git$\|node_modules$\|\.hg$\|\.svn$',
			\ 'file': '\.exe$\|\.so$'
			\ }

" search the nearest ancestor that contains .git, .hg, .svn
let g:ctrlp_working_path_mode = 2

"This unsets the 'last search pattern' register by hitting return
nnoremap <silent><CR> :nohlsearch<CR><CR>

" search and reaplace
" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Coding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> <leader>'' :<C-B> <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>"":<C-B> <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
