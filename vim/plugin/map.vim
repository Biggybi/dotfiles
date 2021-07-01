""    General Mappings
"""        Modes

" space as leader, prompt '\' in command line window :)
" map <space> <leader>

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
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
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
function! ConcealToggle() abort
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
nnoremap <silent> yob :DarkLightSwitch<cr>
nnoremap <silent> [ob :DarkLightFirst<cr>
nnoremap <silent> ]ob :DarkLightLast<cr>

" Netrw toggle - left
let s:netrw_winsize=0
function! NetrwToggle() abort
  Lexplore
  if &ft==#"netrw"
    if s:netrw_winsize == 0
      let s:netrw_winsize = g:netrw_winsize
    endif
    exe s:netrw_winsize . "wincmd|"
  endif
endfunction
nnoremap <silent> yoe :call NetrwToggle()<cr>

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
xnoremap <leader>p "_dP

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
command! -nargs=1 -complete=command Nomove
\   try
\ |     let s:svpos = winsaveview()
\ |     execute <q-mods> <q-args>
\ | finally
\ |     call winrestview(s:svpos)
\ |     unlet s:svpos
\ | endtry


" new file in vertical split instead of horizontal
nnoremap <silent> <c-w><c-n> :vertical new<cr>

" open file under cursor in vertical split instead of horizontal
nnoremap <silent> <c-w><c-f> :vertical wincmd f<cr>

" open file under cursor in a netrw pannel on the left
nnoremap <silent> <c-w><c-d> :Lexplore <cfile><cr>

" start command for all windows / arguments
nnoremap <c-w>; :windo<space>
nnoremap <c-w>: :argdo<space>

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
nnoremap <leader>Ev :split $HOME/dotfiles/vim/vimrc<cr>
nnoremap <leader><c-e>v :vertical split $HOME/dotfiles/vim/vimrc<cr>
nnoremap <leader>et :e $HOME/dotfiles/tmux/tmux.conf<cr>
nnoremap <leader>Et :split $HOME/dotfiles/tmux/tmux.conf<cr>
nnoremap <leader><c-e>t :vertical split $HOME/dotfiles/tmux/tmux.conf<cr>

nnoremap <leader>ebb :e $HOME/dotfiles/shells/bash/bashrc<cr>
nnoremap <leader>Ebb :split $HOME/dotfiles/shells/bash/bashrc<cr>
nnoremap <leader><c-e>bb :vertical split $HOME/dotfiles/shells/bash/bashrc<cr>
nnoremap <leader>eba :e $HOME/dotfiles/shells/bash/bash_aliases<cr>
nnoremap <leader>Eba :split $HOME/dotfiles/shells/bash/bash_aliases<cr>
nnoremap <leader><c-e>ba :vertical split $HOME/dotfiles/shells/bash/bash_aliases<cr>
nnoremap <leader>ebp :e $HOME/dotfiles/shells/bash/bash_profile<cr>
nnoremap <leader>Ebp :split $HOME/dotfiles/shells/bash/bash_profile<cr>
nnoremap <leader><c-e>b :vertical split $HOME/dotfiles/shells/bash/bash_profile<cr>

nnoremap <leader>ezz :e $HOME/dotfiles/shells/zsh/zshrc<cr>
nnoremap <leader>Ezz :split $HOME/dotfiles/shells/zsh/zshrc<cr>
nnoremap <leader><c-e>zz :vertical split $HOME/dotfiles/shells/zsh/zshrc<cr>
nnoremap <leader>eza :e $HOME/dotfiles/shells/zsh/zsh_aliases<cr>
nnoremap <leader>Eza :split $HOME/dotfiles/shells/zsh/zsh_aliases<cr>
nnoremap <leader><c-e>za :vertical split $HOME/dotfiles/shells/zsh/zsh_aliases<cr>

nnoremap <leader>ebn :e $HOME/dotfiles/inputrc<cr>
nnoremap <leader>Ebn :split $HOME/dotfiles/inputrc<cr>
nnoremap <leader><c-e>bn :vertical split $HOME/dotfiles/inputrc<cr>

nnoremap <leader>ec1 :e $HOME/dotfiles/vim/colors/base16-onedark.vim<cr>
nnoremap <leader>ec2 :e $HOME/dotfiles/vim/colors/base16-one-light.vim<cr>
nnoremap <leader>eo :CocConfig<cr>
nnoremap <leader>Eo :split <bar> CocConfig<cr>
nnoremap <leader><c-e>o :vertical split <bar> CocConfig<cr>

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
nnoremap <silent> <expr> j v:count? 'j' : ':normal gj<cr>'
nnoremap <silent> <expr> k v:count? 'k' : ':normal gk<cr>'

" navigate between start/end of WORD
nnoremap <silent> <expr> <c-l> getline('.')[col('.')] == ' '
      \ <bar><bar> getline('.')[col('.') - 1] == ' '
      \ <bar><bar> col('.') == col('$') - 1
      \ <bar><bar> col('$') == 1
      \ ? 'w' : 'E'
vnoremap <expr> <c-l> getline('.')[col('.') - 2] == ' '
      \ <bar><bar> getline('.')[col('.') - 1] == ' '
      \ <bar><bar> col('$') == 1
      \ <bar><bar> col('.') == 1
      \ ? 'w' : 'E'

nnoremap <silent> <expr> <c-h> getline('.')[col('.') - 2] == ' '
      \ <bar><bar> getline('.')[col('.') - 1] == ' '
      \ <bar><bar> col('$') == 1
      \ <bar><bar> col('.') == 1
      \ ? 'gE' : 'B'
vnoremap <expr> <c-h> getline('.')[col('.') - 2] == ' '
      \ <bar><bar> getline('.')[col('.') - 1] == ' '
      \ <bar><bar> col('$') == 1
      \ <bar><bar> col('.') == 1
      \ ? 'gE' : 'B'

nnoremap H ^
nnoremap L $
nnoremap <c-k> {
nnoremap <c-j> }

function! VisualBlockParagraphJump(down) abort
  normal gv
  let [curline, curcol] = getcurpos('.')[1:2]
  let new_line = -1
  if a:down == 1
    if line('.') >= line('$') - 2
      normal 2j
      return
    endif
    if getline(line('.') + 1)[0] == ''
      normal 2j
    endif
    let new_line = search('^$', 'W') - 1
    exe 'normal' curline - new_line . 'k'
  else
    if getline(line('.') - 1)[0] == ''
      normal 2k
    endif
    let new_line = search('^$', 'Wb') + 1
    exe 'normal' new_line - curline . 'j'
  endif
  if new_line != -1
    call cursor(new_line, curcol)
  endif
endfunction

vnoremap <silent> <c-k> :<c-u>call VisualBlockParagraphJump('0')<cr>
vnoremap <silent> <c-j> :<c-u>call VisualBlockParagraphJump('1')<cr>

vnoremap H ^
vnoremap L g_

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

" resize windows quicker
nnoremap <leader>= :exe "resize +10"<cr>
nnoremap <leader>- :exe "resize -10"<cr>
nnoremap <leader>> :exe "vertical resize +10"<CR>
nnoremap <leader>< :exe "vertical resize -10"<CR>

"""        Alt Movement

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

