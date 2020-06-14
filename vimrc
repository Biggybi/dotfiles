" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    vimrc                                              :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: tris <tris@tristankapous.com>              +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2016/04/14 18:58:30 by tris              #+#    #+#              "
"    Updated: 2020/05/29 04:18:38 by tris             ###   ########lyon.fr    "
"                                                                              "
" **************************************************************************** "

""    Settings
"""        Pathogen

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

"""        General settings

runtime! ftplugin/man.vim
if ! has("nvim")
	packadd! matchit
	packadd! termdebug
endif

filetype plugin on                   " use filetype plugin
filetype on
filetype indent on                   " use indent plugin
set keywordprg=:Man

let $BASH_ENV = "$HOME/dotfiles/bash_aliases"  " use aliases in vim
let $PAGER=''                        " vim as pager

syntax on
if &compatible                       " condition avoid pile-up
	set nocompatible                   " not compatible with vi
endif
set encoding=utf-8                   " character encoding
scriptencoding utf8
set ttyfast                          " faster redrawing
set nolazyredraw                     " no redraw executing macros

"""        Restore

" Session restore
set sessionoptions-=options
set viewoptions=cursor,folds    "only these settins
" restore undo history
if exists('+undofile')
	set undofile
endif

set history=10000               " long history
set hidden

if exists('$SUDO_USER')         " don't create root-owned files
	set noswapfile
	set nobackup
	set nowritebackup
	set noundofile
	set viminfo=
else
	set backupdir=$HOME/.vim/tmp/backup//
	set directory=$HOME/.vim/tmp/swap//
	set undodir=$HOME/.vim/tmp/undo//
	set viewdir=$HOME/.vim/tmp/view//
	if has("nvim")
		set viminfo+=n$HOME/.vim/tmp/nviminfo
	else
		set viminfo+=n$HOME/.vim/tmp/viminfo
	endif
endif

set autoread                    " auto load file changes
" set autowrite                   " auto save file changes
set modelineexpr                " flexible modeline set

"""        User Interface settings

" Title
set title                       " window title (file)

" Mappings chill
set notimeout                   " no timeout on maps
set ttimeout                    " timeout on keycodes
set ttimeoutlen=10              " of 10 ms
set mouse=a                     " it's a secret

" search
set magic                       " set magic on, for regex
set ignorecase                  " case insensitive search
set smartcase                   " case-sens if cap
set hlsearch                    " highlight all searches
set incsearch                   " highlight match while typing
" set path+=**                  " recursive path from current path
" ignore some files from wildcard expansion
set nrformats-=octal            " <c-a>/<c-x> do not use octals

set wildignore+=**/__pycache__/**
set wildignore+=**/venv/**
set wildignore+=**/node_modules/**
set wildignore+=**/dist/**
set wildignore+=**/build/**
set wildignore+=*.o
set wildignore+=*.pyc
set wildignore+=*.swp

" Command line window
set cmdheight=2                 " Command-line height
set showcmd                     " show command
set wildmenu                    " show matches to commands
set wildchar=<tab>              " complete w/ tab
set wildmode=longest,full
set completeopt+=longest        " complete matching string
set completeopt+=menuone        " pmenu on single match too
set fileignorecase              " ignore case using filename
set wildignorecase              " ignore case completing filenames

" status line
set laststatus=2                " always show satus line
set ruler                       " show cursor line / column
set noshowmode
" set statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P  " show buffer number

" Shortmess : 'hit enter' prompt custzomization
set shortmess+=A                " Always edit if swap exists
set shortmess+=f                " Abbrev file count
set shortmess+=i                " Abbrev line without end
set shortmess+=l                " Abbrev line and word count
set shortmess+=m                " Abbrev modified
set shortmess+=n                " Abbrev new file
set shortmess+=r                " Abbrev read only
set shortmess+=w                " Abbrev writter
set shortmess+=x                " Abbrev dos and mac format
set shortmess+=W                " No message when writing
set shortmess+=F                " As if silent autocomands
set shortmess+=c                " No ins completion message
set shortmess+=s                " No "search hit BOTTOM" message

" Bell
set visualbell                  " do not ring the bell
set noerrorbells                " no bell for error messages
set t_vb=                       " no bell at all

" tabulation control
set noexpandtab                 " tabs ftw
set smarttab                    " tab width start of line
set tabstop=4                   " visible width of tabs
set softtabstop=4               " tabs 4 characters wide
set shiftwidth=4                " indents 4 characters wide
set autoindent                  " automatically indent new line
set smartindent                 " ...in a sane way
set shiftround                  " indent congru shiftwidth

" splits
set switchbuf=usetab            " open buffer window if exists
set splitbelow                  " default split below
set splitright                  " default split right
" set list

" guides smartisation
set fillchars+=vert:▎
set listchars=tab:\▎\ ,trail:-  " only tab / trailing ws
set spellcapcheck=              " ignore leading cap in word
set formatoptions+=j            " join comments smartly
set nojoinspaces                " and spaces too
set suffixesadd=.tex,.latex,.java,.c,.h,.js    " match file w/ ext

" Main window
set display+=lastline           " show lastline even if too long
set number                      " show number column
set wrap                        " no horizontal scroll
set breakindent                 " with indent
set showbreak=¬                 " ... showing a character

" Moves boundaries
set backspace=indent,eol,start  " backspace over lines
set whichwrap+=<,>,h,l,[,]      " break cursor free
set virtualedit=block           " visual selection broken free
set nostartofline               " vertical moves in same column
set sidescrolloff=5             " min horizontal cursor offset
let &scrolloff=winheight(win_getid())/10 + 1  " min vertical cursor offset
" set iskeyword+=,              " considered part of <cword>

" Folding
set foldmethod=syntax           " fold based on indent
set foldnestmax=2               " deepest fold is 10 levels
set nofoldenable                " don't fold by default

" Colors
let base16colorspace=256        " access 256 colorspace
set t_Co=256                    " say terminal supports 256
if has("termguicolors")
	set termguicolors             " 24 bits colors
endif

" False cursorline to have CursorLineNr working
set cursorline

""    Look / Theme
"""        DarkLightSwitch

" switch between light and dark theme (UI + ligtline)
function! DarkLightSwitch() abort
	if g:DarkLightSwitch ==# 'dark'
		set background=dark
		colorscheme	base16-onedark
		let g:DarkLightSwitch = 'light'
	elseif g:DarkLightSwitch ==# 'light'
		set background=light
		colorscheme	base16-one-light
		let g:DarkLightSwitch = 'dark'
	endif
	if exists("g:DarkLightOn")
	endif
	let g:DarkLightOn = 1
endfunction

let g:DarkLightMod = 3
" 0: auto, sensible to sourcing
" 1: force dark
" 2: force light
" 3: auto, keep current when sourcing

" open vim with different color based on time of day

if g:DarkLightMod == 0 || g:DarkLightMod == 3
	let hour = strftime("%H")
	if 8 <= hour && hour <= 17
		let g:DarkLightSwitch = 'light'
	else
		let g:DarkLightSwitch = 'dark'
	endif
endif
if g:DarkLightMod == 0
	call DarkLightSwitch()
elseif g:DarkLightMod == 1
	let g:DarkLightSwitch = 'dark'
	call DarkLightSwitch()
elseif g:DarkLightMod == 2
	let g:DarkLightSwitch = 'light'
	call DarkLightSwitch()
elseif g:DarkLightMod == 3
	if ! exists("g:DarkLightOn")
		call DarkLightSwitch()
		let g:DarkLightMod = -1
	endif
endif
" nnoremap <silent> <leader>sc :call DarkLightSwitch()<cr>
nnoremap <silent> <leader>sc :call DarkLightSwitch()<cr>

"""        Title

augroup WinTitle
	au!
	au BufRead,BufEnter * let &titlestring = MyWindowTitle()
augroup end

function! GetGitRepoName(file) abort
	let l:path=fnamemodify(a:file, ':p')
	while l:path != '' && l:path != '/'
		let l:path=fnamemodify(l:path, ':h')
		let l:candidate=l:path . '/.git'
		let l:folder=substitute(l:path, '/.*/', '', '')
		if isdirectory(l:path . '/.git')
			return l:folder
		endif
	endwhile
	return ''
endfunction

function! MyWindowTitle() abort
	let l:hostname = hostname() . "   ▏ "
	let l:file = substitute(expand('%'), '/.*/', '', '')
	let gitrepo = GetGitRepoName('%') . "   〉  "
	return(hostname . gitrepo . file)
endfunction

"""        Cursor

if &term =~ "xterm\\|rxvt"
	let &t_SI = "\e[5 q"       " insert mode
	let &t_EI = "\e[2 q"       " normal mode
	let &t_SR = "\e[4 q"       " replace mode
endif

""    Extra windows
"""        Terminal

" Show terminal (like c-z), exit on any character
function! ShowTerm() abort
	silent !read -sN 1
	redraw!
