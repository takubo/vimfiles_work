"---------------------------------------------------------------------------------------------
" Unified_Tab.vim



"---------------------------------------------------------------------------------------------
com! IIG InsertIncludeGurd
com! InsertIncludeGurd call s:InsertIncludeGurd()


function! s:InsertIncludeGurd()
  let fn = expand('%')
  let fn = toupper(fn)
  let fn = substitute(fn, '\W', '_', 'g')
  let fn = (exists('g:IncludeGuardPrefix') ? g:IncludeGuardPrefix : '') . fn
  let fn0 = "#ifndef\t" . fn
  let fn1 = "#define\t" . fn
  let fn2 = "#endif\t/* " . fn . " */"
  call append(0, fn0)
  call append(1, fn1)
  call append(line('$'), fn2)
  echo fn
endfunction



"---------------------------------------------------------------------------------------------

let s:Ind = 4

function! IfStruct()
  let ind = -s:Ind
  for i in range(1, line('$'))
    let c = getline(i)

    if c =~# 'T_PortLvdsCfg'
      "echo repeat(' ', ind < 0 ? 0 : s:Ind * ind) . '........................................'
      echo repeat(' ', s:Ind + ind) . '........................................'
    endif
    if i == line('.')
      "echo repeat(' ', ind < 0 ? 0 : s:Ind * ind) . '........................................'
    endif

    if     c =~# '^\s*#\s*if'
      let ind += s:Ind
    elseif c =~# '^\s*#\s*elif'
    elseif c =~# '^\s*#\s*else'
    elseif c =~# '^\s*#\s*endif'
    else
      continue
    endif
    echo repeat(' ', s:Ind * ind) . c

    if     c =~# '^\s*#\s*endif'
      " 見やすいように、endifの後には空行を出力。
      echo "\n"
      let ind -= s:Ind
    endif
  endfor
endfunction

function! IfStruct()
  let ind = -s:Ind
  for i in range(1, line('$'))
    let c = getline(i)

    if c =~# 'T_PortLvdsCfg'
      echo repeat(' ', ind + s:Ind) . "T_PortLvdsCfg"
    endif
    if i == line('.')
      "echo repeat(' ', ind + s:Ind) . '........................................'
    endif

    if     c =~# '^\s*#\s*if'
      let ind += s:Ind
    elseif c =~# '^\s*#\s*elif'
    elseif c =~# '^\s*#\s*else'
    elseif c =~# '^\s*#\s*endif'
    else
      continue
    endif
    echo repeat(' ', ind) . c

    if     c =~# '^\s*#\s*endif'
      " 見やすいように、endifの後には空行を出力。
      echo "\n"
      let ind -= s:Ind
    endif
  endfor
endfunction

com! IfStruct call IfStruct()


com! IfS call s:cmd_out_capture()

function! s:cmd_out_capture()
  new
  silent put =execute('IfStruct')
  1,2delete _
endfunction


function! s:CommnadOutput()
  redir => result
  silent execute 'IfStruct'
  redir END
  return result
endfunction

" let @*=execute('IfStruct')



"---------------------------------------------------------------------------------------------

nnoremap <Leader><C-p> :<C-u>call <SID>next_nonamebuf(-1)<CR>
nnoremap <Leader><C-n> :<C-u>call <SID>next_nonamebuf(+1)<CR>

function! s:next_nonamebuf(n)
  let first_buf = 1
  let cur_buf = bufnr()
  let last_buf = bufnr('$')

  if a:n > 0
    let sta1 = cur_buf + 1
    let end1 = last_buf

    let sta2 = first_buf
    let end2 = cur_buf - 1

    let dis = +1
  else
    let sta1 = cur_buf - 1
    let end1 = first_buf

    let sta2 = last_buf
    let end2 = cur_buf + 1

    let dis = -1
  endif

  if !s:next_nonamebuf_sub(sta1, end1, dis)
    call s:next_nonamebuf_sub(sta2, end2, dis)
  endif
endfunction

function! s:next_nonamebuf_sub(sta, end, dis )
  "echo  a:sta a:end a:dis
  for i in range(a:sta, a:end, a:dis)
    "echo i bufname(i)
    if buflisted(i) && bufname(i) == '' " && buf modified
      exe 'b' i
      return v:true
    endif
  endfor
  return v:false