"""        Searching

" Pair cycle
nnoremap <c-g> %

nnoremap / :silent call clearmatches()<cr>/
nnoremap ? :silent call clearmatches()<cr>?
nnoremap <leader>/ :silent call clearmatches()<cr>/\v
vnoremap <leader>/ :silent call clearmatches()<cr>/\v

nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar>set hlsearch<cr>:UpdateSearchMatch<cr>
nnoremap <silent> g* :let @/=expand('<cword>') <bar>set hlsearch<cr>:UpdateSearchMatch<cr>

" search visual selection
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

"""        Command Line

" Basic moves
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-k> <up>
cnoremap <c-j> <down>
cnoremap <c-@> <down>
cnoremap <c-b> <left>
cnoremap <c-l> <s-right>
cnoremap <c-o> <s-tab>

" delete from cursor
cnoremap <c-x> <c-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<cr>

" skyrim quit
cnoreabbrev <expr> qqq getcmdtype() == ':' && getcmdline() =~ "^qqq$" ? "qall!" : "qqq"

" put current working directory
cnoremap <c-r>. <c-r>=fnameescape(expand('%:h')).'/'<cr>
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

" Make
nnoremap <leader>cm :make<cr><cr>
nnoremap <leader>cr :VShell make re<cr>
nnoremap <leader>c<c-r> :Shell make re<cr>
nnoremap <leader>cx :VShell make clean<cr>
nnoremap <leader>c<c-x> :VShell make fclean<cr>

nmap <silent><leader>ch <Plug>(MoveScratchTermH)
nmap <silent><leader>cj <Plug>(MoveScratchTermJ)
nmap <silent><leader>ck <Plug>(MoveScratchTermK)
nmap <silent><leader>cl <Plug>(MoveScratchTermL)
nmap <silent><leader>cz <Plug>(MoveScratchTermQ)
nmap <silent><leader>ci <Plug>(ScrollScratchTermJ)
nmap <silent><leader>co <Plug>(ScrollScratchTermK)
nmap <silent><leader>c. <Plug>(RunShellCommandRe)

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

" Make in split
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
noremap <silent> <leader>K K

function! s:show_documentation() abort
  if &filetype ==# 'vim'
    try
      exe "normal \<Plug>ScripteaseHelp"
    catch /^Vim\%((\a\+)\)\=:E149:/
      echo "sorry : no help for " . expand("<cword>")
    endtry
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
