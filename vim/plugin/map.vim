""    General Mappings
"""        Modes

" space as leader, prompt '\' in command line window :)
map <space> <leader>

" closing easy
function! QuitBackToLast() abort
  quit
endfunction
nnoremap <silent> <leader>q :silent! call QuitBackToLast()<cr>
" -> this mapping does not focus the previous buffer
" nnoremap <leader>q :quit<cr>

" Delete Hidden Buffers
function! DeleteHiddenBuffers()
  let tpbl=[]
  let closed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let closed += 1
    endif
  endfor
  echo "Closed ".closed." hidden buffers"
endfunction
command! BwHidden call DeleteHiddenBuffers()

nnoremap <leader><c-@> :echo "kewl"<cr>

" enter command mode with ;
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <leader>; :!

nnoremap <silent> gI `.gi<esc>zz:call FitBufferWindowBottom()<cr>
nnoremap <silent> zz zz<bar>:call FitBufferWindowBottom()<cr>
nnoremap <silent> <leader>zz :let &scrolloff=999-&scrolloff<cr>

" no more default ex mode
nnoremap Q <nul>

" redraw
nnoremap <c-q> :redraw!<cr>

" repeat last macro
nnoremap - @@

" <c-z> in insert and command mode
inoremap <c-z> <c-[><c-z>
cnoremap <c-z> <c-[><c-z>

" <c-s> save and enter normal mode
function! VerboseUpdate() abort
  update
  echo(':update '.expand('%'))
endfunction

nnoremap <c-s> :call VerboseUpdate()<cr>
vnoremap <c-s> :call VerboseUpdate()<cr>
inoremap <c-s> <esc>:call VerboseUpdate()<cr>

" :W! save files as root
cnoremap <c-r><c-s> %!sudo tee > /dev/null %

"""        Toggles

" Toggle ModeColorSwitch
nmap yom <Plug>(modeColorToggle)

" Toggle concealed characters
function! ConcealToggle()
  " let &conceallevel = (&conceallevel ? '0' : '2')
  if &conceallevel
    set conceallevel=0
    echo "set conceallevel = 0"
  else
    set conceallevel=2
    echo "set conceallevel = 2"
  endif
endfunction
nnoremap yoq :call ConcealToggle()<cr>
" nnoremap yoq :let &conceallevel = (&conceallevel ? '0' : '2')<cr>

" Toggle / close / open Undotree
let g:undotree_SetFocusWhenToggle = 1
nnoremap you :UndotreeToggle<cr>
nnoremap [ou :UndotreeShow<cr>
nnoremap ]ou :UndotreeHide<cr>
nnoremap yo<c-u> :UndotreeFocus<cr>

" Obsession
nnoremap yoo :call ToggleObsession()<cr>

" Switch dark / light theme[
nnoremap <silent> yob :call DarkLightSwitch()<cr>

" Netrw toggle - left
nnoremap <silent> yoe :Lexplore<bar>:30wincmd\|<cr>

