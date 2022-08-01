""    General Mappings
"""        Special Keys

" space as leader, prompt '\' in command line window :)
" map <space> <leader>

" fix error when using tabs in middle of line
if v:version < 802
  inoremap <c-i> <c-v><c-i>
endif

" backspace key
map  <c-h>
if has ('nvim')
  nmap <bs> <c-h>
endif

nnoremap <buffer> <c-c> :feedkeys("\<c-c>")

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

nnoremap <leader><c-@> :echo "kewl"<cr>

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
nnoremap yoq :call ConcealToggle()<cr>

" Toggle / close / open Undotree
let g:undotree_SetFocusWhenToggle = 1
nnoremap you :UndotreeToggle<cr>
nnoremap [ou :UndotreeShow<cr>
nnoremap ]ou :UndotreeHide<cr>
nnoremap yo<c-u> :UndotreeFocus<cr>

" Obsession
nnoremap yoo :call ToggleObsession()<cr>

" Netrw toggle - left
let s:netrw_winsize = get(g:, 'netrw_winsize', '-80')
function! NetrwToggle() abort
  Lexplore
  if &ft==#"netrw"
    exe s:netrw_winsize . "wincmd|"
  endif
endfunction
nnoremap <silent> yoe :call NetrwToggle()<cr>

" " Move visual selection (=unimpaired + gv)
xmap [e <Plug>(unimpaired-move-selection-up)\|gv
xmap ]e <Plug>(unimpaired-move-selection-down)\|gv

" Toggle hlsearch + Anzu
nnoremap <silent> yoh :ToggleHL<cr>

" winfix width/height
nnoremap <silent> yo<c-w> :setlocal winfixwidth!<cr>:echo &winfixwidth == 0
      \? 'nowinfixwidth' : 'winfixwidth'<cr>
nnoremap <silent> yo<c-h> :setlocal winfixheight!<cr>:echo &winfixheight == 0
      \? 'nowinfixheight' : 'winfixheight'<cr>

" TODO: keep cursor on the same column
nnoremap <silent> zz zz<bar>:call FitBufferWindowBottom()<cr>
command! ZZToggle
      \ let &scrolloff=999-&scrolloff
      \| echo &scrolloff > 900 ? "zz mode on" : "zz mode off"
nnoremap <silent> yoz :ZZToggle<cr>

" Load project files buffers
nnoremap yoj :call AutoProjectLoad('1')<cr>

" Goyo toggle
nnoremap yog :Goyo<cr>

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

" Replace last search
nnoremap gr :s/<c-r>///g<left><left>
vnoremap gr :s/<c-r>///g<left><left>
nnoremap gR :%s/<c-r>///g<left><left>
" nnoremap c/ :s///g<left><left>
" vnoremap c/ :s///g<left><left>
" nnoremap C/ :%s///g<left><left>

" Replace word under cursor
" nnoremap c. :s/<c-r><c-w>//g<left><left>
" vnoremap c. :s/<c-r><c-w>//g<left><left>
" nnoremap C. :%s/<c-r><c-w>//g<left><left>

nnoremap C <nop>

"""        Files Information

" cd shell to vim current working directory
nnoremap <leader>cd :!cd &pwd<cr> :echo "shell cd : " . getcwd()<cr>

" show file name
nnoremap <silent> <leader>fp :echo expand('%')<cr>

" show file path/name and copy it to unnamed register
nnoremap <silent> <leader>fP :let @"=expand('%:p')<cr>:echo expand('%:p')<cr>

" show file name and copy it to unnamed register
nnoremap <silent> <leader>f<c-p> :let @"=expand('%')<cr>:echo expand('%:p:h')<cr>

" show file name and copy it to unnamed register
nnoremap <silent> <leader>f<c-f> :let @"=expand('%:t')<cr>:echo expand('%:t')<cr>

" dump current file name without path
inoremap <c-r><c-f> <c-r>=expand('%:p:t')<cr>

"""        New Files / Windows

" new file in vertical split instead of horizontal
nnoremap <silent> <c-w><c-n> :vertical new<cr>

" open file under cursor in vertical split instead of horizontal
nnoremap <silent> <c-w><c-f> :vertical wincmd f<cr>

" open file under cursor in a netrw pannel on the left
nnoremap <silent> <c-w><c-d> :Lexplore <cfile><cr>

"""        Folding

" Open / close fold with <c-space>
if ! has("nvim")
  nnoremap <silent> <c-@> za:call FitBufferWindowBottom()<cr>
  onoremap <silent> <c-@> <c-c>za:call FitBufferWindowBottom()<cr>
  vnoremap <silent> <c-@> zf