endfunction
nnoremap [= :call ShowTerm()<cr>

let s:term_buf_nr = -1
function! s:ToggleTerminal() abort
		if s:term_buf_nr == -1
				execute "botright terminal"
				resize 6
				let s:term_buf_nr = bufnr("$")
		else
				try
						execute "bdelete! " . s:term_buf_nr
				catch
						let s:term_buf_nr = -1
						call <SID>ToggleTerminal()
						return
				endtry
				let s:term_buf_nr = -1
		endif
endfunction

"""        Quickfix

augroup QuickFixWindowSet
	au!
	au FileType qf setlocal colorcolumn=0 nolist nocursorline tw=0 norelativenumber showbreak=

	" vimscript is a joke
	au FileType qf nnoremap <buffer> <cr> :execute "normal! \<lt>cr>"<cr>
	" auto adjust height if not a vertical split (hopefuly)
	au Filetype qf nnoremap <buffer> j <c-n>
	au Filetype qf nnoremap <buffer> k <c-p>
	au FileType qf
				\ if winheight('quickfix') + 3 < &lines |
				\ call AdjustWindowHeight(1, 5) |
				\ endif
	au QuickfixCmdPost make call QfMakeConv()
augroup end

" Change encoding of error file for quickfix
function! QfMakeConv() abort
	let qflist = getqflist()
	for i in qflist
		let i.text = iconv(i.text, "cp936", "utf-8")
	endfor
	call setqflist(qflist)
endfunction

" Quickfix window height auto adjust if too big
function! AdjustWindowHeight(minheight, maxheight)
	let l = 1
	let n_lines = 0
	let w_width = winwidth(0)
	while l <= line('$')
		" number to float for division
		let l_len = strlen(getline(l)) + 0.0
		let line_width = l_len/w_width
		let n_lines += float2nr(ceil(line_width))
		let l += 1
	endw
	exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Auto location list on make
" augroup AutoLocationWindow
" 	au!
" 	autocmd QuickFixCmdPost [^l]* nested lwindow
" 	autocmd QuickFixCmdPost    l* nested lwindow
" augroup end

" nnoremap <leader>cc :ll<cr>
" nnoremap <leader>cn :lnext<cr>
" nnoremap <leader>cp :lprevious<cr>

" nnoremap ]<c-q> :cc<cr>
" nnoremap [q :cprev<cr>
" nnoremap ]q :cnext<cr>
" nnoremap [Q :cfirst<cr>
" nnoremap ]Q :clast<cr>

" nnoremap [<c-w> :ll<cr>
" nnoremap [w :lprev<cr>
" nnoremap ]w :lnext<cr>
" nnoremap [W :lfirst<cr>
" nnoremap ]W :llast<cr>

"""        Help/Man

let g:ft_man_open_mode = 'vert'

augroup HelpManSplit
	au!
	au FileType man wincmd H
	au FileType man setlocal tabstop=8
	au FileType help,man setlocal showbreak= nonumber signcolumn=no
	au FileType help au! BufRead,BufEnter <buffer> silent!
				\ | :silent! wincmd H | :silent! 82 wincmd|
	au FileType help au! BufLeave,WinLeave <buffer> silent!
				\ | if &columns < 100 | :silent! 0 wincmd| | endif
augroup end

"""        Shell output split

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline) abort
	if bufexists('scratch_terminal_output')
		bw! scratch_terminal_output
	endif
	let current_window = win_getid()
	wincmd v
	wincmd J
	if has("nvim")
		exe 'terminal '. a:cmdline
	else
		exe 'terminal ++curwin '. a:cmdline
	endif
	file scratch_terminal_output
	let term_window = win_getid()
	let term_buf_nr = buffer_number()
	10 wincmd _
	if win_getid() != current_window
		call win_gotoid(current_window)
	endif
endfunction

function! MoveScrathTerm(direction) abort
	if bufexists('scratch_terminal_output')
		let current_window = win_getid()
		sbuffer scratch_terminal_output
		if a:direction == 'L'
			wincmd L
		elseif a:direction == 'H'
			wincmd H
		elseif a:direction == 'J'
			wincmd J
			10 wincmd _
		elseif a:direction == 'K'
			wincmd K
			10 wincmd _
		elseif a:direction == 'Q'
			:bw
		endif
		call win_gotoid(current_window)
	endif
endfunction

"""        Job split output

command! -complete=shellcmd -nargs=+ Shell2 call s:TmpShellOutput(<q-args>)
function! s:TmpShellOutput(cmdline) abort
	if bufexists('tmplog')
		call deletebufline('tmplog', 1, '$')
	else
		call bufadd('tmplog')
		call setbufvar('tmplog', "buftype", "nofile")
		call setbufvar('tmplog', "filetype", "")
	endif
	" let logjob = job_start(execute("!bash " . a:cmdline),
	if has("nvim")
		let logjob = jobstart(["/bin/bash", "-c", a:cmdline],
					\ {'out_io': 'buffer', 'out_name': 'tmplog', 'out_msg': ''})
	else
		let logjob = job_start(["/bin/bash", "-c", a:cmdline],
					\ {'out_io': 'buffer', 'err_io': 'buffer', 'out_name': 'tmplog', 'err_name': 'tmplog', 'out_msg': ''})
	endif
	let winnr = win_getid()
	vert sbuffer tmplog
	setlocal wrap
	" nnoremap <buffer> <c-c> :call job_stop('logjob')<cr>
	wincmd L
	60 wincmd |
	if win_getid() != winnr
		call win_gotoid(winnr)
	endif
endfunction

"""        Scrolling

" Do not scroll past the end of file (last line locked at bottom of window)
function! NoScrollAtEOF() abort
	let curpos = getpos('.')
	let lnum = get(curpos, 1, -1)
	let len = line('$')
	if lnum + winheight(0) >= len
		normal! zb
	endif
endfunction
nnoremap <c-f> <c-f> <silent> :call NoScrollAtEOF()<cr>

"""        Mail

augroup MailSettings
	au!
	autocmd FileType mail setlocal linebreak tw=0
augroup end

"""        Markdown

augroup MarkdownSettings
	au!
	au FileType markdown setlocal linebreak
augroup end

"""        Search cycling windows

function! CycleWindowsSearch(direction) abort
	let forward = a:direction
	if ! v:searchforward
		let forward = forward ? '0' : '1'
	endif
	let searchflags = forward ? 'W' : 'Wb'
	let winmove = forward ? 'w' : 'W'
	let curmove = forward ? '1' : '$'

	let firstwin=winnr()
	if ! search(@/, searchflags)
		execute('wincmd ' . winmove)
		let savepos = getcurpos()
		call cursor(curmove, curmove)
		while ! search(@/, searchflags) && firstwin != winnr()
			call setpos('.', savepos)
			execute('wincmd ' . winmove)
			call cursor(curmove, curmove)
		endwhile
	endif
endfunction

" nnoremap <silent> n :call CycleWindowsSearch('1')<cr>
" nnoremap <silent> N :call CycleWindowsSearch('0')<cr>

""    Highlights / Match
"""        show traling whitespaces

augroup TrailSpace
	au!
	au BufWinEnter * match TrailSpace /\s\+$/
	au InsertEnter * match TrailSpace /\s\+\%#\@<!$/
	au InsertLeave * match TrailSpace /\s\+$/
	au BufWinLeave * call clearmatches()
augroup end

"""        color column 81 for code

augroup ColorColumn
	au!
	if exists('+colorcolumn')
		au FileType c,cpp,css,java,python,ruby,bash,sh,js,html,javascript setlocal colorcolumn=81
	endif
augroup end

"""        search cycle colors

" highlight current search and first/last search differently
function! HLCurrent() abort
	if exists("currmatch")
		call matchdelete(currmatch)
	endif
	" only on cursor
	let patt = '\c\%#'.@/
	" check prev and next match
	let prevmatch = search(@/, 'bWn')
	let nextmatch = search(@/, 'Wn')
	" if on first or last match
	if prevmatch == 0 || nextmatch == 0
		let currmatch = matchadd('EdgeSearch', patt, 101)
	else
		let currmatch = matchadd('IncSearch', patt, 101)
	endif
	redraw
endfunction

""    File automation
"""        Save and load

" Save when focus lost, load when focus gained
augroup AutoSaveAndLoadWithFocus
	au!
	au FocusGained,BufEnter * :silent! !
	au FocusLost,WinLeave * :silent! w
augroup end

"""        Last cursor position

" Open file where it was last closed
augroup ReOpenFileWhereLeft
	au!
	au BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$")
				\   | exe "normal! g`\""
				\ | endif
augroup end

"""        Files views

" save folding state and more
if ! has("nvim")
	augroup ReViews
		au!
		au BufWinLeave *
					\ if expand("%") != "" && &filetype != 'help' && &filetype != 'man'
					\   | mkview
					\ | endif
		au BufWinEnter *
					\ if expand("%") != "" && &filetype != 'help' && &filetype != 'man'
					\   | silent! loadview
					\ | endif
	augroup end
endif

"""        Working directory

" change dir to git repo OR file directory
augroup CdGitRootOrFileDir
	au!
	au BufEnter,BufRead *
				\ if !empty(bufname("%"))
				\   | silent! cd %:p:h | silent! Glcd
				\ | endif
augroup end

"""        Tags and paths

" Get tags file from git repo
" Set path for code projects
augroup CodePathTags
	au!
	au BufEnter * silent! set tags+=.git/tags
	au FileType make,c,cpp,css,java,python,ruby,js,json,javascript,sh au! BufRead,BufEnter <buffer> silent!
				\ | set path+=inc,incs,includes,include,headers,src,srcs,sources,js,html,ruby,python,javascript,tscript,typescript
augroup end

" autoreload tags file on save
" au BufWritePost *.c,*.cpp,*.h silent! !ctags -R --langmap=c:.c.h &
" au BufWritePost *.cpp silent! !ctags -R &
" set tags=tags;./git/
" set tags=./tags;

"""        Completion by filetype

augroup AutoOmniComplete
	au!
	au FileType c setlocal ofu=ccomplete#CompleteCpp
	au FileType css setlocal ofu=csscomplete#CompleteCSS
	au FileType html,xhtml setlocal ofu=htmlcomplete#CompleteTags
	au FileType php setlocal ofu=phpcomplete#CompletePHP
	au FileType ruby,eruby setlocal ofu=rubycomplete#Complete
augroup end

"""        Filetype recognition

augroup AutoFileTypeRecognition
	au!
	au BufNewFile,BufFilePre,BufRead *.md,markdown set filetype=markdown
	au BufNewFile,BufFilePre,BufRead *.sh,bash,zsh set filetype=sh
	au BufNewFile,BufFilePre,BufRead *.c,h,cpp set filetype=c
	au BufNewFile,BufFilePre,BufRead *.php set filetype=php
	au BufNewFile,BufFilePre,BufRead *.css set filetype=css
	au BufNewFile,BufFilePre,BufRead *.html,htm set filetype=html
	au BufNewFile,BufFilePre,BufRead *.js set filetype=javascript
	au BufNewFile,BufFilePre,BufRead *.json set filetype=json
	au BufNewFile,BufFilePre,BufRead *.groovy,gradle set filetype=groovy
	au BufNewFile,BufFilePre,BufRead *.java set filetype=java
	" au BufNewFile,BufNew,BufFilePre,BufRead,BufEnter *.php set filetype=html syntax=phtml
augroup end

"""        Filetype refresh

"  refresh filetype upon writing if no filetype already set
augroup FileTypeRefresh
	au!
	au BufWrite * if &ft ==# '' | filetype detect | endif
augroup end

"""        File suffixes

" set suffixes to try when matching a file name
function! SetSuffixes() abort
	let associations = [
				\["javascript", ".js,.javascript,.es,.esx,.json"],
				\["python", ".py,.pyw"],
				\["c", ".c,.h"],
				\["cpp", ".c,.h"]
				\]
	for ft in associations
		execute "au FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
	endfor
endfunction

augroup SuffixesTry
	au!
	au FileType javascript,c,cpp,python call SetSuffixes()
augroup end

"""        Large Files

" large file = 10MB
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFilesFast
	au!
	au BufReadPre *
				\ let f=expand("<afile>")
				\ | if getfsize(f) > g:LargeFile
					\ | let b:airline_whitespace_checks = ['']
					\ | au! anzu | endif
augroup end

"""        Auto Load Project Files

function! AutoProjectLoad() abort
	let filelist = ".git/vim/project_files"
	let filelistID = -1
	let currfileID = -1
	if bufname("%") != ""
		let currfileID = bufnr("%")
	endif
	if filereadable(".git/vim/project_files")
		exe "vs" filelist
		" open first WORD
		g/\v^.*[^ ]/ :argadd <cWORD>
		let filelistID = bufnr()
	endif
	if currfileID != -1
		close
	else
		bw 1
	endif
	if filelistID != -1
		exe "bw" filelist
	endif
endfunction

augroup AutoProjectLoadOnStart
	au!
	au VimEnter * ++nested call AutoProjectLoad()
augroup end

nnoremap <leader>ej :e .git/vim/project_files<cr>
nnoremap <leader>sj :call AutoProjectLoad()<cr>

""    Plugins settings
"""        Netrw

" Toggle Vexplore with <leader>t
function! ToggleNetrw() abort
	if exists("t:expl_buf_num")
		let expl_win_num = bufwinnr(t:expl_buf_num)
		let cur_win_num = winnr()
		if expl_win_num != -1
			while expl_win_num != cur_win_num
				exec "wincmd w"
				let cur_win_num = winnr()
			endwhile
			exec "bwipeout"
		endif
		unlet t:expl_buf_num
	else
		silent Lexplore
		let t:expl_buf_num = bufnr("%")
	endif
endfunction
nnoremap <silent> <leader>t :call ToggleNetrw()<cr>

" Netrw customization
let g:netrw_keepdir= 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = -25
let g:netrw_sort_sequence = '[\/]$,*'  " sort folders on top

" open netrw if vim starts without file
let g:netrw_startup = 0
let g:netrw_startup_no_file = 0
augroup NetrwStartup
	au!
	au VimEnter * if g:netrw_startup_no_file == '1' && expand("%") == "" | e . | endif
	au VimEnter * if g:netrw_startup == '1' && expand('%') == "" | Lexplore | wincmd w | endif
augroup end

"""        Termdebug

" let g:termdebug_wide = 163
let g:termdebug_wide = 40

"""        Fugitive

nnoremap <silent> <leader>gg :vertical Gstatus<cr>
set diffopt+=vertical " vertical split for diff
augroup FugitiveSet
	au!
	" au FileType gitcommit start
	au FileType fugitive setlocal cursorline norelativenumber nonumber colorcolumn=0
augroup end

function! FugitiveBlameToggle() abort
	let current_window = win_getid()
	wincmd h
	if &ft ==? "fugitiveblame"
		wincmd q
	else
		call win_gotoid(current_window)
		:Gblame
	endif
	call win_gotoid(current_window)
endfunction

nnoremap <leader>gb :call FugitiveBlameToggle()<cr>

"""        Airline

let g:airline_mode_map = {
			\ '__'     : '-',
			\ 'c'      : 'C',
			\ 'i'      : 'I',
			\ 'ic'     : 'I',
			\ 'ix'     : 'I',
			\ 'n'      : 'N',
			\ 'multi'  : 'M',
			\ 'ni'     : 'N',
			\ 'no'     : 'N',
			\ 'R'      : 'R',
			\ 'Rv'     : 'R',
			\ 's'      : 'S',
			\ 'S'      : 'S',
			\ ''     : 'S',
			\ 't'      : 'T',
			\ 'v'      : 'V',
			\ 'V'      : 'V',
			\ ''     : 'V',
			\ }

let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#default#layout = [
			\ [ 'a', 'b', 'c' ],
			\ [ 'x', 'y', 'z', 'error', 'warning' ]
			\ ]

