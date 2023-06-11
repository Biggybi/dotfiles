""    General Mappings
"""        Special Keys

" space as leader, prompt '\' in command line window :)
" map <space> <leader>

" fix error when using tabs in middle of line
if v:version < 802
  inoremap <c-i> <c-v><c-i>
endif

"""        Modes
" closing easy
function! QuitBackToLast() abort
  quit
endfunction
nnoremap <silent> <leader>q :silent! call QuitBackToLast()<cr>
" -> this mapping does not focus the previous buffer
" nnoremap <leader>q :quit<cr>

" Delete Hidden Buffers
function! DeleteHiddenBuffers() abort
  let tpbl=[]
  let closed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val)' && 'index(tpbl, v:val)==-1')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let closed += 1
    endif
  endfor
  echo "Closed" closed "hidden buffers"
endfunction
command! BwHidden call DeleteHiddenBuffers()

nnoremap <leader><C-Space> :echo "kewl"<cr>

" enter command mode with ;
nnoremap ; :
nnoremap <c-;> :
vnoremap ; :
nnoremap <leader>; :!

nnoremap <silent> gI `.gi<esc>zz:call FitBufferWindowBottom()<cr>

" no more default ex mode
nnoremap Q <nul>

" reset screen
nnoremap <silent> <c-q> :mode<cr>

" repeat last macro
nnoremap - @@

" <c-z> in insert and command mode
inoremap <c-z> <c-[><c-z>
cnoremap <c-z> <c-[><c-z>

" :W! save files as root
cnoremap <c-r><c-s> %!sudo tee > /dev/null %

" new paragraph between lines
nnoremap co O<cr>

"""        Insert mode undo breaks
inoremap . .<c-g>u
inoremap , ,<c-g>u
inoremap ; ;<c-g>u
inoremap : :<c-g>u
inoremap ( (<c-g>u
inoremap ) )<c-g>u
inoremap { {<c-g>u
inoremap } }<c-g>u
inoremap [ [<c-g>u
inoremap ] ]<c-g>u
inoremap _ _<c-g>u

"""        Toggles

" Toggle concealed characters
function! ConcealToggle() abort
  if &conceallevel
    set conceallevel=0
    echo "set conceallevel = 0"
  else
    set conceallevel=2
    echo "set conceallevel = 2"
  endif
endfunction
nnoremap yoq <cmd>call ConcealToggle()<cr>

" Toggle / close / open Undotree
let g:undotree_SetFocusWhenToggle = 1
nnoremap you <cmd>UndotreeToggle<cr>
nnoremap [ou <cmd>UndotreeShow<cr>
nnoremap ]ou <cmd>UndotreeHide<cr>
nnoremap yo<c-u> <cmd>UndotreeFocus<cr>

" Obsession
nnoremap yoo <cmd>call ToggleObsession()<cr>

" Netrw toggle - left
" nnoremap <silent> yoe :30Lexplore<cr>

" " Move visual selection (=unimpaired + gv)
xmap [e <Plug>(unimpaired-move-selection-up)\|gv
xmap ]e <Plug>(unimpaired-move-selection-down)\|gv

" Toggle hlsearch + Anzu
nnoremap <silent> yoh <cmd>ToggleHL<cr>

" winfix width/height
nnoremap <silent> yo<c-w> <cmd>setlocal winfixwidth!<bar>echo &winfixwidth == 0
      \? 'nowinfixwidth' : 'winfixwidth'<cr>
nnoremap <silent> yo<c-h> <cmd>setlocal winfixheight!<bar>echo &winfixheight == 0
      \? 'nowinfixheight' : 'winfixheight'<cr>

" TODO: keep cursor on the same column
nnoremap <silent> zz myzz<bar><cmd>call FitBufferWindowBottom()<cr><bar>`y
command! ZZToggle
      \ let &scrolloff=999-&scrolloff
      \| echo &scrolloff > 900 ? "zz mode on" : "zz mode off"
      \| normal zz
nnoremap <silent> yoz <cmd>ZZToggle<cr>

" Load project files buffers
nnoremap yoj <cmd>call AutoProjectLoad('1')<cr>

" Goyo toggle
nnoremap yog <cmd>Goyo<cr>

