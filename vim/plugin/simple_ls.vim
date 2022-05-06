if has('nvim')
  finish
endif
vim9script

command -bar -bang Ls Ls(<bang>0)

def Ls(bang: any)
    var bufnrs: list<number> = range(1, bufnr('$'))
    bufnrs->filter(bang
        ? (_, v: number): bool => bufexists(v)
        : (_, v: number): bool => buflisted(v)
        )
    var bufnames: list<string> = copy(bufnrs)
        ->mapnew((_, v: number): string => bufname(v)->fnamemodify(':t'))
    var uniq_flags: list<bool> = copy(bufnames)
        ->mapnew((_, v: string): bool => count(bufnames, v) == 1)
    var items: list<dict<any>> = bufnrs
        ->mapnew((i: number, v: number) => ({
            bufnr: v,
            text: Gettext(v, uniq_flags[i]),
            }))
    setloclist(0, [], ' ', {
        items: items,
        title: 'ls' .. (bang ? '!' : ''),
        quickfixtextfunc: 'Quickfixtextfunc',
        })
    lopen
    nmap <buffer><nowait><expr><silent> <cr> <sid>Cr()
enddef

def Cr(): string
    if w:quickfix_title =~ '^ls!\=$'
        var locid: number = win_getid()
        return "\<c-w>\<cr>\<plug>(close-location-window)" .. locid
            .. "\<cr>\<plug>(verticalize)"
    else
        return "\<c-w>\<cr>\<plug>(verticalize)"
    endif
enddef
nnoremap <plug>(close-location-window) :<c-u>call <sid>CloseLocationWindow()<cr>
nnoremap <plug>(verticalize) :<c-u>wincmd L<cr>
def CloseLocationWindow()
    var locid: number = input('')->str2nr()
    win_execute(locid, 'close')
enddef

def Gettext(v: number, is_uniq: bool): string
    var format: string = ' %*d%s%s%s%s%s %s'
    var bufnr: list<number> = [bufnr('$')->len(), v]
    var buflisted: string = !buflisted(v) ? 'u' : ' '
    var cur_or_alt: string = v == bufnr('%') ? '%' : v == bufnr('#') ? '#' : ' '
    var active_or_hidden: string = win_findbuf(v)->empty() ? 'h' : 'a'
    var modifiable: string = getbufvar(v, '&ma', 0) ? ' ' : '-'
    var modified: string = getbufvar(v, '&mod', 0) ? '+' : ' '
    var bufname: string = bufname(v)->empty()
        ?  '[No Name]'
        :   bufname(v)->fnamemodify(is_uniq ? ':t' : ':p')
    return call('printf', [format]
        + bufnr
        + [buflisted, cur_or_alt, active_or_hidden,
           modifiable, modified, bufname])
enddef

def Quickfixtextfunc(info: dict<number>): list<any>
    var items: list<dict<any>> = getloclist(info.winid, {id: info.id, items: 1}).items
    var l: list<string> = []
    for idx in range(info.start_idx - 1, info.end_idx - 1)
        add(l, items[idx].text)
    endfor
    return l
enddef