call airline#parts#define_minwidth('branch', 20)

let g:airline_symbols_ascii = 1
let g:airline_section_z = '%4{line(".")}:%-3{virtcol(".")} %-4{LinePercent()}'
let g:airline_section_y = '%{&filetype}'
let g:airline_section_x = ''
let g:airline#extensions#hunks#enabled = 0

function! LinePercent() abort
	return line('.') * 100 / line('$') . '%'
endfunction

"""        Gitgutter
if exists('&signcolumn')        " Vim 7.4.2201
	set signcolumn=yes
else
	let g:gitgutter_sign_column_always = 1
endif
set updatetime=100              " need for Coc + gitgutter

let g:gitgutter_max_signs = 1000
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▎'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▎'

nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

"""        FZF

let g:fzf_command_prefix = 'Fzf'
let g:fzf_buffers_jump = 1      " [Buffers] to existing split

function! s:build_location_list(lines) abort
	call setloclist(0, map(copy(a:lines), '{ "filename": v:val }'))
	lopen
endfunction

function! s:build_quickfix_list(lines) abort
	call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
	copen
endfunction

" An action can be a reference to a function that processes selected lines
let g:fzf_action = {
			\ 'ctrl-l': function('s:build_quickfix_list'),
			\ 'ctrl-r': function('s:build_location_list'),
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-x': 'split',
			\ 'ctrl-v': 'vsplit'}

nnoremap <silent> <leader>ff :FzfFiles $HOME<cr>
nnoremap <silent> <leader><c-f> :call getcwd() <bar> :FzfFiles<cr>
nnoremap <silent> <leader>F :FzfFiles .<cr>
nnoremap <silent> <leader>fb :FzfBuffers<cr>
nnoremap <silent> <leader>b :FzfBuffers<cr>
nnoremap <silent> <leader>fw :FzfWindows<cr>
nnoremap <silent> <leader>ft :FzfTags<cr>
nnoremap <silent> <leader>f<c-t> :FzfBTags<cr>
nnoremap <silent> <leader>fc :FzfCommit<cr>
nnoremap <silent> <leader>f<c-c> :FzfBCommit<cr>
nnoremap <silent> <leader>fg :FzfGFiles?<cr>
nnoremap <silent> <leader>f<c-g> :FzfGFiles<cr>
nnoremap <silent> <leader>fl :FzfLines<cr>
nnoremap <silent> <leader>f<c-l> :FzfBLines<cr>
nnoremap <silent> <leader>f; :FzfHistory:<cr>
nnoremap <silent> <leader>f/ :FzfHistory/<cr>
nnoremap <silent> <leader>fh :FzfHistory<cr>
nnoremap <silent> <leader>fm :FzfHelptags<cr>
nnoremap <silent> <leader>fs <esc>:FzfSnippets<cr>
nnoremap <silent> <leader>fr <esc>:Rg<cr>
inoremap <silent> <c-x><c-s> <c-o>:FzfSnippets<cr>

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_tags_command = 'ctags -R'
" Border color
" let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'rounded' } }
" let g:fzf_layout = {'heigh': '40%'}

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline --bind "ctrl-o:toggle+up,ctrl-space:toggle-preview"'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
"-g '!{node_modules,.git}'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
	\ 'bg':      ['bg', 'Normal'],
	\ 'gutter':  ['bg', 'Normal'],
	\ 'hl':      ['fg', 'Comment'],
	\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+':     ['bg', 'Visual', 'CursorColumn'],
	\ 'hl+':     ['fg', 'Statement'],
	\ 'info':    ['fg', 'PreProc'],
	\ 'border':  ['fg', 'vertsplit'],
	\ 'prompt':  ['fg', 'Conditional'],
	\ 'pointer': ['fg', 'Exception'],
	\ 'marker':  ['fg', 'Keyword'],
	\ 'spinner': ['fg', 'Label'],
	\ 'header':  ['fg', 'Comment'] }
	" \ 'border':  ['fg', 'Conditional'],

"Get Files
command! -bang -nargs=? -complete=dir Files
		\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Get text in files with Rg
command! -bang -nargs=* Rg
	\ call fzf#vim#grep(
	\   "rg --column --line-number --no-heading --color=always --smart-case --glob '!.git/**' ".shellescape(<q-args>), 1,
	\   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen) abort
	let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
	let initial_command = printf(command_fmt, shellescape(a:query))
	let reload_command = printf(command_fmt, '{q}')
	let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
	call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
	\ call fzf#vim#grep(
	\   'git grep --line-number '.shellescape(<q-args>), 0,
	\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

"""        Latex Live Preview

" au FileType tex,plaintex let g:tex_fold_enabled=1
augroup TexSet
	au!
	au FileType tex setlocal updatetime=1000
	" let g:livepreview_previewer = 'zathura'
	" let g:livepreview_cursorhold_recompile = 0
	" let g:livepreview_engine = 'your_engine' . ' [options]'
augroup end

"""        Vim-run
let g:vim_run_command_map = {
			\'javascript': 'node',
			\'php': 'php',
			\'python': 'python',
			\'markdown': 'markdown',
			\}