"""        Copy / Paste / Delete

" select last paste
nnoremap gp `[v`]

" delete without saving to register
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

" System clipboard interraction
" paste from clipboard ...
nnoremap <leader>p mp"+]p==`p
nnoremap <leader>P mp"+]P==`p
" ... on new line ...
nnoremap ]<leader>p o<esc>"+]p==
" ... above
nnoremap [<leader>p O<esc>"+]p==
" ... fix conflict for unimpaired blank lines
if mapleader == "\<space>"
  nmap [<space><space> <plug>(unimpaired-blank-up)
  nmap ]<space><space> <plug>(unimpaired-blank-down)
endif

" copy to clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

"""        Replace

" Auto spell correction
nnoremap <leader>z= z=1<cr><cr>

" Replace last search
nnoremap gr :s///g<left><left>
vnoremap gr :s///g<left><left>
nnoremap gR :%s///g<left><left>
nnoremap g<c-r> :%s/<c-r><c-w>//g<left><left>
" nnoremap c/ :s///g<left><left>
" vnoremap c/ :s///g<left><left>
" nnoremap C/ :%s///g<left><left>

" Replace word under cursor
" nnoremap c. :s/<c-r><c-w>//g<left><left>
" vnoremap c. :s/<c-r><c-w>//g<left><left>
" nnoremap C. :%s/<c-r><c-w>//g<left><left>

nnoremap C c$

"""        Files Information

" cd shell to vim current working directory
nnoremap <leader>cd <cmd>!cd &pwd<cr> :echo "shell cd : " . getcwd()<cr>

" show file name
nnoremap <silent> <leader>fp <cmd>echo expand('%')<cr>

" show file name and copy it to unnamed register
nnoremap <silent> <leader>f<c-p> <cmd>let @"=expand('%')<bar>echo expand('%:p:h')<cr>

" show file path/name and copy it to unnamed register
nnoremap <silent> <leader>fP <cmd>let @"=expand('%:p')<bar>echo expand('%:p')<cr>

" show file name and copy it to unnamed register
nnoremap <silent> <leader>f<c-f> <cmd>let @"=expand('%:t')<bar>echo expand('%:t')<cr>

" dump current file name without path
inoremap <c-r><c-f> <c-r>=expand('%:p:t')<cr>

" dump current file name with full path
inoremap <c-r><leader>f <c-r>=expand('%:p')<cr>

"""        New Files / Windows

" new file in vertical split instead of horizontal
nnoremap <silent> <c-w><c-n> <cmd>vertical new<cr>

" open file under cursor in vertical split instead of horizontal
nnoremap <silent> <c-w><c-f> <cmd>vertical wincmd f<cr>

" open file under cursor in a netrw pannel on the left
nnoremap <silent> <c-w><c-d> <cmd>Lexplore <cfile><cr>

"""        Folding

" Open / close fold with <c-space>
if ! has("nvim")
  nnoremap <silent> <c-@> za:call FitBufferWindowBottom()<cr>
  vnoremap <silent> <c-@> zf
else
  nnoremap <silent> <c-space> za:call FitBufferWindowBottom()<cr>
  vnoremap <silent> <c-space> zf
endif

" close every fold except current
nnoremap <leader>zc <cmd>normal! mzzMzv`z<CR>

" recursively open even partial folds
nnoremap zo zczO

" keep cursor line in a sane place on screen
" ... when closing folds
nnoremap zM zMzb
" ... when closing a fold
nnoremap <silent> zm <cmd>set scrolloff=0<cr>zmzb:let &scrolloff=winheight(win_getid())/10 + 1<cr>

"""        Dotfiles

" source vimrc
function s:vimrcSource()
  silent source $MYVIMRC
  filetype detect
  echo "vimrc sourced"
endfunction

nnoremap <silent> <leader>sv <cmd>call <sid>vimrcSource()<cr>
" nnoremap <leader>sv <cmd>source $MYVIMRC<bar>filetype detect<bar><c-u>echo "vimrc sourced"<cr>
nnoremap <leader>sr <cmd>silent Runtime<bar>:echo "Runtime"<cr>
nnoremap <leader>s. <cmd>silent Runtime<bar>:echo "Runtime"<cr>
nnoremap <silent> <leader>sf :silent! :filetype detect<cr>
nnoremap <silent> <leader>ss <cmd>source .git/Session.vim<cr>