endfunction



"---------------------------------------------------------------------------------------------
" unified_tab_note.vim 


"---------------------------------------------------------------------------------------------
com! IIG InsertIncludeGurd
com! InsertIncludeGurd call s:InsertIncludeGurd()


function! s:InsertIncludeGurd()
  let fn = expand('%')
  let fn = toupper(fn)
  let fn = substitute(fn, '\W', '_', 'g')
  let fn = (exists('g:IncludeGuardPrefix') ? g:IncludeGuardPrefix : '') . fn
  let fn0 = "#ifndef\t" . fn
  let fn1 = "#define\t" . fn
  let fn2 = "#endif\t/* " . fn . " */"
  call append(0, fn0)
  call append(1, fn1)
  call append(line('$'), fn2)
  echo fn
endfunction



"---------------------------------------------------------------------------------------------
" if-def の構造を可視化する。

let s:Indent = 4

"? function! IfDefStruct()
"?   let ind = -s:Indent
"?   for i in range(1, line('$'))
"?     let c = getline(i)
"? 
"?     if i == line('.')
"?       "echo repeat(' ', ind < 0 ? 0 : s:Indent * ind) . '........................................'
"?     endif
"? 
"?     if     c =~# '^\s*#\s*if'
"?       let ind += s:Indent
"?     elseif c =~# '^\s*#\s*elif'
"?     elseif c =~# '^\s*#\s*else'
"?     elseif c =~# '^\s*#\s*endif'
"?     else
"?       continue
"?     endif
"?     echo repeat(' ', s:Indent * ind) . c
"? 
"?     if     c =~# '^\s*#\s*endif'
"?       " 見やすいように、endifの後には空行を出力。
"?       echo "\n"
"?       let ind -= s:Indent
"?     endif
"?   endfor
"? endfunction

function! IfDefStruct()
  let ind = -s:Indent
  for i in range(1, line('$'))
    let c = getline(i)

    if i == line('.')
      echo repeat(' ', ind + s:Indent) . '........................................'
    endif

    if     c =~# '^\s*#\s*if'
      let ind += s:Indent
    elseif c =~# '^\s*#\s*elif'
    elseif c =~# '^\s*#\s*else'
    elseif c =~# '^\s*#\s*endif'
    else
      continue
    endif
    echo repeat(' ', ind) . c

    if     c =~# '^\s*#\s*endif'
      " 見やすいように、endifの後には空行を出力。
      echo "\n"
      let ind -= s:Indent
    endif
  endfor
endfunction

com! IfDefStruct call IfDefStruct()


com! IfDefStructInBuffer call s:IfDefStructInBuffer()

"? function! s:IfDefStructInBuffer()
"?   new
"?   silent put =execute('IfDefStruct')
"?   1,2delete _
"? endfunction

function! s:IfDefStructInBuffer()
  let temp = execute('IfDefStruct')
  new
  silent put =temp
  1,2delete _
endfunction


function! s:CommnadOutput()
  redir => result
  silent execute 'IfDefStruct'
  redir END
  return result
endfunction

" let @*=execute('IfDefStruct')



"---------------------------------------------------------------------------------------------

nnoremap <Leader><C-p> :<C-u>call <SID>next_nonamebuf(-1)<CR>
nnoremap <Leader><C-n> :<C-u>call <SID>next_nonamebuf(+1)<CR>

function! s:next_nonamebuf(n)
  let first_buf = 1
  let cur_buf = bufnr()
  let last_buf = bufnr('$')

  if a:n > 0
    let sta1 = cur_buf + 1
    let end1 = last_buf

    let sta2 = first_buf
    let end2 = cur_buf - 1

    let dis = +1
  else
    let sta1 = cur_buf - 1
    let end1 = first_buf

    let sta2 = last_buf
    let end2 = cur_buf + 1

    let dis = -1
  endif

  if !s:next_nonamebuf_sub(sta1, end1, dis)
    call s:next_nonamebuf_sub(sta2, end2, dis)
  endif
endfunction

function! s:next_nonamebuf_sub(sta, end, dis )
  "echo  a:sta a:end a:dis
  for i in range(a:sta, a:end, a:dis)
    "echo i bufname(i)
    if buflisted(i) && bufname(i) == '' " && buf modified
      exe 'b' i
      return v:true
    endif
  endfor
  return v:false