"""        Vimwiki

augroup VimWikiSettings
	au!
	au FileType vimwiki setlocal nonu nornu showbreak= nobreakindent linebreak
	au FileType vimwiki nnoremap <buffer> <leader>cr <Plug>(VimwikiToggleListItem)
augroup end

let g:vimwiki_list = [{'path': '~/vimwiki/',
			\ 'syntax': 'markdown', 'ext': '.md'}]

" no vimwiki filetype outside wiki folder
let g:vimwiki_global_ext = 0

"""        Coc

let g:airline#extensions#coc#enabled = 0

"""        Anzu

nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
let g:anzu_airline_section = "x"
let g:anzu_status_format = "[%i/%l]"

""    Mappings
"""        Modes

" space as leader, prompt '\' in command line window :)
map <space> <leader>

" closing easy
nnoremap <leader>q :quit<cr>

nnoremap <leader><c-@> :echo "kewl"<cr>

" enter command mode with ;
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <leader>; :!

nnoremap gI `.gi<esc>zz

" no more default ex mode
nnoremap Q <nul>

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

"""        Movement

" insert mode left / right
inoremap <c-f> <c-g>U<right>
inoremap <c-b> <c-g>U<left>

" insert mode delete
inoremap <c-l> <c-o>x

" up down on visual lines
nnoremap <silent> j gj
nnoremap <silent> k gk
xnoremap <silent> j gj
xnoremap <silent> k gk

nnoremap H ^
nnoremap L $
nnoremap <expr> <c-l> getline(".")[col(".")] == ' ' ? "w" : "E"
nnoremap <expr> <c-h> getline(".")[col(".") - 2] == ' ' ? "gE" : "B"
nnoremap <c-k> {
nnoremap <c-j> }
nnoremap <c-q> :redraw!<cr>

"go to next / previous buffer
nnoremap <leader>] :bn<cr>
nnoremap <leader>[ :bp<cr>

vnoremap H ^
vnoremap L g_
vnoremap <c-h> B
vnoremap <c-l> E
vnoremap <c-k> {
vnoremap <c-j> }

" switch last 2 buffers
nnoremap <leader><space> <c-^>
onoremap <leader><space> <c-^>
vnoremap <leader><space> <c-^>

" last buffer in vertical split
nnoremap <c-w><space><space> :vertical split #<cr>
onoremap <c-w><space><space> :vertical split #<cr>
vnoremap <c-w><space><space> :vertical split #<cr>

" move between windows with ctrl
" nnoremap <c-h> :wincmd h<cr>
" nnoremap <c-j> :wincmd j<cr>
" nnoremap <c-k> :wincmd k<cr>
" nnoremap <c-l> :wincmd l<cr>
" imap <c-w> <c-o><c-w>

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

"""        Searching

nnoremap / :call clearmatches()<cr>/
nnoremap <leader>/ :call clearmatches()<cr>/\v
vnoremap <leader>/ :call clearmatches()<cr>/\v

nnoremap zM zMzb
nnoremap <silent> zm :set scrolloff=0<cr>zmzb:let &scrolloff=winheight(win_getid())/10 + 1<cr>
nnoremap <silent> zb :set scrolloff=0<cr>zb:let &scrolloff=winheight(win_getid())/10 + 1<cr>
" " nnoremap za zazz
" nnoremap zA zAzz
" nnoremap <leader>za zMzvzz

" search with different highlight
nnoremap <silent> n n:call HLCurrent()<cr>
nnoremap <silent> N N:call HLCurrent()<cr>

"do not move cursor with first match
nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>
nnoremap <silent> g* :let @/=expand('<cword>') <bar> set hls <cr>

" search visual selection
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

"Clear search highlight
nnoremap <silent> <leader>sh :nohlsearch<cr>:call anzu#clear_search_status()<cr>

" For local sed replace
nnoremap gr :s/<c-r>///g<left><left>
vnoremap gr :s/<c-r>///g<left><left>
nnoremap gR :%s/<c-r>///g<left><left>

"""        Files

" cd shell to vim current working directory
nnoremap <leader>cd :!cd &pwd<cr> :echo "shell cd : " . getcwd()<cr>

" toggle cursor always in middle with <leader>zz
nnoremap <silent> <leader>zz :let &scrolloff=999-&scrolloff<cr>

" show file name
nnoremap <leader>fp :echo expand('%')<cr>

" show file path/name and copy it to unnamed register
nnoremap <leader>fP :let @"=expand('%:p')<cr>:echo expand('%:p')<cr>

" show file name and copy it to unnamed register
nnoremap <leader>f<c-p> :let @"=expand('%')<cr>:echo expand('%:p:h')<cr>

" new file here
nnoremap <leader>nn :e <c-r>=expand('%:p:h') . '/'<cr>
nnoremap <leader>nv :vs <c-r>=expand('%:p:h') . '/'<cr>

" open file under cursor on the far-left hand side
nnoremap <c-w><c-d> :Lexplore <cfile><cr>

" toggle guides
nnoremap <silent> <leader>sg :set list!<cr>

" % as <c-g>
nnoremap <c-g> %
vnoremap <c-g> %

" Count line in function
function! FunctionLineCount() abort
	let l:currentline = line(".")
	normal! j[[
	let l:topline = line(".")
	normal! %
	let l:bottomline = line(".")
	exe "normal".l:currentline."gg"
	echo "function lines :" l:bottomline - l:topline - 1
	silent! normal! zz
endfunction

" Word count
function! WordCount() abort
	echo system("detex " . expand("%") . " | wc -w | tr -d [[:space:]]") "words"
endfunction

nnoremap <leader>wcf :call FunctionLineCount()<cr>
nnoremap <leader>wcc :call WordCount()<cr>
" nnoremap <leader>w :w !detex \| wc -w<cr>

" new file in vertical split instead of horizontal
" nnoremap <c-w><c-n> :vertical new<cr>
" nnoremap <c-w>n :vertical new<cr>
nnoremap <c-w><c-f> :vertical wincmd f<cr>

"""        Tags

" show matching tags
nnoremap g<c-]> g]

" jump if only one match
nnoremap g] g<c-]>

"""        Coc

" fix error when using tabs in middle of line
if v:version < 802
	inoremap <c-i> <c-v><c-i>
endif

if ! has("nvim")
	inoremap <expr> <c-@> pumvisible() ? coc#_select_confirm() : coc#refresh()
elseif has("nvim")
	inoremap <expr> <c-space> pumvisible() ? coc#_select_confirm() : coc#refresh()
endif

inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : coc#refresh()
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : coc#refresh()
hi link CocHilightText Visual

" inoremap <expr> <c-n> pumvisible() ? "\<C-p>" : coc#refresh()
let g:coc_snippet_next = '<c-f>'
let g:coc_snippet_prev = '<c-b>'

" use tab as in VSCode
" inoremap <silent><expr> <TAB>
" 			\ pumvisible() ? coc#_select_confirm() :
" 			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
" 			\ <SID>check_back_space() ? "\<TAB>" :
" 			\ coc#refresh()

" function text object mappings
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" pmenu mappings
nmap <silent> <leader>gf <Plug>(coc-definition)
nmap <silent> <leader>gd <Plug>(coc-declaration)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)
nmap <leader>cf  <Plug>(coc-fix-current)

" rename word
nmap <leader>rn <Plug>(coc-rename)

" show doc with Coc
nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation() abort
	if index(['vim','help'], &filetype) >= 0
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
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

" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"""        Folding

" inoremap <leader><space> <c-o>za
if ! has("nvim")
	nnoremap <c-@> za
	onoremap <c-@> <c-c>za
	vnoremap <c-@> zf
elseif has("nvim")
	nnoremap <c-space> za
	onoremap <c-space> <c-c>za
	vnoremap <c-space> zf
endif

" recursively open even partial folds
nnoremap zo zczO

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

"""        Command

cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-k> <Up>
cnoremap <c-j> <Down>
cnoremap <c-b> <Left>
cnoremap <c-f> <Right>
cnoremap <c-l> <S-Right>
cnoremap <c-h> <S-Left>
cnoremap <c-x> <c-h>
cnoremap <c-o> <s-tab>
cnoremap <c-r><c-l> <c-r>=substitute(getline('.'), '^\s*', '', '')<cr>

"""        Clipboard

" delete without saving to register
nnoremap <leader>d "_d
xnoremap <leader>d "_d
" xnoremap <leader>p "_dP

" paste with indentation
" nnoremap P mp]P==`p
" nnoremap p mp]p==`p

nnoremap cl c$
nnoremap dl d$
nnoremap yl y$
nnoremap ch c^
nnoremap dh d^
nnoremap yh y^

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
nnoremap <leader>yl "+y$
nnoremap <leader>yh "+y^
vnoremap <leader>y "+y

"""        Dotfiles

" source vimrc
nnoremap <leader>sv mZ:source $MYVIMRC<cr>:silent! doautocmd BufRead<cr>:echo "vimrc sourced"<cr>`Zzz:nohlsearch<cr>
nnoremap <leader>ss mZ:source $MYVIMRC<cr>:nohlsearch<cr>:redraw<cr>:doautocmd BufRead<cr>:echo "all fresh"<cr>`Zzz

" source colors
nnoremap <silent> <leader>s1 :source $HOME/.vim/colors/base16-onedark.vim<cr>
nnoremap <silent> <leader>s2 :source $HOME/.vim/colors/base16-one-light.vim<cr>

" edit dotfiles
nnoremap <leader>ev :e $HOME/dotfiles/vimrc<cr>
nnoremap <leader>e<c-v> :vertical split $HOME/dotfiles/vimrc<cr>
nnoremap <leader>et :e $HOME/dotfiles/tmux.conf<cr>
nnoremap <leader>e<c-t> :vertical split $HOME/dotfiles/tmux.conf<cr>
nnoremap <leader>eb :e $HOME/dotfiles/bashrc<cr>
nnoremap <leader>e<c-b> :vertical split $HOME/dotfiles/bashrc<cr>
nnoremap <leader>ea :e $HOME/dotfiles/bash_aliases<cr>
nnoremap <leader>e<c-a> :vertical split $HOME/dotfiles/bash_aliases<cr>
nnoremap <leader>en :e $HOME/dotfiles/inputrc<cr>
nnoremap <leader>e<c-n> :vertical split $HOME/dotfiles/inputrc<cr>
nnoremap <leader>ep $HOME/dotfiles/bash_profile<cr>
nnoremap <leader>e<c-p> :vertical split $HOME/dotfiles/bash_profile<cr>
nnoremap <leader>ec1 :e $HOME/dotfiles/vim/colors/base16-onedark.vim<cr>
nnoremap <leader>ec2 :e $HOME/dotfiles/vim/colors/base16-one-light.vim<cr>
nnoremap <leader>eo :CocConfig<cr>
nnoremap <leader>e<c-o> :vs <bar> CocConfig<cr>

" " rename file
" nnoremap <leader>mv :!mv % %:h:p/

"""        Terminal