" source colors
nnoremap <silent> <leader>s1 <cmd>colorscheme onehalf-dark<cr>
nnoremap <silent> <leader>s2 <cmd>colorscheme onehalf-light<cr>

" edit dotfiles
nnoremap <leader>ev      <cmd>e  $DOT/vim/vimrc<cr>
nnoremap <leader>Ev      <cmd>sp $DOT/vim/vimrc<cr>
nnoremap <leader><c-e>v  <cmd>vs $DOT/vim/vimrc<cr>
nnoremap <leader>ei      <cmd>e  $DOT/nvim/init.vim<cr>
nnoremap <leader>Ei      <cmd>sp $DOT/nvim/init.vim<cr>
nnoremap <leader><c-e>i  <cmd>vs $DOT/nvim/init.vim<cr>

nnoremap <leader>et      <cmd>e  $DOT/tmux/tmux.conf<cr>
nnoremap <leader>Et      <cmd>sp $DOT/tmux/tmux.conf<cr>
nnoremap <leader><c-e>t  <cmd>vs $DOT/tmux/tmux.conf<cr>

nnoremap <leader>ea      <cmd>e  $DOT/shells/alacritty/alacritty.yml<cr>
nnoremap <leader>Ea      <cmd>sp $DOT/shells/alacritty/alacritty.yml<cr>
nnoremap <leader><c-e>a  <cmd>vs $DOT/shells/alacritty/alacritty.yml<cr>

nnoremap <leader>ebb     <cmd>e  $DOT/shells/bash/bashrc<cr>
nnoremap <leader>Ebb     <cmd>sp $DOT/shells/bash/bashrc<cr>
nnoremap <leader><c-e>bb <cmd>vs $DOT/shells/bash/bashrc<cr>
nnoremap <leader>eba     <cmd>e  $DOT/shells/bash/bash_aliases<cr>
nnoremap <leader>Eba     <cmd>sp $DOT/shells/bash/bash_aliases<cr>
nnoremap <leader><c-e>ba <cmd>vs $DOT/shells/bash/bash_aliases<cr>
nnoremap <leader>ebp     <cmd>e  $DOT/shells/bash/bash_profile<cr>
nnoremap <leader>Ebp     <cmd>sp $DOT/shells/bash/bash_profile<cr>
nnoremap <leader><c-e>b  <cmd>vs $DOT/shells/bash/bash_profile<cr>

nnoremap <leader>ezz     <cmd>e  $DOT/shells/zsh/zshrc<cr>
nnoremap <leader>Ezz     <cmd>sp $DOT/shells/zsh/zshrc<cr>
nnoremap <leader><c-e>zz <cmd>vs $DOT/shells/zsh/zshrc<cr>
nnoremap <leader>eza     <cmd>e  $DOT/shells/zsh/zsh_aliases<cr>
nnoremap <leader>Eza     <cmd>sp $DOT/shells/zsh/zsh_aliases<cr>
nnoremap <leader><c-e>za <cmd>vs $DOT/shells/zsh/zsh_aliases<cr>
nnoremap <leader>ezh     <cmd>e  $HOME/.zsh_history<cr>
nnoremap <leader>Ezh     <cmd>sp $HOME/.zsh_history<cr>
nnoremap <leader><c-e>zh <cmd>vs $HOME/.zsh_history<cr>

nnoremap <leader>ebn     <cmd>e  $DOT/inputrc<cr>
nnoremap <leader>Ebn     <cmd>sp $DOT/inputrc<cr>
nnoremap <leader><c-e>bn <cmd>vs $DOT/inputrc<cr>

nnoremap <leader>ec1     <cmd>e  $DOT/vim/colors/base16-onedark.vim<cr>
nnoremap <leader>ec2     <cmd>e  $DOT/vim/colors/base16-one-light.vim<cr>

" " rename file
" nnoremap <leader>mv :!mv % %:h:p/

"""        Git

" Show git log history
if !has('nvim')
nnoremap <leader>gl <cmd>vert terminal git --no-pager log --all --decorate --oneline --graph<bar>setlocal filename=""<cr>
endif
" Show git log in location list
nnoremap ghl <cmd>Gllog!<bar>wincmd b<bar>wincmd L<cr>

"""        Terminal

tnoremap <c-n> <c-\><c-n>
tnoremap <c-@> <c-w>:
tnoremap <c-space> <c-\><c-n>:

"""        Headers

nmap <leader>h1 <Plug>(Header42)

""    Move Mappings
"""        Movement

" start / end of line
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" top / bottom of window
nnoremap gH H
nnoremap gL L
nnoremap gM M

" redraw with line at top / bottom
nnoremap <leader>o  zt
nnoremap <leader>i  zb

" insert mode delete / end of line / start of line
inoremap <silent> <expr> <c-l> pumvisible() ? "\<lt>C-l>" : "\<lt>del>"
inoremap <silent> <expr> <c-e> pumvisible() ? "\<lt>C-e>" : "\<lt>c-o>$"
inoremap <silent> <expr> <c-a> pumvisible() ? "\<lt>C-a>" : "\<lt>c-o>^"

" up down on visual lines
xnoremap <silent> <expr> j v:count? 'j' : 'gj'
xnoremap <silent> <expr> k v:count? 'k' : 'gk'
nnoremap <silent> <expr> j v:count? 'j' : 'gj'
nnoremap <silent> <expr> k v:count? 'k' : 'gk'

" navigate between start/end of WORD
nnoremap <silent> <expr> <c-l> getline('.')[col('.')] == ' '
      \ <bar><bar> getline('.')[col('.') - 1] == ' '
      \ <bar><bar> col('.') == col('$') - 1
      \ <bar><bar> col('$') == 1
      \ ? 'w' : 'E'
vnoremap <silent> <expr> <c-l> getline('.')[col('.')] == ' '
      \ <bar><bar> getline('.')[col('.') - 1] == ' '
      \ <bar><bar> col('.') == col('$') - 1
      \ <bar><bar> col('$') == 1
      \ ? 'w' : 'E'

nnoremap <silent> <expr> <c-h> getline('.')[col('.') - 2] == ' '
      \ <bar><bar> getline('.')[col('.') - 1] == ' '
      \ <bar><bar> col('$') == 1
      \ <bar><bar> col('.') == 1
      \ ? 'gE' : 'B'
vnoremap <silent> <expr> <c-h> getline('.')[col('.') - 2] == ' '
      \ <bar><bar> getline('.')[col('.') - 1] == ' '
      \ <bar><bar> col('$') == 1
      \ <bar><bar> col('.') == 1
      \ ? 'gE' : 'B'

" next / previous paragraph (or whitespace line)

onoremap <c-j> <cmd>call search('\(^\s*$\)\\|\(\%$\)', 'e')<cr>
onoremap <c-k> <cmd>call search('\(^\s*$\)\\|\(\%^\)', 'be')<cr>
nnoremap <C-j> <cmd>call search('\(^\s*$\)\\|\(\%$\)', 'W')<CR>
nnoremap <C-k> <cmd>call search('\(^\s*$\)\\|\(\%^\)', 'bW')<CR>