endfunction



"---------------------------------------------------------------------------------------------

nnoremap <Leader><C-p> :<C-u>call <SID>next_modified_nonamebuf(-1)<CR>
nnoremap <Leader><C-n> :<C-u>call <SID>next_modified_nonamebuf(+1)<CR>

function! s:next_modified_nonamebuf(n)
  let first_buf = 1
  let cur_buf = bufnr()
  let last_buf = bufnr('$')

  if a:n > 0
    let sta1 = cur_buf + 1
    let end1 = last_buf

    let sta2 = first_buf
    let end2 = cur_buf - 1

    let dis = +1
  else
    let sta1 = cur_buf - 1
    let end1 = first_buf

    let sta2 = last_buf
    let end2 = cur_buf + 1

    let dis = -1
  endif

  if !s:next_modified_nonamebuf_sub(sta1, end1, dis)
    if !s:next_modified_nonamebuf_sub(sta2, end2, dis)
      echo '変更された無名バッファはありません。'
    endif
  endif
endfunction

function! s:next_modified_nonamebuf_sub(sta, end, dis )
  "echo  a:sta a:end a:dis
  for i in range(a:sta, a:end, a:dis)
    if buflisted(i) && bufname(i) == '' && getbufinfo(i)[0].changed
      exe 'b' i
      return v:true
    endif
  endfor
  return v:false
endfunction



"---------------------------------------------------------------------------------------------

com! KakkoZenkaku s/(/（/g |  s/)/）/g


"---------------------------------------------------------------------------------------------

com! NoWrap PushPosAll | exe 'windo set nowrap' | PopPosAll
com! WinNoWrap PushPosAll | exe 'windo set nowrap' | PopPosAll
com! AllNoWrap PushPosAll | exe 'windo set nowrap' | PopPosAll

com! Wrap PushPosAll | exe 'windo set wrap' | PopPosAll
com! WinWrap PushPosAll | exe 'windo set wrap' | PopPosAll
com! AllWrap PushPosAll | exe 'windo set wrap' | PopPosAll



"---------------------------------------------------------------------------------------------
" vimrc



" Util Commands {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


"com! AR setl autoread!
com! AR let &l:autoread = !&l:autoread


com! Tab2Space setlocal   expandtab | retab<CR>
com! Space2Tab setlocal noexpandtab | retab!<CR>
com! T2S Tab2Space
com! S2T Space2Tab


com! FL help function-list<CR>


com! -nargs=1 Unicode exe 'normal! o<C-v>u' . tolower('<args>') . '<Esc>'


com! XMLShape :%s/></>\r</g | filetype indent on | setf xml | normal gg=G


" Windowsでの設定例です。他の場合は外部コマンド部分を読み替えてください。
au FileType plantuml com! OpenUml :!/cygdrive/c/Program\ Files/Google/Chrome/Application/chrome.exe %


" ifdefを閉じる
com! FoldIfdef setl foldmarker=#if,#endif | setl foldmethod=marker | normal! zM


com! Branch echo FugitiveHead(7)


" Util Commands }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



"-------------------------------------------------------------------
" カーソル下のhighlight情報を表示する {{{
function! s:get_syn_id(transparent)
    let synid = synID(line('.'), col('.'), 1)
    return a:transparent ? synIDtrans(synid) : synid
endfunction
function! s:get_syn_name(synid)
    return synIDattr(a:synid, 'name')
endfunction
function! s:get_highlight_info()
    execute "highlight " . s:get_syn_name(s:get_syn_id(0))
    execute "highlight " . s:get_syn_name(s:get_syn_id(1))
endfunction
command! HighlightInfo call s:get_highlight_info()
"-------------------------------------------------------------------