nnoremap <silent> <Leader>T :call <SID>ToggleTerminal()<CR>
tnoremap <silent> <Leader>T <C-w>N:call <SID>ToggleTerminal()<CR>

tnoremap <c-n> <c-\><c-n>

"""        Fun
inoremap ,fox The quick brown fox jumps over the lazy dog
inoremap ,abc abcdefghijklmnopqrstuvwxyz
inoremap ,ABC ABCDEFGHIJKLMNOPQRSTUVWXYZ
inoremap ,09 0123456789

"""        Git

" Show git log history
nnoremap <leader>gl :vert terminal git --no-pager log --all --decorate --oneline --graph<cr>:setlocal filename=""<cr>
" Show git log in location list
nnoremap <leader>g<c-l> :Gllog! <bar> wincmd b <bar> wincmd L<cr>

""    Code Mappings
"""        General

" indent all file easy
nnoremap g<c-g> mZgg=G`Z

" Toggle location list (awesome)
nnoremap <expr> <leader>cl get(getloclist(0, {'winid':0}), 'winid', 0) ?
			\ ":lclose<cr>" : ":lopen<cr><c-w>p"

" Toggle quickfix list (awesome)
nnoremap <expr> <leader>cq get(getqflist({'winid':0}), 'winid', 0) ?
			\ ":cclose<cr>" : ":copen<cr><c-w>p"

" trim current line
nnoremap <silent> <leader>xx :s/\s\+$//<cr>:redraw<cr>
"trim file
nnoremap <leader>xX :%s/\s\+$//<cr>:redraw<cr>
nnoremap <leader>XX :%s/\s\+$//<cr>:redraw<cr>

" Make
nnoremap <leader>cm :make<cr><cr>
nnoremap <leader>cr :make re<cr><cr>
nnoremap <leader>ce :make ex<cr><cr>
nnoremap <leader>ct :make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>cT :make ex TESTFF=
nnoremap <leader>c<c-t> :make ex TEST=test/%<cr><cr>

function! LocListPannel(pfx) abort
	" if a:pfx == 'l' && len(getloclist(0)) == 0
	" 	echohl ErrorMsg
	" 	echo "Location List is Empty."
	" 	return
	" endif
	let winnr = winnr()
	exec(a:pfx.'open')
	wincmd L
	if winnr() != winnr
		wincmd p
	endif
endfunction

" Make in spit
nnoremap <leader>csm :lmake!<cr>:call LocListPannel('l')<cr>

nnoremap <leader>csr :lmake! re<cr>:call LocListPannel('l')<cr>
nnoremap <leader>cse :Shell make ex<cr><cr>
nnoremap <leader>cst :Shell make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>cs<c-t> :Shell make ex TEST=test/%<cr><cr>
nnoremap <leader>csT :Shell make ex TESTFF=
" nnoremap <leader>csv :Shell make ex TEST=<cr><cr>
" nnoremap <leader>csm :make<cr><cr>:lopen<cr>:wincmd L<cr>

" nnoremap <leader>csm :lmake<cr>:lopen<cr>:wincmd L<cr>
" nnoremap <leader>csr :lmake re<cr>:lopen<cr>:wincmd L<cr>
" nnoremap <leader>cse :lmake ex<cr><cr>:lopen<cr>:wincmd L<cr>
" nnoremap <leader>cst :lmake ex TESTFF=test/test*<cr><cr>:lopen<cr>:wincmd L<cr>
" nnoremap <leader>cs<c-t> :lmake ex TEST=test/%<cr><cr>:lopen<cr>:wincmd L<cr>
" nnoremap <leader>csT :lmake ex TESTFF=:lopen<cr>:wincmd L<cr>
" " nnoremap <leader>csv :make ex TEST=<cr><cr>:lopen<cr>:wincmd L<cr>
" nnoremap <leader>csm :lmake<cr><cr>:lopen<cr>:wincmd L<cr>

nnoremap <silent> g{ viBo^<esc>
nnoremap <silent> g} viB^<esc>

"""        bash

inoremap <expr> ! (&filetype == '' <bar><bar> &filetype == 'sh') && col('.') == 2 && getline('.') =~ "^#" ? "!/bin/bash" : "!"