"go to next / previous buffer
nnoremap <leader>] <cmd>bn<cr>
nnoremap <leader>[ <cmd>bp<cr>

" switch last 2 buffers
nnoremap <leader><space> <cmd>b#<cr>
vnoremap <leader><space> <cmd>b#<cr>

" last buffer in vertical split
nnoremap <c-w>#              <cmd>vs#<cr>
nnoremap <c-w><space><space> <cmd>vs#<cr>
nnoremap <c-w><space>v       <cmd>vs#<cr>
nnoremap <c-w><space>s       <cmd>sp#<cr>
nnoremap <c-w><space>t       <cmd>tabnew#<cr>
vnoremap <c-w>#              <cmd>vs#<cr>
vnoremap <c-w><space><space> <cmd>vs#<cr>
vnoremap <c-w><space>v       <cmd>vs#<cr>
vnoremap <c-w><space>s       <cmd>sp#<cr>
vnoremap <c-w><space>t       <cmd>tabnew#<cr>

" visual shifting without exiting Visual mode
vnoremap < <gv
vnoremap > >gv

" open buffer with partial search
" nnoremap <leader>b :buffer<space>
" nnoremap <leader><c-b> :vertical sbuffer<space>
" nnoremap <leader>B :sbuffer<space>
" nnoremap <leader>T :vertical sbuffer !/bin/bash<cr>

" resize windows quicker
nnoremap <silent> <Leader>= :exe "resize "          . (winheight(0) * 3/2 + 1)<CR>
nnoremap <silent> <Leader>- :exe "resize "          . (winheight(0) * 2/3)<CR>
nnoremap <silent> <leader>> :exe "vertical resize " . (winwidth(0)  * 4/3 + 1)<CR>
nnoremap <silent> <leader>< :exe "vertical resize " . (winwidth(0)  * 3/4)<CR>

"""        Alt Movement

" " for with <meta sends escape> terminal
" inoremap <expr> <esc>l getcurpos()[2] == 1 && getline('.') != '' ? "<esc>a" : "<esc>a<right>"
" inoremap <expr> <esc>h getcurpos()[2] == 1 ? "<esc>i<left>" : '<esc>i'
" inoremap <expr> <esc>j getcurpos()[2] == 1 ? "<esc><down>i" : "<esc><down>a"
" inoremap <expr> <esc>k getcurpos()[2] == 1 ? "<esc><up>i" : "<esc><up>a"
" inoremap <c-]> <esc><esc>
" inoremap ^[ e <c-o>$
" inoremap ^[ a <c-o>^
" inoremap <esc> <c-o>:stopinsert<cr>

" " map <left> <right> for escape sequences
" inoremap <expr> <c-f> getcurpos()[2] == 1 && getline('.') != '' ? "<esc>a" : "<esc>a<right>"
" inoremap <expr> <c-b> getcurpos()[2] == 1 ? "<esc>i<left>" : '<esc>i'
inoremap <c-f> <right>
inoremap <c-b> <left>

if $WSL_DISTRO_NAME != '' && !has("nvim")
  for i in range(char2nr('a'), char2nr('z'))
    let char = nr2char(i)
    execute "set <M-".char.">=\e".char
    let char = nr2char(i - 32)
    execute "set <M-".char.">=\e".char
  endfor
endif

" " fix meta-keys which generate <Esc>a .. <Esc>z
" let c='a'
" while c <= 'z'
"   exec "set <M-".toupper(c).">=\e".c
"   exec "imap \e".c." <M-".toupper(c).">"
"   let c = nr2char(1+char2nr(c))
" endw

inoremap <m-h> <left>
inoremap <m-j> <down>
inoremap <m-k> <up>
inoremap <m-l> <right>
cnoremap <m-h> <left>
cnoremap <m-j> <down>
cnoremap <m-k> <up>
cnoremap <m-l> <right>
nnoremap <m-h> <cmd>wincmd h<cr>
nnoremap <m-j> <cmd>wincmd j<cr>
nnoremap <m-k> <cmd>wincmd k<cr>
nnoremap <m-l> <cmd>wincmd l<cr>
tnoremap <m-h> <cmd>wincmd h<cr>
tnoremap <m-j> <cmd>wincmd j<cr>
tnoremap <m-k> <cmd>wincmd k<cr>
tnoremap <m-l> <cmd>wincmd l<cr>
nnoremap <m-H> <cmd>vertical resize -1<CR>
nnoremap <m-J> <cmd>resize -1<cr>
nnoremap <m-K> <cmd>resize +1<cr>
nnoremap <m-L> <cmd>vertical resize +1<CR>
nnoremap <m-o> <cmd>tabnext<cr>
nnoremap <m-i> <cmd>tabprevious<cr>

" " next / previous tab (with wrap)
" nnoremap <expr> <m-O> tabpagenr() == tabpagenr('$')
"       \? "<cmd>silent! tabmove 0<cr>"
"       \: "<cmd>silent! tabmove +1<cr>"
" nnoremap <expr> <m-I> tabpagenr() == 1
"       \? "<cmd>tabmove $<cr>"
"       \: "<cmd>tabmove -1<cr>"

" next / previous tab (with wrap)
nnoremap <silent> <expr> <m-O> tabpagenr() == tabpagenr('$')
      \? ':silent! tabmove 0<cr>'
      \: ':silent! tabmove +1<cr>'
nnoremap <silent> <expr> <m-I> tabpagenr() == 1
      \? ':silent! tabmove $<cr>'
      \: ':silent! tabmove -1<cr>'
nnoremap <silent> <expr> <leader>O tabpagenr() == tabpagenr('$')
      \? ':silent! tabmove 0<cr>'
      \: ':silent! tabmove +1<cr>'
nnoremap <silent> <expr> <leader>I tabpagenr() == 1
      \? ':silent! tabmove $<cr>'
      \: ':silent! tabmove -1<cr>'

nnoremap <m-p> <cmd>tabnext #<cr>

nnoremap <c-w><c-o> <cmd>tabnext<cr>
nnoremap <c-w><c-i> <cmd>tabprevious<cr>
if has ("nvim")
  nnoremap <c-w><tab> <cmd>tabprevious<cr>
  nnoremap <c-w><s-tab> <cmd>tabnext<cr>
endif
nnoremap <silent> <c-w><c-u> :only<cr>
nnoremap <silent> <c-w>u     :only<cr>

"""        Searching

" Matchit : easier '%'
nmap <silent> <c-g>  <Plug>(MatchitNormalForward)
nmap <silent> <c-g>  <Plug>(MatchitNormalForward)
omap <silent> <c-g>  <Plug>(MatchitOperationForward)
xmap <silent> <c-g>  <Plug>(MatchitVisualForward)
xnoremap <silent> <leader><c-g> <c-g>
nmap <silent> [<c-g> <Plug>(MatchitNormalMultiBackward)
nmap <silent> ]<c-g> <Plug>(MatchitNormalMultiForward)
xmap <silent> [<c-g> <Plug>(MatchitVisualMultiBackward)
xmap <silent> ]<c-g> <Plug>(MatchitVisualMultiForward)
omap <silent> [<c-g> <Plug>(MatchitOperationMultiBackward)
omap <silent> ]<c-g> <Plug>(MatchitOperationMultiForward)

nnoremap <silent> * <cmd>let @/= '\<' . expand('<cword>') . '\>' <bar>set hlsearch<bar>UpdateSearchMatch<cr>
nnoremap <silent> g* <cmd>let @/=expand('<cword>') <bar>set hlsearch<bar>UpdateSearchMatch<cr>

" search visual selection
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

"""        Command Line

" Basic moves
cnoremap <c-a> <home>
cnoremap <c-e> <end>
if !has('nvim')
  cnoremap <c-@> <down>
  cnoremap <c-k> <up>
  cnoremap <c-j> <down>
else
  cnoremap <c-k> <up>
  cnoremap <c-j> <down>
endif
cnoremap <c-b> <left>
cnoremap <c-l> <s-right>
cmap <c-o> <s-tab>

" delete from cursor
cnoremap <c-x> <c-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<cr>

" skyrim quit
cnoreabbrev <silent> <expr> qqq (getcmdtype() ==# ':' && getcmdline() ==# "qqq")
      \? "echo 'FUS RO DAH!' \| qall!"
      \: "qqq"

" put current working directory
cnoremap <c-r>. <c-r>=fnameescape(expand('%:h')).'/'<cr>
nnoremap <leader>vp :e vim/plugin/

" start command for all windows / arguments
nnoremap <c-w>; :windo<space>
nnoremap <c-w>: :argdo<space>

"""        Tags

" show matching tags
nnoremap g<c-]> g]

