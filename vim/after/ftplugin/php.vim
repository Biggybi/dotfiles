setlocal suffixesadd=.php
setlocal colorcolumn=81

nnoremap <buffer> <leader>xst ciw<strong><c-o>P</strong><esc>T<
nnoremap <buffer> <leader>xst ciw<em><c-o>P</em><esc>T<

nnoremap <buffer> <c-w>u :40 wincmd\|<cr>

inoremap <buffer> ,php <?php<cr>?><esc>O
inoremap <buffer> ,bo <body></body><esc>F<i
inoremap <buffer> ,h1 <h1></h1><esc>F<i
inoremap <buffer> ,h2 <h2></h2><esc>F<i
inoremap <buffer> ,h3 <h3></h3><esc>F<i
inoremap <buffer> ,h4 <h4></h4><esc>F<i
inoremap <buffer> ,h5 <h5></h5><esc>F<i
inoremap <buffer> ,h6 <h6></h6><esc>F<i
inoremap <buffer> ,pp <p></p><esc>F<i
inoremap <buffer> ,br <br/>
inoremap <buffer> ,aa <a href="" alt=""></a><esc>F<i
inoremap <buffer> ,img <img src="" alt=""></img><esc>F<i
inoremap <buffer> ,uu <u></u><esc>F<i
inoremap <buffer> ,ii <i></i><esc>F<i
inoremap <buffer> ,bb <b></b><esc>F<i
inoremap <buffer> ,sk <strike></strike><esc>F<i
inoremap <buffer> ,sup <sup></sup><esc>F<i
inoremap <buffer> ,sub <sub></sub><esc>F<i
inoremap <buffer> ,sm <small></small><esc>F<i
inoremap <buffer> ,tt <tt></tt><esc>F<i
inoremap <buffer> ,pre <pre></pre><esc>F<i
inoremap <buffer> ,bq <blockquote></blockquote><esc>F<i
inoremap <buffer> ,st <strong></strong><esc>F<i
inoremap <buffer> ,em <em></em><esc>F<i
inoremap <buffer> ,ol <ol></ol><esc>F<i
inoremap <buffer> ,dd <dd></dd><esc>F<i
inoremap <buffer> ,dt <dt></dt><esc>F<i
inoremap <buffer> ,dl <dl></dl><esc>F<i
inoremap <buffer> ,ul <ul></ul><esc>F<i
inoremap <buffer> ,li <li></li><esc>F<i
inoremap <buffer> ,hr <hr></hr><esc>F<i
inoremap <buffer> ,di <div></div><esc>F<i
inoremap <buffer> ,sp <span></span><esc>F<i
inoremap <buffer> ,se <select></select><esc>F<i
inoremap <buffer> ,op <optionlect></optionlect><esc>F<i
inoremap <buffer> ,tx <textarealect></textarealect><esc>F<i

inoremap <buffer> ,fo <form action="" method=""><cr><input type="text" name=""><return></form>
inoremap <buffer> ,fg <form action="" method="get"><cr><input type="text" name=""><return></form>
inoremap <buffer> ,fp <form action="" method="post"><cr><input type="text" name=""><return></form>
inoremap <buffer> ,in <input type="" name="" value=""></input><esc>F<i

inoremap <buffer> ,ec echo "";<esc>hi
inoremap <buffer> ,ge $_GET[""]<esc>hi
inoremap <buffer> ,po $_POST[""]<esc>hi
inoremap <buffer> ,lorem Lorem ipsum dolor sit amet,
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

nnoremap <buffer> <leader>; i<c-o>mz<c-o>A;<esc>`z<esc>
nnoremap <buffer> <leader>, i<c-o>mz<c-o>A,<esc>`z<esc>

let b:undo_ftplugin = get(b:, 'undo_ftplugin' .. ' | ', '')
let b:undo_ftplugin .= "setlocal suffixesadd< colorcolumn<"