augroup Shmaps
	au!
	au FileType sh inoremap <buffer> <expr> ! col('.') == 2 && getline('.') =~ "^#" ? "!/bin/bash" : "!"
	au FileType sh inoremap <buffer> ,#! #!/bin/bash

	" alias to function
	au FileType sh nnoremap <buffer> <leader>xf ^dWf=2s() {<cr><esc>$x==o}<esc>

	" auto close brackets
	au FileType sh inoremap <buffer> { {}<c-g>U<left>
	au FileType sh inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
	au FileType sh inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'

augroup end

"""        C

augroup Cmaps
	au!
	au FileType c inoremap <buffer> ,ma <esc>:Header101<cr>iint<tab><tab>main(int ac, char **av)<cr>{<cr>}<esc>Oreturn(0);<esc>O
	au FileType c inoremap <buffer> ,if if ()<cr>{<cr>}<esc>2k3==f)i
	au FileType c inoremap <buffer> ,wh while ()<cr>{<cr>}<esc>2k3==f)i
	au FileType c inoremap <buffer> ,ret return (0);<esc>^
	au FileType c inoremap <buffer> ,imin -2147483648
	au FileType c inoremap <buffer> ,imax 2147483647
	au FileType c inoremap <buffer> ,endl ft_putendl("");<left><left><left>
	au FileType c inoremap <buffer> ,str ft_putstr("");<left><left><left>
	au FileType c inoremap <buffer> ,nbr ft_putnbr();<cr>ft_putendl("");<up><left><left>
	au FileType c inoremap <buffer> ,lib #include <stdlib.h><cr>#include <unistd.h><cr>#include <stdio.h><cr>#include <sys/types.h><cr>#include <sys/wait.h><cr>#include <sys/types.h><cr>#include <sys/stat.h><cr>#include <fcntl.h><cr>#include <string.h><cr>#include <bsd/string.h><cr>

	au FileType c nnoremap <buffer> <leader><c-]> <c-w>v<c-]>z<cr>
	" if to ternary operator
	au FileType c nnoremap <buffer> <leader>xt $Ji<space>?<esc>$i : 0<esc>^dw
	au FileType c nnoremap <buffer> <leader>xT ^iif<space>(<esc>f?h3s)<cr><esc>f:h3s;<cr>else<cr><esc>
	au FileType c nnoremap <buffer> <leader>x<c-t> ^iif<space>(<esc>f?h3s)<cr><esc>f:hc$;<esc>

	" compile and execute current
	au FileType c nnoremap <buffer> <leader>cc :!gcc -Wall -Wextra % && ./a.out<cr>
	au FileType c nnoremap <buffer> <leader>cC :!gcc -Wall -Wextra % && ./a.out
	au FileType c nnoremap <buffer> <leader>csc :Shell gcc -Wall -Wextra % && ./a.out<cr>
	au FileType c nnoremap <buffer> <leader>cs<c-m> :Shell gcc -Wall -Wextra % main.c && ./a.out<cr>

	" auto close brackets
	au FileType c inoremap <buffer> { {}<c-g>U<left>
	au FileType c inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
	au FileType c inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'

	" brackets around paragraph
	au FileType c nnoremap <buffer> <leader>{} mZ{S{<esc>}S}<esc>=%`Z=iB
	au FileType c nnoremap <buffer> <leader>{{ o}<esc>kO{<esc>3==j

	"  name of current c function (needs '()')
	au FileType c nnoremap <buffer> <silent> g<c-d> ][[[h^t(b

	" semicolon/coma EOL toggle
	au FileType c nnoremap <buffer> <expr> <leader>; getline('.')[col('$') - 2] == ';' ? "mZ$x`Z" : "mZA;\<esc>`Z"
	au FileType c nnoremap <buffer> <expr> <leader>, getline('.')[col('$') - 2] == ',' ? "mZ$x`Z" : "mZA,\<esc>`Z"

	" select all text in function
	au FileType c nnoremap <buffer> <leader>vf j[[V%o

	" valgrind
	au FileType c nnoremap <buffer> <leader>cv :!valgrind ./test.out 2> /dev/null<cr><cr>
	au FileType c nnoremap <buffer> <leader>csv :Shell valgrind ./test.out 2> /dev/null<cr><cr>
augroup end

" nnoremap viB [[%v%jok$
" nnoremap vaB [[%v%
" " nnoremap vib [{%v%jok$
" nnoremap vab [{%v%

" " Commenting blocks of code.
" au FileType c,cpp,java,scala let b:com_size = '3' | let b:com = '// '
" au FileType sh,ruby,python   let b:com_size = '2' | let b:com = '# '
" au FileType conf,fstab       let b:com_size = '2' | let b:com = '# '
" au FileType tex              let b:com_size = '2' | let b:com = '% '
" au FileType mail             let b:com_size = '2' | let b:com = '> '
" au FileType vim              let b:com_size = '2' | let b:com = '" '
" au FileType readline         let b:com_size = '2' | let b:com = '# '

" nnoremap <silent> <leader>'' m'V:norm i<c-r>=expand(b:com)<cr><cr>`'<right><right>
" vnoremap <silent> <leader>'' m':norm i<c-r>=expand(b:com)<cr><cr>`'

" nnoremap <silent> <leader>"" m'V:norm <c-r>=expand(b:com_size)<cr>x<cr>`'<left><left>
" vnoremap <silent> <leader>"" m':norm <c-r>=expand(b:com_size)<cr>x<cr>`'

" noremap <silent> <leader>'p yypk:<c-b> <c-e>s/^\V<c-r>=escape(b:comment_leader,'\/')<cr>//e<cr>:nohlsearch<cr>

"""        Java

augroup JavaMaps
	au!
	au FileType java,groovy nnoremap <buffer> <leader>cg :Shell gradle run<cr>

	au FileType java,groovy inoremap <buffer> ,if if ()<cr>{<cr>}<c-o>2<up><c-o>f)
	au FileType java,groovy inoremap <buffer> ,wh while ()<cr>{<cr>}<c-o>2<up><c-o>f)
	au FileType java,groovy inoremap <buffer> ,imin -2147483648
	au FileType java,groovy inoremap <buffer> ,imax 2147483647

	au FileType java,groovy nnoremap <buffer> <leader><c-]> <c-w>v<c-]>z<cr>
	" if to ternary operator
	au FileType java,groovy nnoremap <buffer> <leader>xt $Ji<space>?<esc>$i : 0<esc>^dw
	au FileType java,groovy nnoremap <buffer> <leader>xT ^iif<space>(<esc>f?h3s)<cr><esc>f:h3s;<cr>else<cr><esc>
	au FileType java,groovy nnoremap <buffer> <leader>x<c-t> ^iif<space>(<esc>f?h3s)<cr><esc>f:hc$;<esc>

	" auto close brackets
	au FileType java,groovy inoremap <buffer> { {}<c-g>U<left>
	au FileType java,groovy inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
	au FileType java,groovy inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'

	" brackets auround paragraph
	au FileType java,groovy nnoremap <buffer> <leader>{} mZ{S{<esc>}S}<esc>=%`Z=iB
	au FileType java,groovy nnoremap <buffer> <leader>{{ o}<esc>kO{<esc>3==j

	"  name of current function (needs '()')
	au FileType java,groovy nnoremap <buffer> <silent> g<c-d> ][[[h^t(b

	" semicolon/coma EOL toggle
	au FileType java,groovy nnoremap <buffer> <expr> <leader>; getline('.')[col('$') - 2] == ';' ? "mZ$x`Z" : "mZA;\<esc>`Z"
	au FileType java,groovy nnoremap <buffer> <expr> <leader>, getline('.')[col('$') - 2] == ',' ? "mZ$x`Z" : "mZA,\<esc>`Z"

	" select allext in function
	au FileType java,groovy nnoremap <buffer> <leader>vf j[[V%o
augroup end

" nnoremap viB [[%v%jok$
" nnoremap vaB [[%v%
" " nnoremap vib [{%v%jok$
" nnoremap vab [{%v%

" " Commenting blocks of code.
" au FileType c,cpp,java,scala let b:com_size = '3' | let b:com = '// '
" au FileType sh,ruby,python   let b:com_size = '2' | let b:com = '# '
" au FileType conf,fstab       let b:com_size = '2' | let b:com = '# '
" au FileType tex              let b:com_size = '2' | let b:com = '% '
" au FileType mail             let b:com_size = '2' | let b:com = '> '
" au FileType vim              let b:com_size = '2' | let b:com = '" '
" au FileType readline         let b:com_size = '2' | let b:com = '# '

" nnoremap <silent> <leader>'' m'V:norm i<c-r>=expand(b:com)<cr><cr>`'<right><right>
" vnoremap <silent> <leader>'' m':norm i<c-r>=expand(b:com)<cr><cr>`'

" nnoremap <silent> <leader>"" m'V:norm <c-r>=expand(b:com_size)<cr>x<cr>`'<left><left>
" vnoremap <silent> <leader>"" m':norm <c-r>=expand(b:com_size)<cr>x<cr>`'

" noremap <silent> <leader>'p yypk:<c-b> <c-e>s/^\V<c-r>=escape(b:comment_leader,'\/')<cr>//e<cr>:nohlsearch<cr>

"""        JavaScript

augroup JSmaps
	au!
	au FileType javascript nnoremap <buffer> <leader>cr :Run<cr>
	au FileType javascript nnoremap <buffer> <leader>ca :AutoRun<cr>
	au FileType javascript nnoremap <buffer> <leader>; i<c-o>mZ<c-o>A;<esc>`Z<esc>
	au FileType javascript nnoremap <buffer> <leader>, i<c-o>mZ<c-o>A,<esc>`Z<esc>
	au FileType javascript nnoremap <buffer> <leader>cc :Shell node %<cr>
	au FileType javascript nnoremap <buffer> <leader>ls :!live-server %<cr>
	au FileType javascript inoremap <buffer> ,if if ()<cr>{<cr>}<esc>2k3==f)i
	au FileType javascript inoremap <buffer> ,fo for ()<cr>{<cr>}<esc>2k3==f)i
	au FileType javascript inoremap <buffer> ,wh while ()<cr>{<cr>}<esc>2k3==f)i
	au FileType javascript inoremap <buffer> ,cl console.log();<esc>F)i
	au FileType javascript nnoremap <buffer> <leader>xl yiwoconsole.log();<esc>F(p
	au FileType javascript vnoremap <buffer> <leader>xl yoconsole.log();<esc>F(p

	" auto close brackets
	au FileType javascript inoremap <buffer> { {}<c-g>U<left>
	au FileType javascript inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
	au FileType javascript inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'

augroup end

"""        Json

augroup Jsonmaps
	au!
	au FileType json nnoremap <buffer> <expr> <leader>; getline('.')[col('$') - 2] == ';' ? "mZ$x`Z" : "mZA;\<esc>`Z"
	au FileType json nnoremap <buffer> <expr> <leader>, getline('.')[col('$') - 2] == ',' ? "mZ$x`Z" : "mZA,\<esc>`Z"

	" auto close brackets
	au FileType json inoremap <buffer> { {}<c-g>U<left>
	au FileType json inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
	au FileType json inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'

augroup end

"""        PHP/HTML/CSS

augroup Webmaps
	au!
	au FileType php,html,json nnoremap <buffer> <leader>xst ciw<strong><c-o>P</strong><esc>T<
	au FileType php,html,json nnoremap <buffer> <leader>xst ciw<em><c-o>P</em><esc>T<

	au FileType css nnoremap <buffer> <c-w>u :40 wincmd\|<cr>

	" auto close brackets
	au FileType css inoremap <buffer> { {}<c-g>U<left>
	au FileType css inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
	au FileType css inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'

	au FileType php,html inoremap <buffer> ,php <?php<cr>?><esc>O
	au FileType php,html inoremap <buffer> ,bo <body></body><esc>F<i
	au FileType php,html inoremap <buffer> ,h1 <h1></h1><esc>F<i
	au FileType php,html inoremap <buffer> ,h2 <h2></h2><esc>F<i
	au FileType php,html inoremap <buffer> ,h3 <h3></h3><esc>F<i
	au FileType php,html inoremap <buffer> ,h4 <h4></h4><esc>F<i
	au FileType php,html inoremap <buffer> ,h5 <h5></h5><esc>F<i
	au FileType php,html inoremap <buffer> ,h6 <h6></h6><esc>F<i
	au FileType php,html inoremap <buffer> ,pp <p></p><esc>F<i
	au FileType php,html inoremap <buffer> ,br <br/>
	au FileType php,html inoremap <buffer> ,aa <a href="" alt=""></a><esc>F<i
	au FileType php,html inoremap <buffer> ,img <img src="" alt=""></img><esc>F<i
	au FileType php,html inoremap <buffer> ,uu <u></u><esc>F<i
	au FileType php,html inoremap <buffer> ,ii <i></i><esc>F<i
	au FileType php,html inoremap <buffer> ,bb <b></b><esc>F<i
	au FileType php,html inoremap <buffer> ,sk <strike></strike><esc>F<i
	au FileType php,html inoremap <buffer> ,sup <sup></sup><esc>F<i
	au FileType php,html inoremap <buffer> ,sub <sub></sub><esc>F<i
	au FileType php,html inoremap <buffer> ,sm <small></small><esc>F<i
	au FileType php,html inoremap <buffer> ,tt <tt></tt><esc>F<i
	au FileType php,html inoremap <buffer> ,pre <pre></pre><esc>F<i
	au FileType php,html inoremap <buffer> ,bq <blockquote></blockquote><esc>F<i
	au FileType php,html inoremap <buffer> ,st <strong></strong><esc>F<i
	au FileType php,html inoremap <buffer> ,em <em></em><esc>F<i
	au FileType php,html inoremap <buffer> ,ol <ol></ol><esc>F<i
	au FileType php,html inoremap <buffer> ,dd <dd></dd><esc>F<i
	au FileType php,html inoremap <buffer> ,dt <dt></dt><esc>F<i
	au FileType php,html inoremap <buffer> ,dl <dl></dl><esc>F<i
	au FileType php,html inoremap <buffer> ,ul <ul></ul><esc>F<i
	au FileType php,html inoremap <buffer> ,li <li></li><esc>F<i
	au FileType php,html inoremap <buffer> ,hr <hr></hr><esc>F<i
	au FileType php,html inoremap <buffer> ,di <div></div><esc>F<i
	au FileType php,html inoremap <buffer> ,sp <span></span><esc>F<i
	au FileType php,html inoremap <buffer> ,se <select></select><esc>F<i
	au FileType php,html inoremap <buffer> ,op <optionlect></optionlect><esc>F<i
	au FileType php,html inoremap <buffer> ,tx <textarealect></textarealect><esc>F<i

	au FileType php,html inoremap <buffer> ,fo <form action="" method=""><return><input type="text" name=""><return></form>
	au FileType php,html inoremap <buffer> ,fg <form action="" method="get"><return><input type="text" name=""><return></form>
	au FileType php,html inoremap <buffer> ,fp <form action="" method="post"><return><input type="text" name=""><return></form>
	au FileType php,html inoremap <buffer> ,in <input type="" name="" value=""></input><esc>F<i

	au FileType php,html inoremap <buffer> ,ec echo "";<esc>hi
	au FileType php,html inoremap <buffer> ,ge $_GET[""]<esc>hi
	au FileType php,html inoremap <buffer> ,po $_POST[""]<esc>hi
	au FileType php,html inoremap <buffer> ,lorem Lorem ipsum dolor sit amet,
				\ consectetuer adipiscing elit, sed diam nonummy nibh
				\ euismod tincidunt ut laoreet dolore magna aliquam erat
				\ volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci
				\ tation ullamcorper suscipit lobortis nisl ut aliquip ex ea
				\ commodo consequat. Duis autem vel eum iriure dolor in
				\ hendrerit in vulputate velit esse molestie consequat, vel
				\ illum dolore eu feugiat nulla facilisis at vero eros et
				\ accumsan et iusto odio dignissim qui blandit praesent
				\ luptatum zzril delenit augue duis dolore te feugait nulla
				\ facilisi.

	au FileType php,html nnoremap <leader>; i<c-o>mZ<c-o>A;<esc>`Z<esc>
	au FileType php,html nnoremap <leader>, i<c-o>mZ<c-o>A,<esc>`Z<esc>
augroup end

"""        LATEX

augroup LatexSmith
	au!
	" Navigating with guides
	au FileType plaintex,tex silent inoremap <buffer> ,, <esc>/<++><cr>"_4s
	au FileType plaintex,tex silent vnoremap <buffer> ,, <esc>/<++><cr>"_4s
	au FileType plaintex,tex silent map <buffer> ,, <esc>/<++><cr>"_4s

	au FileType plaintex,tex silent nnoremap <buffer> <leader>ll :LLPStartPreview

	" Latex snippets
	au FileType plaintex,tex inoremap <buffer> ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><esc>6kf}i
	au FileType plaintex,tex inoremap <buffer> ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><esc>3kA
	au FileType plaintex,tex inoremap <buffer> ,exe \begin{exe}<Enter>\ex<space><Enter>\end{exe}<Enter><Enter><++><esc>3kA
	au FileType plaintex,tex inoremap <buffer> ,em \emph{}<++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,bf \textbf{}<++><esc>T{i
	au FileType plaintex,tex vnoremap <buffer> , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	au FileType plaintex,tex inoremap <buffer> ,it \textit{}<++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,ct \textcite{}<++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,cp \parencite{}<++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,glos {\gll<space><++><space>\\<Enter><++><space>\\<Enter>\trans{``<++>''}}<esc>2k2bcw
	au FileType plaintex,tex inoremap <buffer> ,x \begin{xlist}<Enter>\ex<space><Enter>\end{xlist}<esc>kA<space>
	au FileType plaintex,tex inoremap <buffer> ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><esc>3kA\item<space>
	au FileType plaintex,tex inoremap <buffer> ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><esc>3kA\item<space>
	au FileType plaintex,tex inoremap <buffer> ,li <Enter>\item<space>
	au FileType plaintex,tex inoremap <buffer> ,dc <Enter>\documentclass<space>
	au FileType plaintex,tex inoremap <buffer> ,doc <Enter>\documentation<space>
	au FileType plaintex,tex inoremap <buffer> ,ref \ref{}<space><++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><esc>4kA{}<esc>i
	au FileType plaintex,tex inoremap <buffer> ,ot \begin{tableau}<Enter>\inp{<++>}<tab>\const{<++>}<tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><esc>5kA{}<esc>i
	au FileType plaintex,tex inoremap <buffer> ,can \cand{}<tab><++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,con \const{}<tab><++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,v \vio{}<tab><++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,a \href{}{<++>}<space><++><esc>2T{i
	au FileType plaintex,tex inoremap <buffer> ,sc \textsc{}<space><++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,chap \chapter{}<Enter><Enter><++><esc>2kf}i
	au FileType plaintex,tex inoremap <buffer> ,sec \section{}<Enter><Enter><++><esc>2kf}i
	au FileType plaintex,tex inoremap <buffer> ,ssec \subsection{}<Enter><Enter><++><esc>2kf}i
	au FileType plaintex,tex inoremap <buffer> ,sssec \subsubsection{}<Enter><Enter><++><esc>2kf}i
	au FileType plaintex,tex inoremap <buffer> ,st <esc>F{i*<esc>f}i
	au FileType plaintex,tex inoremap <buffer> ,beg \begin{}<Enter><++><Enter>\end{}<Enter><Enter><++><esc>4k0f{a
	au FileType plaintex,tex inoremap <buffer> ,up <esc>/usepackage<Enter>o\usepackage{}<esc>i
	au FileType plaintex,tex nnoremap <buffer> ,up /usepackage<Enter>o\usepackage{}<esc>i
	au FileType plaintex,tex inoremap <buffer> ,tt \texttt{}<space><++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,bt {\blindtext}
	au FileType plaintex,tex inoremap <buffer> ,nu $\varnothing$
	au FileType plaintex,tex inoremap <buffer> ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<esc>5kA
	au FileType plaintex,tex inoremap <buffer> ,rn (\ref{})<++><esc>F}i
