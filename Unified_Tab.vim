set encoding=utf-8
scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0 expandtab:
" (この行に関しては:help modelineを参照)



"---------------------------------------------------------------------------------------------

function Unified_Tab(m)
  if &diff
    if a:m > 0
      " Next Hunk
      normal! ]c
    else
      " Previouse Hunk
      normal! [c
    endif
    normal! ^

  "elseif win_getid()->getwininfo()[0].loclist == 1
  elseif IsLocationlistWindowOpen()
    "例外をキャッチしないと、最初と最後の要素の次に移動しようとして例外で落ちる。
    try
      if a:m > 0
        lnext
      else
        lprev
      endif
    catch /:E553/
      " TODO Popup Windowにする？
      echohl Search
      echo a:m > 0 ?  'Last location list.' : '1st location list.'
      echohl None
    endtry

  else
    "例外をキャッチしないと、最初と最後の要素の次に移動しようとして例外で落ちる。
    try
      if a:m > 0
        cnext
      else
        cprev
      endif
    catch /:E553/
      " TODO Popup Windowにする？
      echohl Search
      echo a:m > 0 ?  'Last error list.' : '1st error list.'
      echohl None
    endtry
  endif

  FuncNameStl
  return
endfunction


function! GetLocationlistWinid()
  return getloclist(winnr(), {'winid' : 0}).winid
endfunction

function! IsLocationlistWindowOpen()
  return GetLocationlistWinid() != 0
endfunction



"---------------------------------------------------------------------------------------------

nnoremap <silent>         t :<C-u>call Unified_Tab( 1)<CR>
nnoremap <silent>         T :<C-u>call Unified_Tab(-1)<CR>
nnoremap <silent>        gt :<C-u>cfirst<CR>
nnoremap <silent>        gT :<C-u>clast<CR>
nnoremap <silent> <Leader>T :<C-u>cc<CR>


nnoremap <silent>       m :<C-u>call Unified_Tab( 1)<CR>
nnoremap <silent>       M :<C-u>call Unified_Tab(-1)<CR>

nnoremap <silent>         <Tab> :<C-u>call Unified_Tab( 1)<CR>
nnoremap <silent>       <S-Tab> :<C-u>call Unified_Tab(-1)<CR>
nnoremap <silent>        g<Tab> :<C-u>cfirst<CR>
nnoremap <silent>        g<Tab> :<C-u>clast<CR>
nnoremap <silent> <Leader><Tab> :<C-u>cc<CR>

"nnoremap <silent>       t ^
"nnoremap <silent>       T $

"nnoremap <silent>       m J



"---------------------------------------------------------------------------------------------

" com! -nargs=? -complete=customlist,s:CompletionTabline Tabline call <SID>ToggleTabline(<args>)

function! s:ToggleTabline(arg)
  if (a:arg . '') == ''
    echo s:TablineStatus
  elseif (a:arg . '') == '+'
    let s:TablineStatus = ( s:TablineStatus + 1 ) % s:TablineStatusNum
  elseif (a:arg . '') == '-'
    let s:TablineStatus = ( s:TablineStatus - 1 ) % s:TablineStatusNum
  elseif a:arg < s:TablineStatusNum
    let s:TablineStatus = a:arg
  else
    echoerr 'Tabline:Invalid argument.'
    return
  endif

  let &showtabline = ( s:TablineStatus == 0 ? 0 : 2 )

  call UpdateTabline(0)
endfunction

let s:TablineStatusNum = 8

function! s:CompletionTabline(ArgLead, CmdLine, CusorPos)
  return map(range(0, s:TablineStatusNum), 'v:val . ""') + ['+', '-']
endfunction



"---------------------------------------------------------------------------------------------

iab FORI for ( uint32_t i = 0U; i < N; i++ ) {<CR><CR>}
iab <silent> FORI for ( uint32_t i = 0U; i < N; i++ ) {<CR><CR>}<C-R>=Eatchar('\s')<CR>

iab LOOP while ( 1 ) {<CR>}



"---------------------------------------------------------------------------------------------
nnoremap <Leader><C-s>           :<C-u>g%<C-r>/%s    %%%g<Left><Left><Left>
vnoremap <Leader><C-s>                :g%<C-r>/%s     %%%g<Left><Left><Left>

nnoremap <Leader><C-s>           :<C-u>g!<C-r>/!<Space>
vnoremap <Leader><C-s>                :g!<C-r>/!<Space>


"---------------------------------------------------------------------------------------------

cmap <expr> <CR> ( getcmdtype() == '/' ) ?
               \ ( '<Plug>(Search-SlashCR)' ) :
               \ ( getcmdtype() == ':' && getcmdline() =~# '^:*cd \?') ?
               \ ( '<C-e><C-u>echo "cdは使用禁止。pw[d]かlc[d]を使用。"<CR>' ) :
               \ ( getcmdtype() == ':' && getcmdline() =~# '^:*lcd\? *$') ?
               \ ( '<C-e><C-u>echo "引数なしのlcdは使用禁止。pw[d]を使用。"<CR>' ) :
               \ ( '<CR>' )



"---------------------------------------------------------------------------------------------

nnoremap ' "






"---------------------------------------------------------------------------------------------