" {{{
function! SurroundLineBrace() range
" echo a:firstline a:lastline
" red
" sleep 2
  exe a:lastline
  normal! o}
  exe a:firstline
  normal! O{
  normal! j>i{>a{
endfunction

com! -range Brace <line1>,<line2>call SurroundLineBrace()
vnoremap J :Brace<CR>
" }}}



" Vertical-f {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

com! -nargs=1 VerticalF let @m=<q-args> | call search('^\s*'. @m)
com! -nargs=1 VerticalFBack let @m=<q-args> | call search('^\s*'. @m, 'b')
nnoremap <C-g>j :VerticalF<Space>
nnoremap <C-g>k :VerticalFBack<Space>

" Vertical-f }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Util Commands {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


"com! AR let &l:autoread = !&l:autoread
com! AR setl autoread!


com! Tab2Space setlocal   expandtab | retab
com! Space2Tab setlocal noexpandtab | retab!
com! T2S Tab2Space
com! S2T Space2Tab


com! FL help function-list<CR>


com! -nargs=1 Unicode exe 'normal! o<C-v>u' . tolower('<args>') . '<Esc>'


com! XMLShape :%s/></>\r</g | filetype indent on | setf xml | normal gg=G


" Windowsでの設定例です。他の場合は外部コマンド部分を読み替えてください。
au FileType plantuml com! OpenUml :!/cygdrive/c/Program\ Files/Google/Chrome/Application/chrome.exe %


" ifdefを閉じる
com! FoldIfdef setl foldmarker=#if,#endif | setl foldmethod=marker | normal! zM
com! IfdefFold FoldIfdef


com! Branch echo FugitiveHead(7)


" Util Commands }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



"-------------------------------------------------------------------
" カーソル下のhighlight情報を表示する {{{
function! s:get_syn_id(transparent)
    let synid = synID(line('.'), col('.'), 1)
    return a:transparent ? synIDtrans(synid) : synid
endfunction
function! s:get_syn_name(synid)
    return synIDattr(a:synid, 'name')
endfunction
function! s:get_highlight_info()
    execute "highlight " . s:get_syn_name(s:get_syn_id(0))
    execute "highlight " . s:get_syn_name(s:get_syn_id(1))
endfunction
command! HighlightInfo call s:get_highlight_info()
"-------------------------------------------------------------------



" {{{
function! SurroundLineBrace() range
" echo a:firstline a:lastline
" red
" sleep 2
  exe a:lastline
  normal! o}
  exe a:firstline
  normal! O{
  normal! j>i{>a{
endfunction

com! -range Brace <line1>,<line2>call SurroundLineBrace()
"vnoremap J :Brace<CR>
" }}}



com! Date echo system("date")
com! Cal echo system("cal")
com! Cal echo system("cal") <Bar> echo system("date")
com! Cal echo ' ' <Bar> echo system("date") <Bar> echo ' ' <Bar> echo ' ' <Bar> echo system("cal")



com! -bar -nargs=? ETempfile exe 'edit'      tempname() . (<q-args> =~ '^[^.]' ? '.' . <q-args> : <q-args>)
com! -bar -nargs=? STempfile exe 'split'     tempname() . (<q-args> =~ '^[^.]' ? '.' . <q-args> : <q-args>)
com! -bar -nargs=? VTempfile exe 'vsplit'    tempname() . (<q-args> =~ '^[^.]' ? '.' . <q-args> : <q-args>)
com! -bar -nargs=? TTempfile exe 'tab split' tempname() . (<q-args> =~ '^[^.]' ? '.' . <q-args> : <q-args>)
com! -bar -nargs=? Tempfile  STempfile <args>


com! -bar FAM aunmenu ]Toolbar | exe 'amenu' ']Toolbar.' . cfi#format('%s ()', '') ':echo<CR>'
com! FSM FAM | popup ]Toolbar
nnoremap , :<C-u>FSM<CR>
"nnoremap , :<C-u>FSM<CR>:3sleep<CR><Esc>


com! Time call popup_create( strftime('%Y/%m/%d (%a)    %X'), #{
        \ pos: 'center',
        \ moved: 'any',
        \ tabpage: 0,
        \ wrap: v:false,
        \ zindex: 200,
        \ highlight: 'NormalPop',
        \ border: [2, 2, 2, 2],
        \ close: 'click',
        \ padding: [2, 4, 2, 4],
        \ })
        " time: a:time,
        " minwidth: 30,
        " maxheight: &lines - 4 - 3,
        " mask: mask
        " filter: 'popup_filter_menu',


iab <silent> inc  #include ""<Left><C-x><C-f><C-R>=Eatchar('\s')<CR>
iab <silent> inca #include ""<Left>src_a/<C-x><C-f><C-R>=Eatchar('\s')<CR>
iab <silent> inci #include ""<Left>inc/<C-x><C-f><C-R>=Eatchar('\s')<CR>



"? function! PyCyg()
"? python3 << PYCODE
"? import subprocess
"? subprocess.Popen(["C:/cygwin/bin/mintty.exe", "--title", "Vim Term", "--size", "160,50", "-o", "Locale=ja_JP", "-o", "Charset=UTF-8", "C:/cygwin/bin/zsh.exe"])  # , "-B", "frame"
"? PYCODE
"? endfunction
"? com! PyCyg call PyCyg()

"nnoremap <silent> <C-z> :<C-u>SH2<CR>
"nnoremap <silent> <C-z> :<C-u>PyCyg<CR>



" vim.vim {{{



function! L() range
  echo a:lastline - a:firstline + 1
endfunction
com! -range L <line1>, <line2> call L()
"vnoremap <silent> L :L<CR>
nnoremap <Leader>l :<C-u>echo len("<C-r><C-w>")<CR>



function! TempHighLight()
  let w = expand("<cword>")
  let g:TagMatch0 = matchadd('TagMatch', '\<'.w.'\>')
  let g:TimerTagMatch0 = timer_start(1500, 'QQQQ')
  let g:TagMatchI[g:TimerTagMatch0] = g:TagMatch0
endfunction
"nnoremap <F5>  :<C-u>call TempHighLight()<CR>
"nnoremap <C-n> :<C-u>call TempHighLight()<CR>
"nnoremap <silent> @ :<C-u>call TempHighLight()<CR>



nnoremap <silent> gL :<C-u>call GLLLL()<CR>

function! GLLLL()
  PushPosAll
  let wrap = !&l:wrap
  windo let &l:wrap = wrap
  PopPosAll
endfunction



" TabStopを簡単に変える {{{
com! -nargs=? Ts let &l:ts = ( "<args>" == "" ? 8 : "<args>" )
com! -nargs=? TS Ts <args>

call submode#enter_with('TabStop', 'n', '', '<space><Tab>', '<Nop>')
call submode#map(       'TabStop', 'n', '', 'h', ':let &l:ts-=10<CR>')
call submode#map(       'TabStop', 'n', '', 'j', ':let &l:ts-=1 <CR>')
call submode#map(       'TabStop', 'n', '', 'k', ':let &l:ts+=1 <CR>')
call submode#map(       'TabStop', 'n', '', 'l', ':let &l:ts+=10<CR>')
call submode#map(       'TabStop', 'n', '', '<', ':let &l:ts-=1 <CR>')
call submode#map(       'TabStop', 'n', '', '>', ':let &l:ts+=1 <CR>')
" }}}



" メーデー Tablineを非表示にする
com! Mayday set showtabline=0
com! MayDay Mayday
com! MAYDAY Mayday



" vim.vim }}}



func! s:func_copy_cmd_output(cmd)
  redir @*>
  silent execute a:cmd
  redir END
endfunc

command! -nargs=1 -complete=command CopyCmdOutput call <SID>func_copy_cmd_output(<q-args>)



function! s:mk_temp(...)
  let c = 'sp '
  if a:0 > 0
    if     a:1 =~ '^e' | let c = 'e '
    elseif a:1 =~ '^n' | let c = 'e '
    elseif a:1 =~ '^t' | let c = 'tabnew '
    elseif a:1 =~ '^v' | let c = 'vs '
    endif
  endif
  exe c . tempname()
endfunction
com! -nargs=? TF call <SID>mk_temp(<f-args>)
com! -nargs=? TFe call <SID>mk_temp("e")
com! -nargs=? TFs call <SID>mk_temp("s")
com! -nargs=? TFt call <SID>mk_temp("t")
com! -nargs=? TFv call <SID>mk_temp("v")
"com! TF exe "sp " . tempname()

" type は、"r"かそれ以外""
"exe "r!~/bin/matsub " . expand("#24:p") . " " . expand("#23:p")
function! Test0(type, cmd, ...)

  "let cmd = (a:type == 'r' ? a:type : '') . '!' . a:cmd
  let cmd = (a:type == 'r' ? a:type : '') . '!' . (a:cmd == '0' ? expand('%:p') : a:cmd)

  if a:0 == 0
    let cmd .= ' ' .  expand('%:p')
  else
    for i in a:000
      if i =~ '^\d\+$'
        let cmd .= ' ' . (i == 0 ? expand('%:p') : expand('#' . i . ':p'))
      else 
        let cmd .= ' ' . i
      endif
    endfor
  endif

  "echo cmd
  exe cmd
endfunction
" call Test0("r", "ls", 5, 8)
com! -nargs=* R call Test0('r', <f-args>)
com! -nargs=* P call Test0('n', <f-args>)



" IncSubstitude
"

function! IncSubstitude(...)
  echo a:000 a:0 a:1 a:2 a:3
  normal! gg
  for i in range(1, a:2)
    normal! n
    "echo i
    "exe 'normal! ' . '/' . a:1
    let s = 's/' . a:1 . '/' . printf(a:3, i) . '/'
    "echo s
    exe s
    "red
    "sleep 0.5
  endfor
endfunction
com! -nargs=* IncSubstitude call IncSubstitude('@', <f-args>)
"IncSubstitude 15 【テストケース%d】














" function! g:Get_highlight_info()
" 	let hl = []
" 	let old = ""
" 	for i in range(10)	" とりあえず10。普通はbreakする。
" 		let tmp = s:get_syn_name(s:get_syn_id(i))
" 		if tmp == old | break | endif
" 		let old = tmp
" 		call add(hl, tmp)
" 
" 		if 
" 		echo hl[i]
" 	endfor
" endfunction

" カーソル下のhighlight情報を表示する {{{

function! s:get_syn_id(transparent, col)
  let synid = synID(line('.'), a:col, 1)
  return a:transparent ? synIDtrans(synid) : synid
endfunction

function! s:get_syn_name(synid)
  return synIDattr(a:synid, 'name')
endfunction

function! g:Get_highlight_info(show, cont)
  let N = 10	" とりあえず10。普通はbreakする。

  let old = ""

  for i in range(N)	" 普通はbreakする。
    let hl = s:get_syn_name(s:get_syn_id(i, col('.')))

    if hl == old | break | endif
    let old = hl

    if a:show | echo '. ' . hl i | endif

    if hl =~? 'comment'	| return -1 | endif		" Block Comment
    if hl =~? 'string'	| return  1 | endif		" String
  endfor

  if a:cont
    let old = ""
    for i in range(N)	" 普通はbreakする。
      let hl = s:get_syn_name(s:get_syn_id(i, 1))

      if hl == old | break | endif
      let old = hl

      if a:show | echo '1 ' . hl | endif

      if hl =~? 'comment'	| return -1 | endif		" Block Comment
      "if hl =~? 'string'	| return  1 | endif		" String
    endfor
  endif

  return 0	" Normal
endfunction

command! HighlightInfo call g:Get_highlight_info(1, 1)


function! g:Get_highlight_info_LineLast(show, cont, off)
  let N = 10	" とりあえず10。普通はbreakする。

  let old = ""

  for i in range(N)	" 普通はbreakする。
    let hl = s:get_syn_name(s:get_syn_id(i, col('.')+a:off))

    if hl == old | break | endif
    let old = hl

    if a:show | echo '. ' . hl i | endif

    if hl =~? 'comment'	| return -1 | endif		" Block Comment
    if hl =~? 'string'	| return  1 | endif		" String
  endfor

  if a:cont
    let old = ""
    for i in range(N)	" 普通はbreakする。
      let hl = s:get_syn_name(s:get_syn_id(i, 1))

      if hl == old | break | endif
      let old = hl

      if a:show | echo '1 ' . hl | endif

      if hl =~? 'comment'	| return -1 | endif		" Block Comment
      "if hl =~? 'string'	| return  1 | endif		" String
    endfor
  endif

  return 0	" Normal
endfunction

"   echo hl_lang
"   echo hl_univ



"" " カーソル下のhighlight情報を表示する {{{
"" 
"" function! s:get_syn_id(transparent)
""   let synid = synID(line("."), col("."), 1)
""   if a:transparent
""     return synIDtrans(synid)
""   else
""     return synid
""   endif
"" endfunction
"" function! s:get_syn_attr(synid)
""   let name = synIDattr(a:synid, "name")
""   let ctermfg = synIDattr(a:synid, "fg", "cterm")
""   let ctermbg = synIDattr(a:synid, "bg", "cterm")
""   let guifg = synIDattr(a:synid, "fg", "gui")
""   let guibg = synIDattr(a:synid, "bg", "gui")
""   return {
""         \ "name": name,
""         \ "ctermfg": ctermfg,
""         \ "ctermbg": ctermbg,
""         \ "guifg": guifg,
""         \ "guibg": guibg}
"" endfunction
"" function! s:get_syn_info()
""   let baseSyn = s:get_syn_attr(s:get_syn_id(0))
""   echo "name: " . baseSyn.name .
""         \ " ctermfg: " . baseSyn.ctermfg .
""         \ " ctermbg: " . baseSyn.ctermbg .
""         \ " guifg: " . baseSyn.guifg .
""         \ " guibg: " . baseSyn.guibg
""   let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
""   echo "link to"
""   echo "name: " . linkedSyn.name .
""         \ " ctermfg: " . linkedSyn.ctermfg .
""         \ " ctermbg: " . linkedSyn.ctermbg .
""         \ " guifg: " . linkedSyn.guifg .
""         \ " guibg: " . linkedSyn.guibg
"" endfunction
"" command! SyntaxInfo call s:get_syn_info()



">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
function! CountFunctionLines()
  " 現在位置を保存
  let cur = line('.')
  normal! H
  let cur_top = line('.')
  execute 'normal ' . cur . 'G'
  " 関数先頭へ移動
  normal! [[
  let s = line('.')
  " 関数末尾へ移動
  normal! ][
  let e = line('.')
  " 結果表示
  echo e - s + 1
  " 保存していた位置に戻る
  execute 'normal ' . cur_top . 'G'
  normal! z<CR>
  execute 'normal ' . cur . 'G'
endfunction
command! FuncLines call CountFunctionLines()
"nnoremap <silent> <leader>l :<C-u>FuncLines<CR>
"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



com! Utf8  setl fileencoding=utf-8
com! Cp932 setl fileencoding=cp932





" Func Inner Search ---------------------------------

"function s:func_inner_search()
function! FuncInnerSearch()
  let lines = FuncRange()

  let search = '\%>' . (lines[0] - 1) . 'l\%<' . (lines[1]  + 1). 'l'

  return search
endfunction

" TODO Cの特定の書き方しか対応してない。
function! FuncRange() 
  PushPos

  " 2jは、関数の先頭に居た時用
  " 2kは、関数定義行を含むため
  " TODO いずれも暫定
  keepjumps normal! 2j[[2k
  let first_line = line('.')
  keepjumps normal! ][
  let last_line = line('.')

  PopPos

  return [first_line, last_line]
endfunction




com! III normal! i" Path {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{<CR>" Path }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}<Esc>k0w


"com! -nargs=? CheckIncludes CommnadOutputCapture checkpath! | normal! /<args><CR>
com! -nargs=? CheckIncludes CommnadOutputCapture checkpath! | call feedkeys('/<args><CR>', 'n')
com! -nargs=? CheckPath CommnadOutputCapture checkpath! | call feedkeys('/<args><CR>', 'n')



" Markdown

function! MdBar()
  let pre_line = line('.') - 1
  let str = getline(pre_line)
  let width = strdisplaywidth(str, 0)
  call setline('.', repeat('-', width))
  "echo pre_line str width bar
endfunction
com! MdBar call MdBar()

com! MdGrep grep -B1 -- '^---' %

" call setline(line('.'), '')



nnoremap : :<C-u>find<Space>
nnoremap <Leader>: :<C-u>find<Space>
nnoremap <Leader>g :<C-u>find<Space>
nnoremap <Leader>G :<C-u>sfind<Space>



" 単語文字数
augroup WordLen
  autocmd!
  "autocmd CursorMoved * echo len(expand('<cword>'))
augroup END



function! Mdbar()
  let s = getline('.')
  let l = strdisplaywidth(s)
  exe 'normal! o' . repeat('-', l) . '<Esc>'
endfunction
com! Mdbar call MdBar()


"---------------------------------------------------------------------------------------------
com! IIG InsertIncludeGurd
com! InsertIncludeGurd call s:InsertIncludeGurd()


function! s:InsertIncludeGurd()
  let fn = expand('%')
  let fn = toupper(fn)
  let fn = substitute(fn, '\W', '_', 'g')
  let fn = (exists('g:IncludeGuardPrefix') ? g:IncludeGuardPrefix : '') . fn
  let fn0 = "#ifndef\t" . fn
  let fn1 = "#define\t" . fn
  let fn2 = "#endif\t/* " . fn . " */"
  call append(0, fn0)
  call append(1, fn1)
  call append(line('$'), fn2)
  echo fn
endfunction



"---------------------------------------------------------------------------------------------

let s:Ind = 4

function! IfStruct()
  let ind = -s:Ind
  for i in range(1, line('$'))
    let c = getline(i)

    if c =~# 'T_PortLvdsCfg'
      "echo repeat(' ', ind < 0 ? 0 : s:Ind * ind) . '........................................'
      echo repeat(' ', s:Ind + ind) . '........................................'
    endif
    if i == line('.')
      "echo repeat(' ', ind < 0 ? 0 : s:Ind * ind) . '........................................'
    endif

    if     c =~# '^\s*#\s*if'
      let ind += s:Ind
    elseif c =~# '^\s*#\s*elif'
    elseif c =~# '^\s*#\s*else'
    elseif c =~# '^\s*#\s*endif'
    else
      continue
    endif
    echo repeat(' ', s:Ind * ind) . c

    if     c =~# '^\s*#\s*endif'
      " 見やすいように、endifの後には空行を出力。
      echo "\n"
      let ind -= s:Ind
    endif
  endfor
endfunction

function! IfStruct()
  let ind = -s:Ind
  for i in range(1, line('$'))
    let c = getline(i)

    if c =~# 'T_PortLvdsCfg'
      echo repeat(' ', ind + s:Ind) . "T_PortLvdsCfg"
    endif
    if i == line('.')
      "echo repeat(' ', ind + s:Ind) . '........................................'
    endif

    if     c =~# '^\s*#\s*if'
      let ind += s:Ind
    elseif c =~# '^\s*#\s*elif'
    elseif c =~# '^\s*#\s*else'
    elseif c =~# '^\s*#\s*endif'
    else
      continue
    endif
    echo repeat(' ', ind) . c

    if     c =~# '^\s*#\s*endif'
      " 見やすいように、endifの後には空行を出力。
      echo "\n"
      let ind -= s:Ind
    endif
  endfor
endfunction

com! IfStruct call IfStruct()


com! IfS call s:cmd_out_capture()

function! s:cmd_out_capture()
  new
  silent put =execute('IfStruct')
  1,2delete _
endfunction


function! s:CommnadOutput()
  redir => result
  silent execute 'IfStruct'
  redir END
  return result
endfunction

" let @*=execute('IfStruct')



"---------------------------------------------------------------------------------------------

nnoremap <Leader><C-p> :<C-u>call <SID>next_nonamebuf(-1)<CR>
nnoremap <Leader><C-n> :<C-u>call <SID>next_nonamebuf(+1)<CR>

function! s:next_nonamebuf(n)
  let first_buf = 1
  let cur_buf = bufnr()
  let last_buf = bufnr('$')

  if a:n > 0
    let sta1 = cur_buf + 1
    let end1 = last_buf

    let sta2 = first_buf
    let end2 = cur_buf - 1

    let dis = +1
  else
    let sta1 = cur_buf - 1
    let end1 = first_buf

    let sta2 = last_buf
    let end2 = cur_buf + 1

    let dis = -1
  endif

  if !s:next_nonamebuf_sub(sta1, end1, dis)
    call s:next_nonamebuf_sub(sta2, end2, dis)
  endif
endfunction

function! s:next_nonamebuf_sub(sta, end, dis )
  "echo  a:sta a:end a:dis
  for i in range(a:sta, a:end, a:dis)
    "echo i bufname(i)
    if buflisted(i) && bufname(i) == '' " && buf modified
      exe 'b' i
      return v:true
    endif
  endfor
  return v:false
endfunction



"---------------------------------------------------------------------------------------------

com! KakkoZen s/(/（/g |  s/)/）/g


"---------------------------------------------------------------------------------------------

com! NoWrap PushPosAll | exe 'windo set nowrap' | PopPosAll




"---------------------------------------------------------------------------------------------

com! MacroStart normal! qq
com! MacroEnd   normal! q