augroup end

"""        Markdown

augroup MarkdownMaps
	au!
	au FileType markdown nnoremap <buffer> <leader>cr :Run<cr>
	au FileType markdown nnoremap <buffer> <leader>ca :AutoRun<cr>
	" au FileType markdown nnoremap <buffer> <leader>br A<br><esc>
augroup end

""    Operators
"""        Start / End of line
onoremap ah :<c-u>normal! v^<cr>
onoremap ih :<c-u>normal! hv^<cr>

onoremap al :<c-u>normal! v$<cr>
onoremap il :<c-u>normal! lv$<cr>

"""        Surroundings
onoremap i. :<c-u>normal! T.vt.<cr>
onoremap a. :<c-u>normal! F.vf.<cr>

onoremap i, :<c-u>normal, T,vt,<cr>
onoremap a, :<c-u>normal, F,vf,<cr>

onoremap i: :<c-u>normal! T:vt:<cr>
onoremap a: :<c-u>normal! F:vf:<cr>

onoremap i; :<c-u>normal! T;vt;<cr>
onoremap a; :<c-u>normal! F;vf;<cr>

onoremap i? :<c-u>normal! T?vt?<cr>
onoremap a? :<c-u>normal! F?vf?<cr>

onoremap i! :<c-u>normal! T!vt!<cr>
onoremap a! :<c-u>normal! F!vf!<cr>

onoremap i- :<c-u>normal! T-vt-<cr>
onoremap a- :<c-u>normal! F-vf-<cr>

onoremap i_ :<c-u>normal! T_vt_<cr>
onoremap a_ :<c-u>normal! F_vf_<cr>

onoremap i/ :<c-u>normal! T/vt/<cr>
onoremap a/ :<c-u>normal! F/vf/<cr>

onoremap i\ :<c-u>normal! T\vt\<cr>
onoremap a\ :<c-u>normal! F\vf\<cr>

onoremap i@ :<c-u>normal! T@vt@<cr>
onoremap a@ :<c-u>normal! F@vf@<cr>

onoremap i* :<c-u>normal! T*vt*<cr>
onoremap a* :<c-u>normal! F*vf*<cr>

onoremap i# :<c-u>normal! T*vt*<cr>
onoremap a# :<c-u>normal! F*vf*<cr>

onoremap i$ :<c-u>normal! T*vt*<cr>
onoremap a$ :<c-u>normal! F*vf*<cr>

onoremap i> :<c-u>normal! T<vt><cr>
onoremap a> :<c-u>normal! F<vf><cr>
onoremap i< :<c-u>normal! T<vt><cr>
onoremap a< :<c-u>normal! F<vf><cr>

" onoremap i| :<c-u>normal! T|vt|<cr>
" onoremap a| :<c-u>normal! F|vf|<cr>

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

onoremap in" :<c-u>normal! f"vi"<cr>
onoremap an" :<c-u>normal! f"va"<cr>
onoremap iN" :<c-u>normal! F"vi"<cr>
onoremap aN" :<c-u>normal! F"va"<cr>

onoremap in' :<c-u>normal! f'vi'<cr>
onoremap an' :<c-u>normal! f'va'<cr>
onoremap iN' :<c-u>normal! F'vi'<cr>
onoremap aN' :<c-u>normal! F'va'<cr>

onoremap in. :<c-u>normal! f.lvt.<cr>
onoremap an. :<c-u>normal! f.vf.<cr>
onoremap iN. :<c-u>normal! F.hvT.<cr>
onoremap aN. :<c-u>normal! F.vF.<cr>

onoremap in- :<c-u>normal! f-lvt-<cr>
onoremap an- :<c-u>normal! f-vf-<cr>
onoremap iN- :<c-u>normal! F-hvT-<cr>
onoremap aN- :<c-u>normal! F-vF-<cr>

onoremap in, :<c-u>normal, f,lvt,<cr>
onoremap an, :<c-u>normal, f,vf,<cr>
onoremap iN, :<c-u>normal, F,hvT,<cr>
onoremap aN, :<c-u>normal, F,vF,<cr>

onoremap in* :<c-u>normal! f*lvt*<cr>
onoremap an* :<c-u>normal! f*vf*<cr>
onoremap iN* :<c-u>normal! F*hvT*<cr>
onoremap aN* :<c-u>normal! F*vF*<cr>

onoremap in# :<c-u>normal! f#lvt#<cr>
onoremap an# :<c-u>normal! f#vf#<cr>
onoremap iN# :<c-u>normal! F#hvT#<cr>
onoremap aN# :<c-u>normal! F#vF#<cr>

onoremap in$ :<c-u>normal! f$lvt$<cr>
onoremap an$ :<c-u>normal! f$vf$<cr>
onoremap iN$ :<c-u>normal! F$hvT$<cr>
onoremap aN$ :<c-u>normal! F$vF$<cr>

""    Headers
"""        Basic headers