" Move visual selection (=unimpaired + gv)
vnoremap ]e :'<,'>move '>+1 \| normal! gv<CR>
vnoremap [e :'<,'>move '<-2 \| normal! gv<CR>

" Toggle of hlsearch + Anzu
nnoremap <silent> yoh :call anzu#clear_search_status()<cr>:nohlsearch<cr>

" Toggle terminal - bottom
nmap yot <Plug>(TermToggle)

" Toggle terminal - right
nmap yo<c-t> <Plug>(TermToggleV)

" Toggle terminal - pop
nmap yoT <Plug>(TermPop)

" Toggle keep cursor in middle of screen
nnoremap <silent> yoz :let &scrolloff=999-&scrolloff<cr>

" Load project files buffers
nnoremap yoj :call AutoProjectLoad('1')<cr>

" Goyo toggle
nnoremap yog :Goyo<cr>

"""        Copy / Paste / Delete

" select last paste
nnoremap gp V`]

" delete without saving to register
nnoremap <leader>d "_d
xnoremap <leader>d "_d
" xnoremap <leader>p "_dP

" System clipboard interraction
" paste from clipboard ...
nnoremap <leader>p mp"+]p==`p
nnoremap <leader>P mp"+]P==`p
" ... on new line ...
nnoremap <leader>op o<esc>"+]p==
" ... above
nnoremap <leader>oP O<esc>"+]p==
nnoremap <leader>Op O<esc>"+]p==
nnoremap <leader>OP O<esc>"+]p==

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
nnoremap <leader>fp :echo expand('%')<cr>

" show file path/name and copy it to unnamed register
nnoremap <leader>fP :let @"=expand('%:p')<cr>:echo expand('%:p')<cr>

" show file name and copy it to unnamed register
nnoremap <leader>f<c-p> :let @"=expand('%')<cr>:echo expand('%:p:h')<cr>

" new file here
nnoremap <leader>nn :e <c-r>=expand('%:p:h') . '/'<cr>
nnoremap <leader>nv :vs <c-r>=expand('%:p:h') . '/'<cr>
nnoremap <leader><c-n> :vs <c-r>=expand('%:p:h') . '/'<cr>

" Word count
function! WordCount() abort
  return system("detex " . expand("%") . " | wc -w | tr -d [[:space:]]") "words"
endfunction

command! -nargs=1 -complete=command Nomove
\   try
\ |     let s:svpos = winsaveview()
\ |     execute <q-mods> <q-args>
\ | finally
\ |     call winrestview(s:svpos)
\ |     unlet s:svpos
\ | endtry

function! CountRealLines()
    let l:count = 0
    Nomove g/^[^$,\"]/let l:count += 1
    return l:count
endfunction

nnoremap <leader>wcc :echo WordCount()<cr>
nnoremap <leader>wcl :echo CountRealLines()<cr>

" new file in vertical split instead of horizontal
nnoremap <c-w><c-n> :vertical new<cr>

" open file under cursor in vertical split instead of horizontal
nnoremap <c-w><c-f> :vertical wincmd f<cr>

" open file under cursor in a netrw pannel on the left
nnoremap <c-w><c-d> :Lexplore <cfile><cr>

"""        Folding

" Open / close fold with <c-space>
if ! has("nvim")
  nnoremap <c-@> za
  onoremap <c-@> <c-c>za
  vnoremap <c-@> zf
elseif has("nvim")
  nnoremap <c-space> za
  onoremap <c-space> <c-c>za
  vnoremap <c-space> zf
endif

" close every fold except current
nnoremap <leader>zc :normal! mzzMzv`z<CR>

" recursively open even partial folds
nnoremap zo zczO

"""        Dotfiles

" source vimrc
nnoremap <leader>sv :source $MYVIMRC<bar>:filetype detect<cr>
nnoremap <leader>sr :Runtime<cr>
nnoremap <leader>s. :Runtime<cr>
nnoremap <silent> <leader>sp :silent! Runtime ~/.vim/plugin/*.vim<cr>

" source colors
nnoremap <silent> <leader>s1 :source $HOME/.vim/colors/base16-onedark.vim<cr>
nnoremap <silent> <leader>s2 :source $HOME/.vim/colors/base16-one-light.vim<cr>

" edit dotfiles
nnoremap <leader>ev :e $HOME/dotfiles/vim/vimrc<cr>
nnoremap <leader>eV :split $HOME/dotfiles/vim/vimrc<cr>
nnoremap <leader>e<c-v> :vertical split $HOME/dotfiles/vim/vimrc<cr>
nnoremap <leader>et :e $HOME/dotfiles/tmux.conf<cr>
nnoremap <leader>eT :split $HOME/dotfiles/tmux.conf<cr>
nnoremap <leader>e<c-t> :vertical split $HOME/dotfiles/tmux.conf<cr>
nnoremap <leader>eb :e $HOME/dotfiles/bashrc<cr>
nnoremap <leader>eB :split $HOME/dotfiles/bashrc<cr>
nnoremap <leader>e<c-b> :vertical split $HOME/dotfiles/bashrc<cr>
nnoremap <leader>ea :e $HOME/dotfiles/bash_aliases<cr>
nnoremap <leader>eA :split $HOME/dotfiles/bash_aliases<cr>
nnoremap <leader>e<c-a> :vertical split $HOME/dotfiles/bash_aliases<cr>
nnoremap <leader>en :e $HOME/dotfiles/inputrc<cr>
nnoremap <leader>eN :split $HOME/dotfiles/inputrc<cr>
nnoremap <leader>e<c-n> :vertical split $HOME/dotfiles/inputrc<cr>
nnoremap <leader>ep :e $HOME/dotfiles/bash_profile<cr>
nnoremap <leader>eP :split $HOME/dotfiles/bash_profile<cr>
nnoremap <leader>e<c-p> :vertical split $HOME/dotfiles/bash_profile<cr>
nnoremap <leader>ec1 :e $HOME/dotfiles/vim/colors/base16-onedark.vim<cr>
nnoremap <leader>ec2 :e $HOME/dotfiles/vim/colors/base16-one-light.vim<cr>
nnoremap <leader>eo :CocConfig<cr>
nnoremap <leader>eO :split <bar> CocConfig<cr>
nnoremap <leader>e<c-o> :vertical split <bar> CocConfig<cr>

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

" insert mode delete
inoremap <c-l> <del>

" up down on visual lines
nnoremap <expr> j v:count? 'j' : 'gj'
nnoremap <expr> k v:count? 'k' : 'gk'
xnoremap <expr> j v:count? 'j' : 'gj'
xnoremap <expr> k v:count? 'k' : 'gk'

nnoremap <expr> <c-l> getline('.')[col('.')] == ' ' <bar><bar> getline('.')[col('.') - 1] == ' ' ? 'w' : 'E'
vnoremap <expr> <c-l> getline('.')[col('.')] == ' ' <bar><bar> getline('.')[col('.') - 1] == ' ' ? 'w' : 'E'
nnoremap <expr> <c-h> getline('.')[col('.') - 2] == ' ' <bar><bar> getline('.')[col('.') - 1] == ' ' ? 'gE' : 'B'
vnoremap <expr> <c-h> getline('.')[col('.') - 2] == ' ' <bar><bar> getline('.')[col('.') - 1] == ' ' ? 'gE' : 'B'

nnoremap H ^
nnoremap L $
nnoremap <c-k> {
nnoremap <c-j> }

vnoremap H ^
vnoremap L g_
vnoremap <c-k> {
vnoremap <c-j> }

"go to next / previous buffer
nnoremap <leader>] :bn<cr>
nnoremap <leader>[ :bp<cr>

" switch last 2 buffers
nnoremap <leader><space> <c-^>
" onoremap <leader><space> <c-^>
vnoremap <leader><space> <c-^>

" last buffer in vertical split
nnoremap <c-w><space><space> :vertical split #<cr>
" onoremap <c-w><space><space> :vertical split #<cr>
vnoremap <c-w><space><space> :vertical split #<cr>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" open buffer with partial search
" nnoremap <leader>b :buffer<space>
" nnoremap <leader><c-b> :vertical sbuffer<space>
" nnoremap <leader>B :sbuffer<space>
" nnoremap <leader>T :vertical sbuffer !/bin/bash<cr>

"""        Alt Movement

" Allow <alt> key mappings
if has('nvim-0.4.0')

  inoremap <M-h> <left>
  inoremap <M-j> <down>
  inoremap <M-k> <up>
  inoremap <M-l> <right>

  nnoremap <silent> <M-k> :wincmd k<cr>
  nnoremap <silent> <M-j> :wincmd j<cr>
  nnoremap <silent> <M-l> :wincmd l<cr>
  nnoremap <silent> <M-h> :wincmd h<cr>

  tnoremap <silent> <M-k> <c-\><c-n>:wincmd k<cr>
  tnoremap <silent> <M-j> <c-\><c-n>:wincmd j<cr>
  tnoremap <silent> <M-l> <c-\><c-n>:wincmd l<cr>
  tnoremap <silent> <M-h> <c-\><c-n>:wincmd h<cr>

  cnoremap <M-h> <left>
  cnoremap <M-j> <down>
  cnoremap <M-k> <up>
  cnoremap <M-l> <right>

  nnoremap <silent> <M-K> :exe "resize +1"<cr>
  nnoremap <silent> <M-J> :exe "resize -1"<cr>
  nnoremap <silent> <M-L> :exe "vertical resize +1"<CR>
  nnoremap <silent> <M-H> :exe "vertical resize -1"<CR>

else

  "hack for terminals without modifyOtherKeys feature
  let c='a'
  while c <= 'z'
    if c == 'p'
      let c = nr2char(1+char2nr(c))
    endif
    let d=toupper(c)
    exec "set <M-".c.">=\e".c
    exec "imap \e".c." <M-".c.">"
    exec "set <M-".d.">=\e".d
    exec "imap \e".d." <M-".d.">"
    let c = nr2char(1+char2nr(c))
  endw

  exe "set <F31>=\eh"
  exe "set <F32>=\ej"
  exe "set <F33>=\ek"
  exe "set <F34>=\el"
  exe "set <F35>=\ep"

  exe "set <S-F31>=\eH"
  exe "set <S-F32>=\eJ"
  exe "set <S-F33>=\eK"
  exe "set <S-F34>=\eL"
  exe "set <S-F35>=\eP"

  inoremap <F31> <left>
  inoremap <F32> <down>
  inoremap <F33> <up>
  inoremap <F34> <right>

  nnoremap <silent> <F31> :wincmd h<cr>
  nnoremap <silent> <F32> :wincmd j<cr>
  nnoremap <silent> <F33> :wincmd k<cr>
  nnoremap <silent> <F34> :wincmd l<cr>
  nnoremap <silent> <F35> :wincmd p<cr>

  cnoremap <F31> <left>
  cnoremap <F32> <down>
  cnoremap <F33> <up>
  cnoremap <F34> <right>

  nnoremap <silent> <S-F31> :exe "resize -1"<cr>
  nnoremap <silent> <S-F32> :exe "vertical resize -1"<CR>
  nnoremap <silent> <S-F33> :exe "vertical resize +1"<CR>
  nnoremap <silent> <S-F34> :exe "resize +1"<cr>
endif

" resize windows quicker
nnoremap <leader>= :exe "resize +10"<cr>
nnoremap <leader>- :exe "resize -10"<cr>
nnoremap <leader>> :exe "vertical resize +10"<CR>
nnoremap <leader>< :exe "vertical resize -10"<CR>

nnoremap <silent> <M-K> :exe "resize +1"<cr>
nnoremap <silent> <M-J> :exe "resize -1"<cr>
nnoremap <silent> <M-L> :exe "vertical resize +1"<CR>
nnoremap <silent> <M-H> :exe "vertical resize -1"<CR>

"""        Searching

" Pair cycle
nnoremap <c-g> %

nnoremap / :call clearmatches()<cr>/
nnoremap <leader>/ :call clearmatches()<cr>/\v
vnoremap <leader>/ :call clearmatches()<cr>/\v

nnoremap <silent> n :call NextPrevSearch('n')<cr>
nnoremap <silent> N :call NextPrevSearch('N')<cr>

"do not move cursor with first match
nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>:call HLCurrent()<cr>
nnoremap <silent> g* :let @/=expand('<cword>') <bar> set hls <cr>

" search visual selection
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

"""        Command Line

cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-k> <Up>
cnoremap <c-j> <Down>
cnoremap <c-b> <Left>
cnoremap <c-l> <S-Right>
cnoremap <c-x> <c-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<cr>
cnoremap <c-o> <s-tab>
cnoremap <c-r><c-l> <c-r>=substitute(getline('.'), '^\s*', '', '')<cr>
cnoreabbrev <expr> qqq getcmdtype() == ':' && getcmdline() =~ "^qqq$" ? "qall!" : "qqq"

" cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
cnoremap <c-r><c-5> <C-R>=fnameescape(expand('%:h')).'/'<cr>
nnoremap <leader>vp :find <cr>vim/plugin/

"""        Tags

" show matching tags
nnoremap g<c-]> g]
command! Ctags exe ":!.git/hooks/ctags >/dev/null 2>&1 &" | call feedkeys("\<c-m>", t)
" command! CTags call DeleteHiddenBuffers()

" jump if only one match
nnoremap g] g<c-]>

"""        Select lines starting with same world

function! SelectFirstWordBlock(all) abort
  let curpos = getpos('.')
  let curline = curpos[1]
  let nextline = curline + 1
  let firstword = split(trim(getline('.')), '\W\+')[0]
  while (a:all == 1 && split(trim(getline(nextline)), '\W\+')[0] =~ firstword)
    let nextline += 1
  endwhile
  while (a:all == 0 && split(trim(getline(nextline)), '\W\+')[0] ==# firstword)
    let nextline += 1
  endwhile
  if mode() !~? '[v]'
    normal! V
  endif
  call cursor(nextline - 1, 0)
endfunction

function! SelectFirstWordBlockVisual() abort
  let curpos = getpos('.')
  let curline = curpos[1]
  let nextline = curline + 1
  let firstword = @*
  while (getline(nextline) =~ firstword)
    let nextline += 1
  endwhile
  if mode() !~? '[v]'
    normal! V
  endif
  call cursor(nextline - 1, 0)
endfunction

vnoremap <c-p> :call SelectFirstWordBlockVisual()<cr>
nnoremap <leader>V :silent! call SelectFirstWordBlock('1')<cr>
nnoremap <leader><c-v> :silent! call SelectFirstWordBlock('0')<cr>

"""        Folding

nnoremap zM zMzb
nnoremap <silent> zm :set scrolloff=0<cr>zmzb:let &scrolloff=winheight(win_getid())/10 + 1<cr>
nnoremap <silent> zb :set scrolloff=0<cr>zb:let &scrolloff=winheight(win_getid())/10 + 1<cr>

""    Code Mappings
"""        General

" indent all file easy
nnoremap g<c-g> :Nomove normal gg=G<cr>
nnoremap gG :Nomove normal =ap<cr>

" Toggle location list (awesome)
nnoremap <expr> <leader>cl get(getloclist(0, {'winid':0}), 'winid', 0) ?
      \ ":lclose<cr>" : ":bot lopen<cr><c-w>p"

" Toggle quickfix list (awesome)
nnoremap <expr> <leader>cq get(getqflist({'winid':0}), 'winid', 0) ?
      \ ":cclose<cr>" : ":bot copen<cr><c-w>p"

" trim current line or all file
function! TrimLines(scope)
  try
    if a:scope ==? 'line'
      Nomove s/\s\+$//
    elseif a:scope ==? 'buffer'
      Nomove %s/\s\+$//
    endif
  catch /E486:\ Pattern\ not found.*/
    echo "TrimLine: No line to trim"
  endtry
endfunction
nnoremap <silent> <leader>xx :call TrimLines('line')<cr>
nnoremap <leader>xX :call TrimLines('buffer')<cr>

" Make
nnoremap <leader>cm :make<cr>
nnoremap <leader>cr :VShell make re<cr>
nnoremap <leader>c<c-r> :Shell make re<cr>

nmap <silent><leader>ch <Plug>(MoveScratchTermH)
nmap <silent><leader>cj <Plug>(MoveScratchTermJ)
nmap <silent><leader>ck <Plug>(MoveScratchTermK)
nmap <silent><leader>cl <Plug>(MoveScratchTermL)
nmap <silent><leader>cz <Plug>(MoveScratchTermQ)
nmap <silent><leader>cJ <Plug>(ScrollScratchTermJ)
nmap <silent><leader>cK <Plug>(ScrollScratchTermK)
nmap <silent><leader>c. <Plug>(RunShellCommandRe)

function! LocListPanel(pfx, side) abort
  let winnr = winnr()
  exec(a:pfx.'open')
  if &filetype == 'qf'
    exe "wincmd" a:side
  endif
  if winnr() != winnr
    wincmd p
  endif
endfunction

" Make in spit
nnoremap <leader>csm :lmake!<cr>:call LocListPanel('l', 'J')<cr>
nnoremap <leader>csr :lmake! re<cr>:call LocListPanel('l', 'J')<cr>

function! FunctionLineCount() abort
  let firstline = search('^{', 'bn')
  let lastline = search('^}', 'n')
  echo "function lines :" lastline - firstline - 1
endfunction

nnoremap <leader>wcf :call FunctionLineCount()<cr>

"""        Coc

" let g:coc_user_config = {
"       \ "languageserver.groovy.args": ["-jar", "/home/tris/dotfiles/langserver/groovy-language-server/build/libs/groovy-language-server.jar"],
" 			\ "languageserver.efm.args": ["-c", "/home/tris/dotfiles/langserver/efm-langserver/config.yaml"]
"       \ }

" fix error when using tabs in middle of line
if v:version < 802
  inoremap <c-i> <c-v><c-i>
endif

" pmenu mappings
if has("nvim")
  inoremap <expr> <c-space> pumvisible() ? coc#_select_confirm() : coc#refresh()
else
  inoremap <expr> <c-@> pumvisible() ? coc#_select_confirm() : coc#refresh()
endif

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>:call NoScrollAtEOF()\<cr>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : coc#refresh()
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : coc#refresh()
hi link CocHilightText Visual

" inoremap <expr> <c-n> pumvisible() ? "\<C-p>" : coc#refresh()
let g:coc_snippet_next = '<c-f>'
let g:coc_snippet_prev = '<c-b>'

" use tab as in VSCode
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

" function text object mappings
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nmap <silent> <leader>gf <Plug>(coc-definition)
nmap <silent> <leader>gd <Plug>(coc-declaration)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)
nmap <leader>cf  <Plug>(coc-fix-current)

" Coc List
nnoremap <leader>fv :CocFzfList<cr>

" rename word
nmap <leader>rn <Plug>(coc-rename)

" show doc with Coc
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation() abort
  if &filetype ==# 'vim'
    exe "normal \<Plug>ScripteaseHelp"
  elseif &filetype ==# 'help'
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight symbol under cursor on CursorHold (K)
augroup CocHiglightSymbol
  au!
  au CursorHold * silent call CocActionAsync('highlight')
augroup end

augroup CocFormatAndK
  au!
  " Setup formatexpr specified filetype(s).
  au FileType typescript,json setlocal formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

let g:markdown_fenced_languages = ['css', 'js=javascript']

""    Operators
"""        Next Surroundings
onoremap in( :<c-u>normal! f(lvt)<cr>
onoremap in) :<c-u>normal! ()f(lvt)<cr>
onoremap an( :<c-u>normal! f(vf)<cr>
onoremap an) :<c-u>normal! f(vf)<cr>
onoremap iN( :<c-u>normal! F)vT(oh<cr>
onoremap iN) :<c-u>normal! F)vT(oh<cr>
onoremap aN( :<c-u>normal! F(vf)<cr>
onoremap aN) :<c-u>normal! F)vF(<cr>

onoremap in{ :<c-u>normal! f{lvt}<cr>
onoremap in} :<c-u>normal! f{lvt}<cr>
onoremap an{ :<c-u>normal! f{vf}<cr>
onoremap an} :<c-u>normal! f{vf}<cr>
onoremap iN{ :<c-u>normal! F}vT{oh<cr>
onoremap iN} :<c-u>normal! F}vT{oh<cr>
onoremap aN{ :<c-u>normal! F}vF{<cr>
onoremap aN} :<c-u>normal! F}vF{<cr>

onoremap in[ :<c-u>normal! f[lvt]<cr>
onoremap in] :<c-u>normal! f[lvt]<cr>
onoremap an[ :<c-u>normal! f[vf]<cr>
onoremap an] :<c-u>normal! f[vf]<cr>
onoremap iN[ :<c-u>normal! F]vT[oh<cr>
onoremap iN] :<c-u>normal! F]vT[oh<cr>
onoremap aN[ :<c-u>normal! F]vF[<cr>
onoremap aN] :<c-u>normal! F]vF[<cr>

onoremap in< :<c-u>normal! f<lvt><cr>
onoremap in> :<c-u>normal! f<lvt><cr>
onoremap an< :<c-u>normal! f<vf><cr>
onoremap an> :<c-u>normal! f<vf><cr>
onoremap iN< :<c-u>normal! F>vT<oh<cr>
onoremap iN> :<c-u>normal! F>vT<oh<cr>
onoremap aN< :<c-u>normal! F>vF<<cr>
onoremap aN> :<c-u>normal! F>vF<<cr>