" jump if only one match
nnoremap g] g<c-]>

"""        Select lines starting with same world

function! SelectFirstWordBlock(all) abort
  try
    let curpos = getpos('.')
    let curline = curpos[1]
    let nextline = curline + 1
    let prevline = curline - 1
    let firstword = get(split(trim(getline('.')), '\W\+'), 0)

    while (a:all == 1 && get(split(trim(getline(nextline)), '\W\+'), 0) =~ firstword)
      let nextline += 1
    endwhile
    while (a:all == 0 && get(split(trim(getline(nextline)), '\W\+'), 0) ==# firstword)
      let nextline += 1
    endwhile

    while (a:all == 1 && get(split(trim(getline(prevline)), '\W\+'), 0) =~ firstword)
      let prevline += 1
    endwhile
    while (a:all == 0 && get(split(trim(getline(prevline)), '\W\+'), 0) ==# firstword)
      let prevline += 1
    endwhile

    echom firstword prevline nextline
    if mode() !~? '[v]'
      normal! V
    endif
  finally
    call cursor(nextline, 0)
    normal gv
    normal o
    call cursor(prevline, 0)
  endtry
endfunction

function! SelectFirstWordBlockVisual() abort
  try
    let curpos = getpos('.')
    let curpos2 = getpos('.')
    if curpos2[3] < curpos[3]
      normal o
    endif
    normal ^
    normal gv
    let curline = curpos[1]
    let nextline = curline + 1
    let prevline = curline - 1
    let firstword = @*
    while (getline(nextline) =~ "^\\s\*".firstword.".*")
      " echom yeah
      let nextline += 1
    endwhile
    while (getline(prevline) =~ "^\\s\*".firstword.".*")
      " echom coucou
      let prevline -= 1
    endwhile
    let nextline -= 1
    let prevline += 1
    if mode() !~? '[v]'
      normal! V
    endif
  finally
    call cursor(nextline, 0)
    normal o
    call cursor(prevline, 0)
  endtry
endfunction

vnoremap <silent> <c-p> :call SelectFirstWordBlockVisual()<cr>
nnoremap <silent> <leader>V :call SelectFirstWordBlock('1')<cr>
nnoremap <silent> <leader><c-v> :call SelectFirstWordBlock('0')<cr>

"""        Windows