augroup Headers
	au!
	au BufNewFile *.sh 0r $HOME/.vim/skel/bash_header
	au BufNewFile *.html 0r $HOME/.vim/skel/html_header
augroup end

"""        Auto protect c header

if !exists("autocommands_loaded")
	let autocommands_loaded = 1
	au BufNewFile *.h call InsertCHHeader()
endif

function! InsertCHHeader() abort
	let path_to_skeletons = "$HOME/dotfiles/vim/skel/ch_header"
	" Save cpoptions
	let cpoptions = &cpoptions
	" Remove the 'a' option - prevents the name of the
	" alternate file being overwritten with a :read command
	exe "set cpoptions=" . substitute(cpoptions, "a", "", "g")
	exe "read " . path_to_skeletons
	" Restore cpoptions
	exe "set cpoptions=" . cpoptions
	1, 1 delete _

	let fname = expand("%:t")
	let fname = toupper(fname)
	let fname = substitute(fname, "\\.", "_", "g")
	%s/HEADERNAME/\=fname/g
endfunction

"""        42Header

" let s:asciiart = [
" 			\"               /          ",
" 			\"     .::    .:/ .      .::",
" 			\"  +:+:+   +:    +:  +:+:+ ",
" 			\"   +:+   +:    +:    +:+  ",
" 			\"  #+#   #+    #+    #+#   ",
" 			\" #+#   ##    ##    #+#    ",
" 			\"###    #+. /#+    ###.fr  ",
" 			\"          /               ",
" 			\"         /                ",
" 			\"           LE - /         "
" 			\]

" let s:asciiart = [
" 			\":.:      .: .:  .:      .:",
" 			\" :+:   :+: +:+ +:+:   :+:+",
" 			\"  +:+ +:+  +:+ +:+:+ +:+:+",
" 			\"    #+#    #+# #+# #+# #+#",
" 			\"     +     #+# #+#  +  #+#",
" 			\""
" 			\]

" :.:     :.: :.: :.:     :.:
"  :+:   :+:  +:+ +:+:   :+:+
"   +:+ +:+   +:+ +:+:+ +:+:+
"    +#+#+    #+# #+# #+# #+#
"     #+#     #+# #+# #+# #+#
"      +      #+# #+#  +  #+#

let s:asciiart = [
			\"        :::      ::::::::",
			\"      :+:      :+:    :+:",
			\"    +:+ +:+         +:+  ",
			\"  +#+  +:+       +#+     ",
			\"+#+#+#+#+#+   +#+        ",
			\"     #+#    #+#          ",
			\"    ###   ########lyon.fr"
			\]

let s:start		= '/*'
let s:end		= '*/'
let s:fill		= '*'
let s:length	= 80
let s:margin	= 5

let s:types		= {
			\'\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.php':
			\['/*', '*/', '*'],
			\'\.htm$\|\.html$\|\.xml$':
			\['<!--', '-->', '*'],
			\'\.js$':
			\['//', '//', '*'],
			\'\.tex$':
			\['%', '%', '*'],
			\'\.ml$\|\.mli$\|\.mll$\|\.mly$':
			\['(*', '*)', '*'],
			\'\.vim$\|\vimrc$':
			\['"', '"', '*'],
			\'\.el$\|\emacs$':
			\[';', ';', '*'],
			\'\.f90$\|\.f95$\|\.f03$\|\.f$\|\.for$':
			\['!', '!', '/']
			\}

function! s:filetype() abort
	let l:f = s:filename()
	let s:start	= '#'
	let s:end	= '#'
	let s:fill	= '*'
	for type in keys(s:types)
		if l:f =~ type
			let s:start	= s:types[type][0]
			let s:end	= s:types[type][1]
			let s:fill	= s:types[type][2]
		endif
	endfor
endfunction

function! s:ascii(n) abort
	return s:asciiart[a:n - 3]
endfunction

function! s:textline(left, right)
	let l:left = strpart(a:left, 0, s:length - s:margin * 3 - strlen(a:right) + 1)
	return s:start . repeat(' ', s:margin - strlen(s:start)) . l:left . repeat(' ', s:length - s:margin * 2 - strlen(l:left) - strlen(a:right)) . a:right . repeat(' ', s:margin - strlen(s:end)) . s:end
endfunction

function! s:line(n) abort
	if a:n == 1 || a:n == 11 " top and bottom line
		return s:start . ' ' . repeat(s:fill, s:length - strlen(s:start) - strlen(s:end) - 2) . ' ' . s:end
	elseif a:n == 2 || a:n == 10 " blank line
		return s:textline('', '')
	elseif a:n == 2 || a:n == 3 || a:n == 5 || a:n == 7 || a:n == 10 || a:n == 11 " empty with ascii
		return s:textline('', s:ascii(a:n))
	elseif a:n == 4 " filename
		return s:textline(s:filename(), s:ascii(a:n))
	elseif a:n == 6 " author
		return s:textline("By: " . s:user() . " <" . s:mail() . ">", s:ascii(a:n))
	elseif a:n == 8 " created
		return s:textline("Created: " . s:date() . " by " . s:user(), s:ascii(a:n))
	elseif a:n == 9 " updated
		return s:textline("Updated: " . s:date() . " by " . s:user(), s:ascii(a:n))
	endif
endfunction

function! s:user() abort
	let l:user = $USER
	if strlen(l:user) == 0
		let l:user = "trx"
	endif
	return l:user
endfunction

function! s:mail() abort
	let l:mail = $MAIL
	if strlen(l:mail) == 0
		let l:mail = "tristan.kapous@protonmail.com"
	endif
	return l:mail
endfunction

function! s:filename() abort
	let l:filename = expand("%:t")
	if strlen(l:filename) == 0
		let l:filename = "< new >"
	endif
	return l:filename
endfunction

function! s:date() abort
	return strftime("%Y/%m/%d %H:%M:%S")
endfunction

function! s:insert() abort
	let l:line = 11
	" empty line after header
	call append(0, "")
	" loop over lines
	while l:line > 0
		call append(0, s:line(l:line))
		let l:line = l:line - 1
	endwhile
endfunction

function! s:update() abort
	call s:filetype()
	if getline(9) =~ s:start . repeat(' ', s:margin - strlen(s:start)) . "Updated: "
		if &mod
			call setline(9, s:line(9))
		endif
		call setline(4, s:line(4))
		return 0
	endif
	return 1
endfunction

function! Header101() abort
	if s:update()
		call s:insert()
	endif
endfunction

" Bind command and shortcut
command! Header101 call Header101()
" nnoremap <leader>h1 :Header101<cr>
nnoremap <silent> <leader>h1 :Header101<cr>
" au BufWritePre * call s:update ()

"""        Signature

function! MailSignature() abort
	let firstname = "Tristan"
	let surname = "Kapous"
	let email = "<tris@tristankapous.com>"
	let prefix = "--"

	let signature_undated = prefix . " " . firstname . " " . surname . " " . email
	if getline('$') =~ '^.*'.signature_undated
		:$d
	endif

	let signature = signature_undated . " " . strftime('%a, %d %b %Y %H:%M:%S %z')
	call append('$', signature)
endfunction

function! DebianLogSignature() abort
	let firstname = "Tristan"
	let surname = "Kapous"
	let email = "<tris@tristankapous.com>"
	let prefix = "--"

	let signature_undated = prefix . " " . firstname . " " . surname . " " . email
	let signature = signature_undated . " " . strftime('%a, %d %b %Y %H:%M:%S %z')
	if getline('.') =~ '^.*'.signature_undated
		call setline('.', signature)
	else
		call append('.', signature)
	endif
endfunction

" augroup SignOnSave
" 	au!
" 	au BufWritePre * call SignatureTime() | normal <c-o><c-o>
" augroup end

""    Dotfiles settings
"""        Filetype

augroup DotfilesSettings
	au!
	au BufEnter,BufWritePost bash_aliases,bashrc,inputrc,.bash_aliases,.bashrc,.inputrc
				\ set filetype=sh colorcolumn=0
augroup end

"""        Vimrc mappings

augroup VimrcMaps
	au!
	au FileType vim silent nnoremap <buffer> zM :setlocal foldlevel=0<cr>zm100<c-y>
	au FileType vim inoremap <buffer> ,""<space> ""<space><space><space><space>
	au FileType vim inoremap <buffer> ,"""<space> """<space><space><space><space><space><space><space><space>
	au FileType vim inoremap <buffer> ,''<space> ""<space><space><space><space>
	au FileType vim inoremap <buffer> ,'''<space> """<space><space><space><space><space><space><space><space>
augroup end

"""        Vimrc folding

function! VimFold() abort
	let line = getline(v:foldstart)

	let nucolwidth = &fdc + &number * &numberwidth
	let windowwidth = winwidth(0) - nucolwidth - 4
	if windowwidth > 79
		let windowwidth = 79
	endif
	let foldedlinecount = v:foldend - v:foldstart
	" expand tabs into spaces
	let onetab = strpart('          ', 0, &tabstop)
	let line = substitute(line, '\t', onetab, 'g')
	let longbreak=" "
	let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
	if len(line) > windowwidth - 15
		let line=line[0:windowwidth - 15]
		let longbreak="¬"
	endif
	let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
	return line . longbreak . repeat(" ", fillcharcount%2 + len(foldedlinecount) - 1) . '' . repeat(" .",fillcharcount/2 - 3) . repeat(" ", 5 - len(foldedlinecount)) . foldedlinecount . '    '
endfunction

"""        Vimrc modeline

" vim:tw=0:ts=4:sts=4:shiftwidth=4
" vim:foldmethod=expr:foldtext=VimFold()
" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-1)\:'='
