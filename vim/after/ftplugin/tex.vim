setlocal updatetime=1000
setlocal suffixesadd=.tex,.latex

" Navigating with guides
inoremap <buffer> <silent> ,, <esc>/<++><cr>"_4s
vnoremap <buffer> <silent> ,, <esc>/<++><cr>"_4s
nnoremap <buffer> <silent> ,, <esc>/<++><cr>"_4s

nnoremap <buffer> <silent> <leader>ll :LLPStartPreview

" Latex snippets
inoremap <buffer> ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><esc>6kf}i
inoremap <buffer> ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><esc>3kA
inoremap <buffer> ,exe \begin{exe}<Enter>\ex<space><Enter>\end{exe}<Enter><Enter><++><esc>3kA
inoremap <buffer> ,em \emph{}<++><esc>T{i
inoremap <buffer> ,bf \textbf{}<++><esc>T{i
vnoremap <buffer> , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
inoremap <buffer> ,it \textit{}<++><esc>T{i
inoremap <buffer> ,ct \textcite{}<++><esc>T{i
inoremap <buffer> ,cp \parencite{}<++><esc>T{i
inoremap <buffer> ,glos {\gll<space><++><space>\\<Enter><++><space>\\<Enter>\trans{``<++>''}}<esc>2k2bcw
inoremap <buffer> ,x \begin{xlist}<Enter>\ex<space><Enter>\end{xlist}<esc>kA<space>
inoremap <buffer> ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><esc>3kA\item<space>
inoremap <buffer> ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><esc>3kA\item<space>
inoremap <buffer> ,li <Enter>\item<space>
inoremap <buffer> ,dc <Enter>\documentclass<space>
inoremap <buffer> ,doc <Enter>\documentation<space>
inoremap <buffer> ,ref \ref{}<space><++><esc>T{i
inoremap <buffer> ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><esc>4kA{}<esc>i
inoremap <buffer> ,ot \begin{tableau}<Enter>\inp{<++>}<tab>\const{<++>}<tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><esc>5kA{}<esc>i
inoremap <buffer> ,can \cand{}<tab><++><esc>T{i
inoremap <buffer> ,con \const{}<tab><++><esc>T{i
inoremap <buffer> ,v \vio{}<tab><++><esc>T{i
inoremap <buffer> ,a \href{}{<++>}<space><++><esc>2T{i
inoremap <buffer> ,sc \textsc{}<space><++><esc>T{i
inoremap <buffer> ,chap \chapter{}<Enter><Enter><++><esc>2kf}i
inoremap <buffer> ,sec \section{}<Enter><Enter><++><esc>2kf}i
inoremap <buffer> ,ssec \subsection{}<Enter><Enter><++><esc>2kf}i
inoremap <buffer> ,sssec \subsubsection{}<Enter><Enter><++><esc>2kf}i
inoremap <buffer> ,st <esc>F{i*<esc>f}i
inoremap <buffer> ,beg \begin{}<Enter><++><Enter>\end{}<Enter><Enter><++><esc>4k0f{a
inoremap <buffer> ,up <esc>/usepackage<Enter>o\usepackage{}<esc>i
nnoremap <buffer> ,up /usepackage<Enter>o\usepackage{}<esc>i
inoremap <buffer> ,tt \texttt{}<space><++><esc>T{i
inoremap <buffer> ,bt {\blindtext}
inoremap <buffer> ,nu $\varnothing$
inoremap <buffer> ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<esc>5kA
inoremap <buffer> ,rn (\ref{})<++><esc>F}i

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
if ! empty('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
endif
let b:undo_ftplugin .= "setlocal updatetime< suffixesadd<"