nnoremap <silent> <c-w><c-c> <cmd>let buff=bufname()<bar>close<bar>echo buff . " closed"<cr>
nnoremap <silent> <c-w>c     <cmd>let buff=bufname()<bar>close<bar>echo buff . " closed"<cr>

"""        Completion

" inoremap <silent> <c-n> <c-n><c-n><c-n><c-p><c-p>
" inoremap <silent> <c-p> <c-p><c-p><c-p><c-n><c-n>

""    Code Mappings
"""        Auto Brackets
" auto close brackets

inoremap ( ()<c-g>U<left>
inoremap [ []<c-g>U<left>
inoremap { {}<c-g>U<left>

inoremap <expr> ) getline('.')[col('.')-1]==')' ? '<c-g>U<right>' : ')'
inoremap <expr> ] getline('.')[col('.')-1]==']' ? '<c-g>U<right>' : ']'
inoremap <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'
" inoremap <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'

"""        Indent

command! -nargs=1 -complete=command Nomove
      \ try
      \ |  let s:svpos = winsaveview()
      \ |  execute <q-mods> <q-args>
      \ |finally
      \ |  call winrestview(s:svpos)
      \ |  unlet s:svpos
      \ |endtry

" indent all file easy
nnoremap g<c-g> <cmd>Nomove normal! gg=G<cr>
nnoremap gG <cmd>Nomove normal! =ap<cr>

"""        Make
nnoremap <leader>cm     <cmd>VShell make<cr>
nnoremap <leader>cr     <cmd>VShell make re<cr>
nnoremap <leader>c<c-r> <cmd>Shell make re<cr>
nnoremap <leader>cx     <cmd>VShell make clean<cr>
nnoremap <leader>c<c-x> <cmd>VShell make fclean<cr>
nnoremap <leader>mm     <cmd>make<cr>:botright copen<cr><c-w>p

nmap <silent><leader>ch <Plug>(MoveScratchTermH)
nmap <silent><leader>cj <Plug>(MoveScratchTermJ)
nmap <silent><leader>ck <Plug>(MoveScratchTermK)
nmap <silent><leader>cl <Plug>(MoveScratchTermL)
nmap <silent><leader>cz <Plug>(MoveScratchTermQ)
nmap <silent><leader>ci <Plug>(ScrollScratchTermJ)
nmap <silent><leader>co <Plug>(ScrollScratchTermK)
nmap <silent><leader>c. <Plug>(RunShellCommandRe)

" Make in split
function! s:locListPanel(pfx, side) abort
  try
    let winnr = winnr()
    exe a:pfx . 'open'
    if &filetype == 'qf'
      exe "wincmd" a:side
    endif
  finally
    if winnr() != winnr
      wincmd p
    endif
  endtry
endfunction

nnoremap <leader>csm <cmd>lmake!<bar>call <sid>locListPanel('l', 'J')<cr>
nnoremap <leader>csr <cmd>lmake! re<bar>call <sid>locListPanel('l', 'J')<cr>

"""        Count

function! FunctionLineCount() abort
  let firstline = search('^{', 'bn')
  let lastline = search('^}', 'n')
  echo "function lines :" lastline - firstline - 1
endfunction

nnoremap <leader>wcf <cmd>call FunctionLineCount()<cr>

"""        Doc
noremap <silent> <leader>K K

let g:markdown_fenced_languages = ['css', 'js=javascript']

""    modeline
" vim:foldmethod=expr:foldtext=VimFold()