elseif has("nvim")
  nnoremap <silent> <c-space> za:call FitBufferWindowBottom()<cr>
  onoremap <silent> <c-space> <c-c>za:call FitBufferWindowBottom()<cr>
  vnoremap <silent> <c-space> zf
endif

" close every fold except current
nnoremap <leader>zc :normal! mzzMzv`z<CR>

" recursively open even partial folds
nnoremap zo zczO

"""        Dotfiles

" source vimrc
nnoremap <leader>sv :silent source $MYVIMRC<bar>:silent filetype detect<bar>:echo "vimrc sourced"<cr>
nnoremap <leader>sr :silent Runtime<bar>:echo "Runtime"<cr>
nnoremap <leader>s. :silent Runtime<bar>:echo "Runtime"<cr>
nnoremap <silent> <leader>sf :silent! :filetype detect<cr>

" source colors
nnoremap <silent> <leader>s1 :source $HOME/.vim/colors/base16-onedark.vim<cr>
nnoremap <silent> <leader>s2 :source $HOME/.vim/colors/base16-one-light.vim<cr>

" edit dotfiles
nnoremap <leader>ev      :e  $DOT/vim/vimrc<cr>
nnoremap <leader>Ev      :sp $DOT/vim/vimrc<cr>
nnoremap <leader><c-e>v  :vs $DOT/vim/vimrc<cr>
nnoremap <leader>en      :e  $DOT/nvim/init.vim<cr>
nnoremap <leader>En      :sp $DOT/nvim/init.vim<cr>
nnoremap <leader><c-e>n  :vs $DOT/nvim/init.vim<cr>

nnoremap <leader>et      :e  $DOT/tmux/tmux.conf<cr>
nnoremap <leader>Et      :sp $DOT/tmux/tmux.conf<cr>
nnoremap <leader><c-e>t  :vs $DOT/tmux/tmux.conf<cr>

nnoremap <leader>ebb     :e  $DOT/shells/bash/bashrc<cr>
nnoremap <leader>Ebb     :sp $DOT/shells/bash/bashrc<cr>
nnoremap <leader><c-e>bb :vs $DOT/shells/bash/bashrc<cr>
nnoremap <leader>eba     :e  $DOT/shells/bash/bash_aliases<cr>
nnoremap <leader>Eba     :sp $DOT/shells/bash/bash_aliases<cr>
nnoremap <leader><c-e>ba :vs $DOT/shells/bash/bash_aliases<cr>
nnoremap <leader>ebp     :e  $DOT/shells/bash/bash_profile<cr>
nnoremap <leader>Ebp     :sp $DOT/shells/bash/bash_profile<cr>
nnoremap <leader><c-e>b  :vs $DOT/shells/bash/bash_profile<cr>

nnoremap <leader>ezz     :e  $DOT/shells/zsh/zshrc<cr>
nnoremap <leader>Ezz     :sp $DOT/shells/zsh/zshrc<cr>
nnoremap <leader><c-e>zz :vs $DOT/shells/zsh/zshrc<cr>
nnoremap <leader>eza     :e  $DOT/shells/zsh/zsh_aliases<cr>
nnoremap <leader>Eza     :sp $DOT/shells/zsh/zsh_aliases<cr>
nnoremap <leader><c-e>za :vs $DOT/shells/zsh/zsh_aliases<cr>
nnoremap <leader>ezh     :e  $HOME/.zsh_history<cr>
nnoremap <leader>Ezh     :sp $HOME/.zsh_history<cr>
nnoremap <leader><c-e>zh :vs $HOME/.zsh_history<cr>

nnoremap <leader>ebn     :e  $DOT/inputrc<cr>
nnoremap <leader>Ebn     :sp $DOT/inputrc<cr>
nnoremap <leader><c-e>bn :vs $DOT/inputrc<cr>

nnoremap <leader>ec1     :e  $DOT/vim/colors/base16-onedark.vim<cr>
nnoremap <leader>ec2     :e  $DOT/vim/colors/base16-one-light.vim<cr>

" " rename file
" nnoremap <leader>mv :!mv % %:h:p/

"""        Git

" Show git log history
nnoremap <leader>gl :vert terminal git --no-pager log --all --decorate --oneline --graph<cr>:setlocal filename=""<cr>
" Show git log in location list
nnoremap ghl :Gllog! <bar> wincmd b <bar> wincmd L<cr>

"""        Terminal

tnoremap <c-n> <c-\><c-n>
tnoremap <c-@> <c-w>:

"""        Headers

nmap <leader>h1 <Plug>(Header42)

""    Move Mappings
"""        Movement

" insert mode delete / end of line / start of line
inoremap <c-l> <C-R>=pumvisible() ? "\<lt>C-l>" : "\<lt>del>"<CR>
inoremap <c-e> <C-R>=pumvisible() ? "\<lt>C-e>" : "\<lt>c-o>$"<CR>
inoremap <c-a> <C-R>=pumvisible() ? "\<lt>C-a>" : "\<lt>c-o>^"<CR>

" up down on visual lines
nnoremap <silent> <expr> j v:count? 'j' : '<cmd>normal gj<cr>'
nnoremap <silent> <expr> k v:count? 'k' : '<cmd>normal gk<cr>'

nnoremap gH H
nnoremap gL L

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

nnoremap H ^
nnoremap L $

" next / previous paragraph (or whitespace line)

onoremap <c-j> <cmd>call search("^\\s*$", 'e')<cr>
onoremap <c-k> <cmd>call search("^\\s*$", 'be')<cr>
nnoremap <c-j> <cmd>call search("^\\s*$")<cr>
nnoremap <c-k> <cmd>call search("^\\s*$", 'b')<cr>

vnoremap H ^
vnoremap L g_

"go to next / previous buffer
nnoremap <leader>] :bn<cr>
nnoremap <leader>[ :bp<cr>

" switch last 2 buffers
nnoremap <leader><space> :b#<cr>
vnoremap <leader><space> :b#<cr>

" last buffer in vertical split
nnoremap <c-w>#              :vs#<cr>
nnoremap <c-w><space><space> :vs#<cr>
vnoremap <c-w>#              :<c-u>vs#<cr>
vnoremap <c-w><space><space> :<c-u>vs#<cr>

" visual shifting (does not exit Visual mode)
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
" inoremap e <c-o>$
" inoremap a <c-o>^
" inoremap <esc> <c-o>:stopinsert<cr>

" " map <left> <right> for escape sequences
" inoremap <expr> <c-f> getcurpos()[2] == 1 && getline('.') != '' ? "<esc>a" : "<esc>a<right>"
" inoremap <expr> <c-b> getcurpos()[2] == 1 ? "<esc>i<left>" : '<esc>i'

if $WSL_DISTRO_NAME != ''
  for i in range(char2nr('a'), char2nr('z'))
    let char = nr2char(i)
    execute "set <M-".char.">=\e".char
    let char = nr2char(i - 32)
    execute "set <M-".char.">=\e".char
  endfor
endif

if ! has("nvim")
  inoremap <a-h> <left>
  inoremap <a-j> <down>
  inoremap <a-k> <up>
  inoremap <a-l> <right>
  cnoremap <a-h> <left>
  cnoremap <a-j> <down>
  cnoremap <a-k> <up>
  cnoremap <a-l> <right>
  nnoremap <silent> <a-h> :wincmd h<cr>
  nnoremap <silent> <a-j> :wincmd j<cr>
  nnoremap <silent> <a-k> :wincmd k<cr>
  nnoremap <silent> <a-l> :wincmd l<cr>
  tnoremap <silent> <a-h> <c-\><c-n>:wincmd h<cr>
  tnoremap <silent> <a-j> <c-\><c-n>:wincmd j<cr>
  tnoremap <silent> <a-k> <c-\><c-n>:wincmd k<cr>
  tnoremap <silent> <a-l> <c-\><c-n>:wincmd l<cr>
  nnoremap <silent> <a-H> :exe "vertical resize -1"<CR>
  nnoremap <silent> <a-J> :exe "resize -1"<cr>
  nnoremap <silent> <a-K> :exe "resize +1"<cr>
  nnoremap <silent> <a-L> :exe "vertical resize +1"<CR>
  nnoremap <silent> <a-o> :tabnext<cr>
  nnoremap <silent> <a-i> :tabprevious<cr>
  nnoremap <silent> <a-p> :normal g<tab><cr>
else
  inoremap <m-h> <left>
  inoremap <m-j> <down>
  inoremap <m-k> <up>
  inoremap <m-l> <right>
  cnoremap <m-h> <left>
  cnoremap <m-j> <down>
  cnoremap <m-k> <up>
  cnoremap <m-l> <right>
  nnoremap <silent> <m-h> :wincmd h<cr>
  nnoremap <silent> <m-j> :wincmd j<cr>
  nnoremap <silent> <m-k> :wincmd k<cr>
  nnoremap <silent> <m-l> :wincmd l<cr>
  tnoremap <silent> <m-h> <c-\><c-n>:wincmd h<cr>
  tnoremap <silent> <m-j> <c-\><c-n>:wincmd j<cr>
  tnoremap <silent> <m-k> <c-\><c-n>:wincmd k<cr>
  tnoremap <silent> <m-l> <c-\><c-n>:wincmd l<cr>
  nnoremap <silent> <m-H> :exe "vertical resize -1"<CR>
  nnoremap <silent> <m-J> :exe "resize -1"<cr>
  nnoremap <silent> <m-K> :exe "resize +1"<cr>
  nnoremap <silent> <m-L> :exe "vertical resize +1"<CR>
  nnoremap <silent> <m-o> :tabnext<cr>
  nnoremap <silent> <m-i> :tabprevious<cr>
  nnoremap <silent> <m-p> :normal g<tab><cr>
endif

nnoremap <silent> <leader>o  zt
nnoremap <silent> <leader>i  zb
nnoremap <silent> <c-w><c-o> :tabnext<cr>
nnoremap <silent> <c-w><c-i> :tabprevious<cr>
if has ("nvim")
  nnoremap <silent> <c-w><tab> :tabprevious<cr>
endif
nnoremap <silent> <c-w><c-u> :only<cr>
nnoremap <silent> <c-w>u     :only<cr>

"""        Searching

" Matchit : easier '%'
nmap <silent> <c-g>  <Plug>(MatchitNormalForward)
nmap <silent> <c-g>  <Plug>(MatchitNormalForward)
omap <silent> <c-g>  <Plug>(MatchitOperationForward)
nmap <silent> [<c-g> <Plug>(MatchitNormalMultiBackward)
nmap <silent> ]<c-g> <Plug>(MatchitNormalMultiForward)
xmap <silent> [<c-g> <Plug>(MatchitVisualMultiBackward)
xmap <silent> ]<c-g> <Plug>(MatchitVisualMultiForward)
omap <silent> [<c-g> <Plug>(MatchitOperationMultiBackward)
omap <silent> ]<c-g> <Plug>(MatchitOperationMultiForward)

nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar>set hlsearch<cr>:UpdateSearchMatch<cr>
nnoremap <silent> g* :let @/=expand('<cword>') <bar>set hlsearch<cr>:UpdateSearchMatch<cr>

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
  cnoremap <C-Space> <down>
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
nnoremap <leader>vp :find <cr>vim/plugin/

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

"""        Folding

nnoremap zM zMzb
nnoremap <silent> zm :set scrolloff=0<cr>zmzb:let &scrolloff=winheight(win_getid())/10 + 1<cr>
nnoremap <silent> zb :set scrolloff=0<cr>zb:let &scrolloff=winheight(win_getid())/10 + 1<cr>

"""        Windows

nnoremap <silent> <c-w><c-c> :let buff=bufname()<cr>:close<cr>:echo buff . " closed"<cr>
nnoremap <silent> <c-w>c     :let buff=bufname()<cr>:close<cr>:echo buff . " closed"<cr>

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
nnoremap g<c-g> :Nomove normal gg=G<cr>
nnoremap gG :Nomove normal =ap<cr>

"""        Toggle quickfix
" location list
nnoremap <expr> <leader>cl get(getloclist(0, {'winid':0}), 'winid', 0) ?
      \ ":lclose<cr>" : ":bot lopen<cr><c-w>p"

" quickfix list
nnoremap <expr> <leader>cq get(getqflist({'winid':0}), 'winid', 0) ?
      \ ":cclose<cr>" : ":bot copen<cr><c-w>p"
nnoremap <silent> <leader>cc :cc<cr>

"""        Make
nnoremap <leader>cm :VShell make<cr>
nnoremap <leader>cr :VShell make re<cr>
nnoremap <leader>c<c-r> :Shell make re<cr>
nnoremap <leader>cx :VShell make clean<cr>
nnoremap <leader>c<c-x> :VShell make fclean<cr>
nnoremap <leader>mm :make<cr><cr>:botright copen<cr><c-w>p

nmap <silent><leader>ch <Plug>(MoveScratchTermH)
nmap <silent><leader>cj <Plug>(MoveScratchTermJ)
nmap <silent><leader>ck <Plug>(MoveScratchTermK)
nmap <silent><leader>cl <Plug>(MoveScratchTermL)
nmap <silent><leader>cz <Plug>(MoveScratchTermQ)
nmap <silent><leader>ci <Plug>(ScrollScratchTermJ)
nmap <silent><leader>co <Plug>(ScrollScratchTermK)
nmap <silent><leader>c. <Plug>(RunShellCommandRe)

" Make in split
function! LocListPanel(pfx, side) abort
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

nnoremap <leader>csm :lmake!<cr>:call LocListPanel('l', 'J')<cr>
nnoremap <leader>csr :lmake! re<cr>:call LocListPanel('l', 'J')<cr>

"""        Count

function! FunctionLineCount() abort
  let firstline = search('^{', 'bn')
  let lastline = search('^}', 'n')
  echo "function lines :" lastline - firstline - 1
endfunction

nnoremap <leader>wcf :call FunctionLineCount()<cr>

"""        Doc
noremap <silent> <leader>K K

let g:markdown_fenced_languages = ['css', 'js=javascript']
