scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0:
" (この行に関しては:help modelineを参照)


set runtimepath^=~/vim/runtime
let $VIM = '~/vim/runtime'

let mapleader = ' '


if !isdirectory($HOME . "/vim_buckup")
  call mkdir($HOME . "/vim_buckup")
endif

if !isdirectory($HOME . "/vim_swap")
  call mkdir($HOME . "/vim_swap")
endif


"let OSTYPE = system('uname')
"if OSTYPE == "Darwin\n" 
"  :set term=xterm-256color 
"  :syntax on 
"endif 


set nocompatible
set autochdir
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
set backupdir=$HOME/vim_buckup
set directory=$HOME/vim_swap
set clipboard=unnamed
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
set encoding=utf-8
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
set formatoptions-=o
set gp=grep\ -n
set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,a:blinkon0
set hidden
if !&hlsearch
  " ReVimrcする度にハイライトされるのを避ける。
  set hlsearch
endif
set history=10000
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
set tagcase=match
set incsearch
set mps+=<:>
set nowrapscan
set nostartofline

set number
set norelativenumber
set numberwidth=3

" 常にステータス行を表示
set laststatus=2
set list
"trail:末尾のスペース, eol:改行, extends:, precedes:, nbsp:
set listchars=tab:>_,trail:$,extends:>,precedes:< | ",eol:,extends:,precedes:,nbsp:
" タイトルを表示
set title
set shiftwidth=8
" コマンドをステータス行に表示
set showcmd
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
set matchtime=2
" オンのとき、ウィンドウを横分割すると新しいウィンドウはカレントウィンドウの下に開かれる。
set splitbelow
" オンのとき、ウィンドウを縦分割すると新しいウィンドウはカレントウィンドウの右に開かれる。
set splitright
"リロードするときにアンドゥのためにバッファ全体を保存する
set undoreload=-1
"実際に文字がないところにもカーソルを置けるようにする
set virtualedit=block
set wildmenu
set wildmode=longest:full,full
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set nowrapscan
set noundofile
set nrformats=bin,hex
set shiftround
set fileformats=unix,dos,mac
" for 1st empty buffer
set fileformat=unix
"set tag+=;
set tags=./tags,./tags;
"grepコマンドの出力を取り込んで、gfするため。
set isfname-=:

"set viminfo+='100,c
set sessionoptions+=unix,slash
" set_end set end

set display+=lastline

set visualbell t_vb=

filetype on

syntax enable

colorscheme Rimpa
" TODO hi CursorLine ctermbg=NONE guibg=NONE

set mouse=
set mousehide

" from default
filetype plugin indent on


set timeoutlen=1100

augroup MyVimrc
  au!

  au QuickfixCmdPost make,grep,grepadd,vimgrep,cbuffer,cfile exe 'botright cwindow ' . &lines / 4
  au QuickfixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lcbuffer,lcfile lwindow
 "au BufNewFile,BufRead,FileType qf set modifiable

  " grepする際に'|cw'を付けなくても、Quickfixに結果を表示する
  "au QuickfixCmdPost vimgrep botright cwindow
  "au QuickfixCmdPost make,grep,grepadd,vimgrep 999wincmd w

 "au InsertEnter * set timeoutlen=3000
  au InsertEnter * set timeoutlen=700
  au InsertLeave * set timeoutlen=1100

  "au FileType c,cpp,awk set mps+=?::,=:;

 "au BufNewFile,BufRead,FileType *.awk so $vim/avd/avd.vim
  au BufNewFile,BufRead,FileType * set textwidth=0

augroup end


augroup MyVimrc_Init
  au!
  au VimEnter * clearjumps | au! MyVimrc_Init
augroup end



ru macros/PushposPopPos.vim
ru macros/EscEsc.vim
packadd vim-submode



" Basic {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


nnoremap Y y$


" US Keyboard {{{

noremap ; :

" ; を連続で押してしまったとき用。
cnoremap <expr> ; getcmdline() =~# '^:*$' ? ':' : ';'
cnoremap <expr> : getcmdline() =~# '^:*$' ? ';' : ':'

" US Keyboard }}}


nnoremap <silent> ZZ <Nop>
nnoremap <silent> ZQ <Nop>


nmap <silent> W <Plug>CamelCaseMotion_w
nmap <silent> B <Plug>CamelCaseMotion_b
if 0
  nnoremap E ge
  "nmap <silent> ge <Plug>CamelCaseMotion_e
  "nmap <silent> gE <Plug>CamelCaseMotion_ge
else
  nmap E  <Plug>CamelCaseMotion_e
  nmap gE <Plug>CamelCaseMotion_ge

  call submode#enter_with('ge', 'n', '', 'ge', 'ge')
  call submode#map(       'ge', 'n', '', 'e',  'ge')
  call submode#map(       'ge', 'n', '', 'E',  'e')
  call submode#enter_with('gE', 'n', 'r', 'gE', '<Plug>CamelCaseMotion_ge')
  call submode#map(       'gE', 'n', 'r', 'E',  '<Plug>CamelCaseMotion_ge')
  call submode#map(       'gE', 'n', 'r', 'e',  '<Plug>CamelCaseMotion_e')
endif


cnoremap <expr> <C-t> getcmdtype() == ':' ? '../' : '<C-t>'
cnoremap <expr> <C-^> getcmdtype() == ':' ? '../' : '<C-^>'


nnoremap g4 g$
nnoremap g6 g^

nnoremap ]3 ]#
nnoremap [3 [#

nnoremap ]8 ]*
nnoremap [8 [*


function! s:SwitchLineNumber()
  if !&l:number && !&l:relativenumber
    let &numberwidth = 3
    let &l:number = 1
  elseif &l:number && !&l:relativenumber
    let &numberwidth = 1
    let &l:relativenumber = 1
  else
    let &l:number = 0
    let &l:relativenumber = 0
  endif
endfunction

nnoremap <silent> <Leader>@ :<C-u>call <SID>SwitchLineNumber()<CR>
nmap <Leader>2 <Leader>@


" コメント行の後の新規行の自動コメント化のON/OFF
nnoremap <expr> <Leader>#&formatoptions =~# 'o' ?
      \ ':<C-u>set formatoptions-=o<CR>:set formatoptions-=r<CR>' :
      \ ':<C-u>set formatoptions+=o<CR>:set formatoptions+=r<CR>'
nmap <Leader>3 <Leader>#


vnoremap af ][<ESC>V[[
vnoremap if ][k<ESC>V[[j


nnoremap <silent> +  :echo '++ ' <Bar> exe 'setl isk+=' . GetKeyEcho()<CR>
nnoremap <silent> -  :echo '-- ' <Bar> exe 'setl isk-=' . GetKeyEcho()<CR>
nnoremap <silent> z+ :exe 'setl isk+=' . substitute(input('isk++ '), '.\($\)\@!', '&,', 'g')<CR>
nnoremap <silent> z- :exe 'setl isk-=' . substitute(input('isk-- '), '.\($\)\@!', '&,', 'g')<CR>
nnoremap <silent> z= :exe 'setl isk+=' . substitute(input('isk++ '), '.\($\)\@!', '&,', 'g')<CR>


" Basic }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Text_Objects {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

nnoremap cr ciw
nnoremap dr diw
nnoremap yr yiw

nnoremap cs caw
nnoremap ds daw
nnoremap ys yaw

"nnoremap cu ciw
"nnoremap du daw
"nnoremap yu yiw

" 括弧(Kakko)
onoremap ik i(
onoremap ak a(

" Double Quote
onoremap id i"
onoremap ad a"

" Text_Objects }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Cursor Move, CursorLine, CursorColumn, and Scroll {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


"----------------------------------------------------------------------------------------
" Vertical Move

"set noshowcmd

nnoremap j  gj
nnoremap k  gk

vnoremap j  gj
vnoremap k  gk


"----------------------------------------------------------------------------------------
" Horizontal Move

" ^に、|の機能を付加
nnoremap <silent> ^ <Esc>:exe v:prevcount ? ('normal! ' . v:prevcount . '<Bar>') : 'normal! ^'<CR>


"----------------------------------------------------------------------------------------
" Vertical Scroll

set sidescroll=1
set sidescrolloff=5

nnoremap <silent> <C-j> <C-d>
nnoremap <silent> <C-k> <C-u>

vnoremap <silent> <Space>   <C-d>
vnoremap <silent> <S-Space> <C-u>

let g:comfortable_motion_friction = 253.0
let g:comfortable_motion_air_drag = 45.0
let g:comfortable_motion_impulse_multiplier = 38.0
nnoremap <silent> <Plug>(ComfortableMotion-Flick-Down) :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * min([64, winheight(0)])     )<CR>
nnoremap <silent> <Plug>(ComfortableMotion-Flick-Up)   :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * min([64, winheight(0)]) * -1)<CR>

nmap gj <Plug>(ComfortableMotion-Flick-Down)
nmap gk <Plug>(ComfortableMotion-Flick-Up)

vnoremap gj <C-d>
vnoremap gk <C-u>


"----------------------------------------------------------------------------------------
" Horizontal Scroll

call submode#enter_with('HorizScroll', 'n', '', 'zl', 'zl')
call submode#enter_with('HorizScroll', 'n', '', 'zh', 'zh')
call submode#map(       'HorizScroll', 'n', '', 'l' , 'zl')
call submode#map(       'HorizScroll', 'n', '', 'h' , 'zh')

call submode#enter_with('HorizScroll', 'n', '', 'zj', '<c-e>')
call submode#enter_with('HorizScroll', 'n', '', 'zk', '<c-y>')
call submode#map(       'HorizScroll', 'n', '', 'j' , '<c-e>')
call submode#map(       'HorizScroll', 'n', '', 'k' , '<c-y>')

"sidescrolloffが1以上のとき、タブ文字(または多バイト文字)上にカーソルがあると、水平スクロールできないバグ(?)があるので、カーソルを動かせるようにしておく。
if 0
  call submode#map(       'HorizScroll', 'n', '', 'w' , 'w')
  call submode#map(       'HorizScroll', 'n', '', 'b' , 'w')
else
  set sidescrolloff=0
 "call submode#map(       'HorizScroll', 'n', '', 'l' , ':set virtualedit=all<CR>zl:set virtualedit=block<CR>')
 "call submode#map(       'HorizScroll', 'n', '', 'l' , ':set sidescrolloff=0<CR>zl:set sidescrolloff=5<CR>')
 "call submode#map(       'HorizScroll', 'n', '', 'h' , 'zh')
endif

"----------------------------------------------------------------------------------------
" Cursorline & Cursorcolumn

set cursorline
set cursorcolumn

augroup MyVimrc_Cursor
  au!
  au WinEnter,BufEnter * setl cursorline   " cursorcolumn
  au WinLeave          * setl nocursorline nocursorcolumn

  if 1
    au CursorHold  * setl nocursorcolumn
    au CursorMoved * setl cursorcolumn
  endif
augroup end

nnoremap <silent> <Leader>c :<C-u>setl cursorline!<CR>
nnoremap <silent> <leader>C :<C-u>setl cursorcolumn!<CR>


"----------------------------------------------------------------------------------------
" Scrolloff

function! s:best_scrolloff()
  " Quickfixでは、なぜかWinNewが発火しないので、exists()で変数の存在を確認せねばならない。
  let &l:scrolloff = (g:BrowsingScroll || (exists('w:BrowsingScroll') && w:BrowsingScroll)) ? 99999 : ( winheight(0) < 10 ? 0 : winheight(0) < 20 ? 2 : 5 )
endfunction

function! BestScrolloff()
  call s:best_scrolloff()
endfunction

let g:BrowsingScroll = v:false
nnoremap z<Space>  :<C-u> let g:BrowsingScroll = !g:BrowsingScroll
                  \ <Bar> exe g:BrowsingScroll ? 'normal! zz' : ''
                  \ <Bar> call <SID>best_scrolloff()
                  \ <Bar> echo g:BrowsingScroll ? 'Global BrowsingScroll' : 'Global NoBrowsingScroll'<CR>
nnoremap g<Space>  :<C-u> let w:BrowsingScroll = !w:BrowsingScroll
                  \ <Bar> exe w:BrowsingScroll ? 'normal! zz' : ''
                  \ <Bar> call <SID>best_scrolloff()
                  \ <Bar> echo w:BrowsingScroll ? 'Local BrowsingScroll' : 'Local NoBrowsingScroll'<CR>

augroup MyVimrc_ScrollOff
  au!
  au WinNew              * let w:BrowsingScroll = v:false
  au WinEnter,VimResized * call <SID>best_scrolloff()
  " -o, -Oオプション付きで起動したWindowでは、WinNew, WinEnterが発火しないので、別途設定。
  au VimEnter * call PushPos_All() | exe 'tabdo windo let w:BrowsingScroll = v:false | call <SID>best_scrolloff()' | call PopPos_All()
augroup end


" Cursor Move, CursorLine, CursorColumn, and Scroll }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Emacs {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" コマンドラインでのキーバインドを Emacs スタイルにする
" 行頭へ移動
cnoremap <C-a>		<Home>
" 一文字戻る
cnoremap <C-b>		<Left>
" カーソルの下の文字を削除
cnoremap <C-d>		<Del>
" 行末へ移動
cnoremap <C-e>		<End>
" 一文字進む
cnoremap <C-f>		<Right>
" コマンドライン履歴を一つ進む
cnoremap <C-n>		<Down>
" コマンドライン履歴を一つ戻る
cnoremap <C-p>		<Up>
" Emacs Yank
cnoremap <C-y> <C-R><C-O>*
" 次の単語へ移動
cnoremap <A-f>		<S-Right>
"cnoremap <Esc>f		<S-Right>
" 前の単語へ移動
cnoremap <A-b>		<S-Left>
" 単語削除
"cnoremap <A-d>		TODO
" Emacs }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" EscEsc {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

nmap <Esc><Esc> <Plug>(EscEsc)

if !exists('s:EscEsc_Add_Done')
  " おかしくなったときにEscEscで復帰できるように、念のためforceをTrueにして呼び出す。
  call EscEsc_Add('call RestoreDefaultStatusline(v:true)')
  call EscEsc_Add('call clever_f#reset()')
endif
let s:EscEsc_Add_Done = v:true

" EscEsc }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Search {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


"----------------------------------------------------------------------------------------
" Command Line Utility

" 検索時に/, ?を楽に入力する
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'


" 正規表現を楽に入力する
cnoremap (( \(
cnoremap )) \)
cnoremap << \<
cnoremap >> \>
cnoremap <Bar><Bar> \<Bar>

" 単語として囲む (\<, \>で囲む)
cnoremap <C-o> <C-\>e(getcmdtype() == '/' <Bar><Bar> getcmdtype() == '?') ? '\<' . getcmdline() . '\>' : getcmdline()<CR><Left><Left>


"----------------------------------------------------------------------------------------
" General Mapping

cmap <expr> <CR> ( getcmdtype() == '/' ) ?
               \ ( '<Plug>(Search-SlashCR)' ) :
               \ ( '<CR>' )

nmap n  <Plug>(Search-n)
nmap N  <Plug>(Search-N)


"----------------------------------------------------------------------------------------
" CWord

nmap  * <Plug>(SearchCWord-New-Word-Keep-Strict)
"nmap z* <Plug>(SearchCWord-New-Word-Keep-Option)
nmap z* <Plug>(SearchCWord-New-Word-Keep-Ignore)
nmap  # <Plug>(SearchCWord-New-Text-Keep-Strict)
nmap z# <Plug>(SearchCWord-New-Text-Keep-Option)
nmap  & <Plug>(SearchCWord-Add-Word-Keep-Option)
nmap z& <Plug>(SearchCWord-Add-Text-Keep-Option)

nmap g8 g*
nmap g7 g&
nmap g3 g#
nmap g2 g@

"nnoremap <Leader>& <Plug>(Search-TopUnderScore)
"nnoremap <Leader>@ <Plug>(MySearchT-ToggleMultiHighLight)

" clear status
"nmap <Esc><Esc> <Plug>(anzu-clear-search-status)


"----------------------------------------------------------------------------------------
" 補償

nnoremap g9 g8
nnoremap 8g9 8g8
nnoremap 9g9 8g8




"----------------------------------------------------------------------------------------
" 行検索

nnoremap <Leader>* ^y$:let lstmp = @"<CR>/\C\V<C-r>=escape(lstmp, '/\|\\')<CR><CR>
vnoremap <Leader>*   y:let lstmp = @"<CR>/\C\V<C-r>=escape(lstmp, '/\|\\')<CR><CR>
vnoremap         *   y:let lstmp = @"<CR>/\C\V<C-r>=escape(lstmp, '/\|\\')<CR><CR>


"----------------------------------------------------------------------------------------
" 検討

" 末尾が\|でないときだけ、\|を追加するようにしておかないと、\|の後でEscでキャンセルすると、\|が溜まっていってしまう。
"nnoremap ? /<C-p><C-\>e getcmdline() . ( match(getcmdline(), '\|$') == -1 ? '\\|' : '') <CR>
"nnoremap g/ /<C-p><C-r>=match(getcmdline(), '\|$') == -1 ? '\\|' : ''<CR>

"nnoremap <Leader>& <Plug>(Search-TopUnderScore)
"nnoremap <Leader>@ <Plug>(MySearchT-ToggleMultiHighLight)

"nmap     g8 :<C-u>setl isk-=_<CR>#:setl isk+=_<CR>
"nnoremap g8 :<C-u>setl isk-=_<CR>:setl isk+=_<CR>
"nnoremap g8 :<C-u>setl isk-=_<CR>:let @/=expand("<cword>")<CR>:set hlsearch<CR>:setl isk+=_<CR>
"nnoremap g8 :<C-u>setl isk-=_<CR>/<C-r><C-w><CR>:setl isk+=_<CR>


" Search }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Quickfix & Locationlist {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

let c_jk_local = 0

nnoremap <silent> <Plug>(MyVimrc-Toggle-Qf-Ll) :<C-u>let c_jk_local = !c_jk_local<CR>

"例外をキャッチしないと、最初と最後の要素の次に移動しようとして例外で落ちる。
nnoremap <silent> <Plug>(MyVimrc-CNext) :<C-u>try <Bar> exe (c_jk_local ? ":lnext" : "cnext") <Bar> catch <Bar> endtry<CR>:FuncNameStl<CR>
nnoremap <silent> <Plug>(MyVimrc-CPrev) :<C-u>try <Bar> exe (c_jk_local ? ":lprev" : "cprev") <Bar> catch <Bar> endtry<CR>:FuncNameStl<CR>

"例外をキャッチしないと、最初と最後の要素の次に移動しようとして例外で落ちる。
nnoremap <silent> <Plug>(MyVimrc-QfNext) :<C-u>try <Bar> cnext <Bar> catch <Bar> endtry<CR>:FuncNameStl<CR>
nnoremap <silent> <Plug>(MyVimrc-QfPrev) :<C-u>try <Bar> cprev <Bar> catch <Bar> endtry<CR>:FuncNameStl<CR>

"例外をキャッチしないと、最初と最後の要素の次に移動しようとして例外で落ちる。
nnoremap <silent> <Plug>(MyVimrc-LlNext) :<C-u>try <Bar> lnext <Bar> catch <Bar> endtry<CR>:FuncNameStl<CR>
nnoremap <silent> <Plug>(MyVimrc-LlPrev) :<C-u>try <Bar> lprev <Bar> catch <Bar> endtry<CR>:FuncNameStl<CR>

nmap <silent> <A-i> <Plug>(MyVimrc-QfNext)
nmap <silent> <A-o> <Plug>(MyVimrc-QfPrev)
nmap <silent> <A-n> <Plug>(MyVimrc-LlNext)
nmap <silent> <A-m> <Plug>(MyVimrc-LlPrev)

" Quickfix & Locationlist }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Tag, Jump, and Unified CR {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


" -----------------------------------------------------------------------------
" Unified_CR

" ------------------------------------------------------------
"   count付き実行されたら、count行へジャンプ。
"   qfならエラー元へジャンプ。
"   helpならリンクへジャンプ。
"   カーソルが数値上なら、基数変換。
"   それ以外なら、タグジャンプ。
"   失敗したら、マニュアルを引く。
"   失敗したら、Go File。
"   失敗したら、Go Define。
" ------------------------------------------------------------

" ------------------------------------------------------------
" 対象
"   カーソル下  ->  Normal mode デフォルト
"   Visual      ->  Visual mode デフォルト
"   (入力)      ->  対応なし

" タグ動作
"   直接ジャンプ -> なし
"   よきに計らう(タグの数次第で) -> デフォルトとする
"   強制選択

" ウィンドウ
"   そのまま
"   別ウィンドウ
"   プレビュー
" ------------------------------------------------------------

" TODO selectの扱い。   よきに計らう(タグの数次第で) -> デフォルトとする
" TODO 端末用に、もっと、モディファイア＋特殊キーを使わなくて良いようにする。

" ノーマル (最初の<Esc>がないと、prevcountをうまく処理できない。)
nnoremap <silent>         <CR>    <Esc>:call Unified_CR('')<CR>
" スプリット (端末では通常<S-CR>が使えないので、別のパターンを用意しておく。)
nmap                    <S-CR>    <Plug>(MyVimrc-Window-AutoSplit)<CR>
nmap                  <BS><CR>    <Plug>(MyVimrc-Window-AutoSplit)<CR>
nmap               <Space><CR>    <Plug>(MyVimrc-Window-AutoSplit)<CR>
" プレビュー
nnoremap <silent>       <C-CR>    :call Unified_CR('p')<CR>
" セレクト
nnoremap <silent>        g<CR>    :call Unified_CR('s')<CR>
" スプリットセレクト
nmap                   g<S-CR>    <Plug>(MyVimrc-Window-AutoSplit)g<CR>
" プレビューセレクト
nnoremap <silent>      g<C-CR>    <Esc>:call Unified_CR('sp')<CR>

" 引数のmodeは、次の文字をから構成される文字列。
"   s:select
"   p:preview
"   w:別ウィンドウ
function! Unified_CR(mode)

  " count付き実行されたら、count行へジャンプ。
  if v:prevcount
    "jumpする前に登録しないと、v:prevcountが上書されてしまう。
    call histadd('cmd', v:prevcount)
    "jumplistに残すために、Gを使用。
    exe 'normal!' v:prevcount . 'G'
    " TODO CFI
    return
  endif

  " qfならエラー元へジャンプ。
  if &buftype == 'quickfix'
    call feedkeys("\<CR>:FF2\<CR>", 'nt')
    return
  " helpならリンクへジャンプ。
  elseif &buftype == 'help'
    call feedkeys("\<C-]>", 'nt')
    return
  endif

  if 0
    " カーソルが数値上なら、基数変換。
    if EmIsNum()
      EmDispNoTimeOut
      " TODO Splitなら、別ウィンドウで表示。
      return
    endif
  endif

  let cword = expand('<cword>')

  " それ以外なら、タグジャンプ。
  if TagJump(cword, a:mode)
    return
  endif

  " TODO 暫定対応
  if &ft == 'vim' && isk !~ '#'
    set isk+=#
    let cword2 = expand('<cword>')
    let res = TagJump(cword2, a:mode)
    set isk-=#
    if res
      return
    endif
  endif

  " 失敗したら、マニュアルを引く。
  if s:lookup_in_man(cword)
    return
  endif

  " 失敗したら、Go File。
  if s:go_file_curfile(a:mode)
    return
  endif

  " 失敗したら、Go Define。
  keeppatterns normal! gd

endfunction


" -----------------------------------------------------------------------------
" マニュアルを引く

function! s:lookup_in_man(word)
  if &ft == 'vim'
    try
      exe 'help ' . a:word
      call TemporaryHighlightWord(a:word, v:false)
      return v:true
    catch /E149/  " Sorry no help for ...
    endtry
  endif
  return v:false
endfunction


" -----------------------------------------------------------------------------
" Go File

" カーソル下のファイルにgf
"
" go fileに
"   成功したら、true、
"   失敗したら、fals、
" を返す。
"
" TODO Preview対応
"
function! s:go_file_curfile(mode)
  if search('\%#\f', 'bcn')
    try
      normal! gf
      call popup_create('    Go  File    ' , #{
            \ line: 'cursor+3',
            \ col: 'cursor',
            \ posinvert: v:true,
            \ wrap: v:false,
            \ zindex: 200,
            \ highlight: 'SLFileName',
            \ border: [1, 1, 1, 1],
            \ borderhighlight: ['QuickFixLine'],
            \ moved: 'any',
            \ time: 2000,
            \ })
      return v:true
    catch /E447/
    finally
    endtry
  endif
  return v:false
endfunction


" -----------------------------------------------------------------------------
" Jump (Browsing)

nmap <C-p>      <Plug>(BrowserJump-Back)
nmap <C-n>      <Plug>(BrowserJump-Foward)

nmap <BS><C-p>  <Plug>(MyVimrc-Window-AutoSplit)<Plug>(MyVimrc-WinCmd-p)<C-p>
nmap <BS><C-n>  <Plug>(MyVimrc-Window-AutoSplit)<Plug>(MyVimrc-WinCmd-p)<C-n>


" Tag, Jump, and Unified CR }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Buffer {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

if 0
  nnoremap K         :<C-u>ls <CR>:b<Space>
  nnoremap gK        :<C-u>ls!<CR>:b<Space>
  nnoremap <Leader>K :<C-u>ls <CR>:bdel<Space>
  nnoremap zK        :<C-u>ls <CR>:bdel<Space>
else
  nnoremap <C-k>         :<C-u>ls <CR>:b<Space>
  nnoremap g<C-k>        :<C-u>ls!<CR>:b<Space>
  nnoremap <Leader><C-k> :<C-u>ls <CR>:bdel<Space>
  nnoremap z<C-k>        :<C-u>ls <CR>:bdel<Space>
endif

nnoremap <silent> <A-n> :<C-u>bnext<CR>
nnoremap <silent> <A-p> :<C-u>bprev<CR>

nnoremap <Leader>z :<C-u>bdel
nnoremap <Leader>Z :<C-u>bdel!

" Buffer }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Tab {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

nnoremap <silent>  <C-t>  :<C-u>tabnew<CR>
nnoremap <silent> g<C-t>  :<C-u>tabnew<Space>
"nnoremap <silent> z<C-t>  :<C-u>tab split<CR>

nnoremap <C-f> gt
nnoremap <C-b> gT

nnoremap <silent> <A-f> :exe tabpagenr() == tabpagenr('$') ? 'tabmove 0' : 'tabmove +1'<CR>
nnoremap <silent> <A-b> :exe tabpagenr() == 1              ? 'tabmove $' : 'tabmove -1'<CR>

" Tab }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Tabline {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


"----------------------------------------------------------------------------------------
" Make TabLineStr

function! TabLineStr()
  " Tab Label
  let tab_labels = map(range(1, tabpagenr('$')), 's:make_tabpage_label(v:val)')
  let sep = '%#SLFileName# | '  " タブ間の区切り
  let tabpages = sep . join(tab_labels, sep) . sep . '%#TabLineFill#%T'

  " Left
  let left = ''
  let left .= '%#TabLineDate#  ' . strftime('%X') . '  '
  let left .= '%#SLFileName# ' . g:BatteryInfo . ' '
  let left .= '%#TabLineDate#  '

  " Right
  let right = ''
  let right .= "%#TabLineDate#  "
  let right .= "%#SLFileName# %{'[ '. substitute(&diffopt, ',', ', ', 'g') . ' ]'} "
  let right .= '%#TabLineDate#  ' . s:TablineStatus . '/' . (s:TablineStatusNum - 1)
  let right .= '%#TabLineDate#  '

  return left . '%##    %<' . tabpages . '%=  ' . right
endfunction


"----------------------------------------------------------------------------------------
" Make TabLabel

function! s:make_tabpage_label(n)
  " カレントタブページかどうかでハイライトを切り替える
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  if s:TablineStatus == 1 | return hi . ' [ ' . a:n . ' ] %#TabLineFill#' | endif

  " タブ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:n)

  " タブ内に変更ありのバッファがあったら '+' を付ける
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? ' +' : ''

  if s:TablineStatus == 2 | return hi . ' [ ' . a:n . ' ' . mod . ' ] %#TabLineFill#' | endif

  " バッファ数
  let num = '(' . len(bufnrs) . ')'

  if s:TablineStatus == 3 | return hi . ' [ ' . a:n . ' ' . num . mod . ' ] %#TabLineFill#' | endif

  " タブ番号
  let no = '[' . a:n . ']'

  " カレントバッファ
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin

  let buf_name = ( s:TablineStatus =~ '[456]' ? expand('#' . curbufnr . ':t') : pathshorten(bufname(curbufnr)) )  " let buf_name = pathshorten(expand('#' . curbufnr . ':p'))

  let buf_name = buf_name == '' ? 'No Name' : buf_name  " 無名バッファは、バッファ名が出ない。

  let label = no . (s:TablineStatus != 4 ? (' ' . num) : '') . (s:TablineStatus =~ '[68]' ? mod : '') . ' '  . buf_name

  return '%' . a:n . 'T' . hi . '  ' . label . '%T  %#TabLineFill#'
endfunction


"----------------------------------------------------------------------------------------
" TabLine Timer

function! UpdateTabline(dummy)
  redrawtabline
endfunction

" 旧タイマの削除  vimrcを再読み込みする際、古いタイマを削除しないと、どんどん貯まっていってしまう。
if exists('TimerTabline') | call timer_stop(TimerTabline) | endif

let s:UpdateTablineInterval = 1000
let TimerTabline = timer_start(s:UpdateTablineInterval, 'UpdateTabline', {'repeat': -1})


"----------------------------------------------------------------------------------------
" Switch TabLine Status

function! s:ToggleTabline(arg)
  if (a:arg . '') == ''
    let s:TablineStatus = ( s:TablineStatus + 1 ) % s:TablineStatusNum
  elseif a:arg < s:TablineStatusNum
    let s:TablineStatus = a:arg
  else
    echoerr 'Tabline:Invalid argument.'
    return
  endif

  let &showtabline = ( s:TablineStatus == 0 ? 0 : 2 )

  call UpdateTabline(0)
endfunction

nnoremap <silent> <leader>= :<C-u>call <SID>ToggleTabline('')<CR>
com! -nargs=1 Tabline call <SID>ToggleTabline(<args>)


"----------------------------------------------------------------------------------------
" Initial Setting

let s:TablineStatusNum = 9
" 0
" 1  タブ番号
" 2  タブ番号            Mod
" 3  タブ番号 バッファ数 Mod
" 4  タブ番号                バッファ名
" 5  タブ番号 バッファ数     バッファ名
" 6  タブ番号 バッファ数 Mod バッファ名
" 7  タブ番号 バッファ数     フルバッファ名
" 8  タブ番号 バッファ数 Md  フルバッファ名

" 初期設定
silent call <SID>ToggleTabline(4)

set tabline=%!TabLineStr()

" Tabline }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Unified_Space {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
"
nmap <expr> <Space>   winnr('$') == 1 ? '<Plug>(ComfortableMotion-Flick-Down)' : '<Plug>(Window-Focus-SkipTerm-Inc)'
nmap <expr> <S-Space> winnr('$') == 1 ? '<Plug>(ComfortableMotion-Flick-Up)'   : '<Plug>(Window-Focus-SkipTerm-Dec)'

" Unified_Space }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Mru {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

augroup MyVimrc_MRU
  au!
  au VimEnter,VimResized * let MRU_Window_Height = max([8, &lines / 3 ])
augroup end

nnoremap <Leader>o :<C-u>MRU<Space>
nnoremap <C-o> :<C-u>MRU<Space>

" Mru }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" i_Esc {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

let g:IEscPre = []
let g:IEscPost = []

function! IEscPre_Add(str)
  call add(g:IEscPre, a:str)
endfunction

function! IEscPost_Add(str)
  call add(g:IEscPost, a:str)
endfunction

com! IEscDisp echo g:IEscPre g:IEscPost

"function! I_Esc()
"  call IEscPre()
"  call feedkeys("\<Esc>", 'ntx')
"  "normal! <Esc>
"  call IEscPost()
"  return ''
"endfunction

function! IEscPre()
  let input = ''
  for i in g:IEscPre
    "echo i
    "exe i
    let input = input . funcref(i)()
  endfor
  "call feedkeys("k", 'ntx')
  return input
endfunction

function! IEscPost()
  for i in g:IEscPost
    "echo i
    exe i
  endfor
  return ''
endfunction

inoremap <expr> <plug>(I_Esc_Write) IEscPre() . "\<Esc>" . ':w<CR>'
"imap , <Plug>(I_Esc_Write)

"call IEscPre_Add('Semi')
"function! Semi()
"  return 'eStert'
"endfunction
"call IEscPost_Add('w')

" i_Esc }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Snippets {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" ru snipMate.vim
if exists('*TriggerSnippet')
  inoremap <silent> <Tab>   <C-R>=<SID>TriggerSnippet()<CR>
endif

" Snippets }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Configuration {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


let g:vimrc_path  = ( has('win32') || filereadable(expand('~/vimfiles/.vimrc')))  ? '~/vimfiles/.vimrc'  : '~/.vimrc'
let g:gvimrc_path = ( has('win32') || filereadable(expand('~/vimfiles/.gvimrc'))) ? '~/vimfiles/.gvimrc' : '~/.gvimrc'
let g:colors_dir = '~/vimfiles/colors/'


com! ReVimrc :exe 'so ' . g:vimrc_path


com! EVIMRC  :exe 'e      ' . g:vimrc_path
com! SVIMRC  :exe 'sp     ' . g:vimrc_path
com! TVIMRC  :exe 'tabnew ' . g:vimrc_path
com! VVIMRC  :exe 'vs     ' . g:vimrc_path
com! VIMRC   :exe IsEmptyBuf() ? ':EVIMRC' : <SID>WindowRatio() >= 0 ? 'VVIMRC' : 'SVIMRC'
com! Vimrc   :VIMRC

com! EGVIMRC :exe 'e      ' . g:gvimrc_path
com! SGVIMRC :exe 'sp     ' . g:gvimrc_path
com! TGVIMRC :exe 'tabnew ' . g:gvimrc_path
com! VGVIMRC :exe 'vs     ' . g:gvimrc_path
com! GVIMRC  :exe IsEmptyBuf() ? ':EGVIMRC' : <SID>WindowRatio() >= 0 ? 'VGVIMRC' : 'SGVIMRC'
com! Gvimrc  :Gvimrc

com! EEditColor :exe 'e      ' . g:colors_dir . g:colors_name . '.vim'
com! SEditColor :exe 'sp     ' . g:colors_dir . g:colors_name . '.vim'
com! TEditColor :exe 'tabnew ' . g:colors_dir . g:colors_name . '.vim'
com! VEditColor :exe 'vs     ' . g:colors_dir . g:colors_name . '.vim'
com! EditColor  :exe IsEmptyBuf() ? ':EEditColor' : <SID>WindowRatio() >= 0 ? 'VEditColor' : 'SEditColor'


let g:vimrc_buf_name  = '^' . g:vimrc_path
let g:gvimrc_buf_name = '^' . g:gvimrc_path

nnoremap <expr> <silent> <Leader>v
	\ ( len(win_findbuf(bufnr(g:vimrc_buf_name))) > 0 ) && ( win_id2win(reverse(win_findbuf(bufnr(g:vimrc_buf_name)))[0]) > 0 ) ?
	\  ( win_id2win(reverse(win_findbuf(bufnr(g:vimrc_buf_name)))[0]) . '<C-w><C-w>' ) : ':VIMRC<CR>'

nnoremap <expr> <silent> <Leader><C-v>
	\  ( len(win_findbuf(bufnr(g:gvimrc_buf_name))) > 0 ) && ( win_id2win(reverse(win_findbuf(bufnr(g:gvimrc_buf_name)))[0]) > 0 ) ?
	\  ( win_id2win(reverse(win_findbuf(bufnr(g:gvimrc_buf_name)))[0]) . '<C-w><C-w>' ) : ':GVIMRC<CR>'

nnoremap <expr> <silent> <Leader>V
	\ ( len(win_findbuf(bufnr(g:colors_dir . g:colors_name . '.vim$'))) > 0 ) && ( win_id2win(reverse(win_findbuf(bufnr(g:colors_dir . g:colors_name . '.vim$')))[0]) > 0 ) ?
	\  ( win_id2win(win_findbuf(bufnr(g:colors_dir . g:colors_name . '.vim$'))[0]) . '<C-w><C-w>' ) : ':EditColor<CR>'


" Configuration }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Swap Exists {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

let s:swap_select = v:false

augroup MyVimrc_SwapExists
  au!
  au SwapExists * if s:swap_select | let v:swapchoice = '' | else | let v:swapchoice = 'o' | endif
augroup END

function! s:swap_select()
  let s:swap_select = v:true
  edit %
  let s:swap_select = v:false
endfunction

com! SwapSelect call s:swap_select()

" Swap Exists }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Other Key-Maps {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

nnoremap <leader>w :<C-u>w<CR>
nnoremap <silent><expr> <Leader>r &l:readonly ? ':<C-u>setl noreadonly<CR>' : ':<C-u>setl readonly<CR>'
nnoremap <silent><expr> <Leader>R &l:modifiable ? ':<C-u>setl nomodifiable <BAR> setl readonly<CR>' : ':<C-u>setl modifiable<CR>'
nnoremap <leader>L :<C-u>echo len("<C-r><C-w>")<CR>
nnoremap <silent> yx :PushPos<CR>ggyG:PopPos<CR> | ":echo "All lines yanked."<CR>

"nnoremap <silent> <C-o> :<C-u>exe (g:alt_stl_time > 0 ? '' : 'normal! <C-l>')
"                      \ <Bar> let g:alt_stl_time = 12
nnoremap <silent> g<C-o> :<C-u>pwd
                      \ <Bar> echon '        ' &fileencoding '  ' &fileformat '  ' &filetype '    ' printf('L %d  C %d  %3.2f %%  TL %3d', line('.'), col('.'), line('.') * 100.0 / line('$'), line('$'))
                      \ <Bar> call SetAltStatusline('%#hl_buf_name_stl#  %F', 'g', 10000)<CR>


"nnoremap <C-Tab> <C-w>p
inoremap <C-f> <C-p>
inoremap <C-e>	<End>
"inoremap <CR> <C-]><C-G>u<CR>
inoremap <C-H> <C-G>u<C-H>

nnoremap <silent> gl :setl nowrap!<CR>
nnoremap <silent> <Leader><CR> :setl nowrap!<CR>

nnoremap gG G

nnoremap <silent> gf :<C-u>aboveleft sp<CR>gF

" Other Key-Maps }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Clever-f {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

let g:clever_f_smart_case = 1

let g:clever_f_use_migemo = 1

com! CleverfUseMigemoToggle let g:clever_f_use_migemo = !g:clever_f_use_migemo | echo g:clever_f_use_migemo ? 'clever-f Use Migemo' : 'clever-f No Migemo'

" fは必ず右方向に移動，Fは必ず左方向に移動する
"let g:clever_f_fix_key_direction = 1

" 任意の記号にマッチする文字を設定する
let g:clever_f_chars_match_any_signs = "\<BS>"

" 過去の入力の再利用
"let g:clever_f_repeat_last_char_inputs = ["\<CR>"]	" ["\<CR>", "\<Tab>"]

" タイムアウト
let g:clever_f_timeout_ms = 3000

augroup MyVimrc_cleverf
  au!
  au ColorScheme * hi My_cleverf_Cursor guifg=yellow guibg=black
  au ColorScheme * hi My_cleverf_Char   guifg=#cff412 guibg=black
  "au ColorScheme * hi My_cleverf_Cursor guifg=cyan guibg=black
  "au ColorScheme * hi My_cleverf_Char   guifg=yellow guibg=black
augroup end
let g:clever_f_mark_cursor_color = 'My_cleverf_Cursor'
let g:clever_f_mark_char_color   = 'My_cleverf_Char'
"let g:clever_f_mark_cursor = 1
"let g:clever_f_mark_char = 1

" Clever-f }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Vertical-f {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

com! -nargs=1 VerticalF let @m=<q-args> | call search('^\s*'. @m)
com! -nargs=1 VerticalFBack let @m=<q-args> | call search('^\s*'. @m, 'b')
nnoremap <C-g>j :VerticalF<Space>
nnoremap <C-g>k :VerticalFBack<Space>

" Vertical-f }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" NERDTree {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

let g:NERDTreeMapActivateNode = ''
let g:NERDTreeMapOpenInTab = 'o'
let NERDTreeShowHidden = 1

" NERDTree }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Transparency {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

if has('gui')
  let g:my_transparency = 229
  let g:my_transparency = 227
  let g:my_transparency = 235
  let g:my_transparency = float2nr((255 - g:my_transparency) * 100 / 255)
  augroup MyVimrc_GUI
    au!
    "au GUIEnter * simalt ~x
    "au GUIEnter * ScreenMode 4
    "au GUIEnter * ScreenMode 5
    exe 'au GUIEnter * set transparency=' . g:my_transparency
  augroup end
  nnoremap <silent> <S-PageUp>   :<C-u>ScreenMode 5<CR>
  nnoremap <silent> <S-PageDown> :<C-u>ScreenMode 4<CR>
  nnoremap <silent> <A-PageUp>   :<C-u>ScreenMode 5<CR>:Thinkpad<CR>
  nnoremap <silent> <A-PageDown> :<C-u>ScreenMode 4<CR>:Thinkpad<CR>


  nnoremap <silent><expr> <PageUp>   ':<C-u>se transparency=' .    ( &transparency + 1      ) . '<Bar> Transparency <CR>'
  nnoremap <silent><expr> <PageDown> ':<C-u>se transparency=' . max([&transparency - 1,   1]) . '<Bar> Transparency <CR>'   | " transparencyは、0以下を設定すると255になってしまう。

  nnoremap <silent>       <C-PageUp>   :exe 'se transparency=' . (&transparency == g:my_transparency ? 255 : g:my_transparency) <Bar> Transparency <CR>
  nnoremap <silent>       <C-PageDown> :exe 'se transparency=' . (&transparency == g:my_transparency ?  50 : g:my_transparency) <Bar> Transparency <CR>

  com! Transparency echo printf(' Transparency = %4.1f%%', &transparency * 100 / 255.0)

  exe 'set transparency=' . g:my_transparency
endif


" Transparency }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" FuncName {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


function! Func_Name_Stl(alt_stl_time)
  if 0
    let func_name = cfi#format('%s ()', '')
    if func_name != ''
      let stl = '   %m   %#hl_func_name_stl#   ' . func_name . '   %##'
      call SetAltStatusline(stl, 'l', a:alt_stl_time)
    else
      call RestoreDefaultStatusline(v:true)
    endif
  else
    let stl = '   %m   %#hl_func_name_stl#   ' . cfi#format('%s ()', '... ()') . '   %##'
  call SetAltStatusline(stl, 'l', a:alt_stl_time)
  endif
endfunction


com! FuncNameStl       call Func_Name_Stl(5000)
com! FuncNameEcho      echo cfi#format("%s ()", "... ()")
com! FuncNameEchoColor echohl hl_func_name_stl <Bar> echo cfi#format("%s", "... ()") <Bar> echohl None
com! FuncName          exe 'FuncNameStl' | exe 'FuncNameEcho'


nnoremap <silent> <Plug>(FuncName-Stl) :<C-u>FuncNameStl<CR>


" 関数名表示
nnoremap <silent> , :<C-u>FuncName<CR>


" Command Line での関数名挿入
cnoremap <C-r><C-f> <C-R>=cfi#format('%s', '')<CR>
cmap     <C-r>f <C-r><C-f>


" FuncName }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Util Functions {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


function! IsEmptyBuf()
  return bufname('')=='' && &buftype=='' && !&modified
endfunction


function! TitleCase(str)
  return toupper(a:str[0]) . a:str[1:]
endfunction


" 数値比較用の関数 lhs のほうが大きければ正数，小さければ負数，lhs と rhs が等しければ 0 を返す
function! CompNr(lhs, rhs)
    return a:lhs - a:rhs
endfunction


function! GetKey()
  return nr2char(getchar())
endfunction


function! GetKeyEcho()
  let k = nr2char(getchar())
  echon k
  return k
endfunction


function! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc
"例 iabbr <silent> if if ()<Left><C-R>=Eatchar('\s')<CR>


function! ProcTopUnderScore(word)
  if a:word[0] == '_'
    return '_\?' . a:word[1:]
  elseif a:word[0] =~ '\a'
    return '_\?' . a:word
  endif
  return a:word
endfunction


function! Factorial(n)
  python3 import math
  return pyxeval('math.factorial(' . a:n . ')')
endfunction


" 返り値
"   CursorがWordの上:       正整数
"   CursorがWordの上でない: 0
function! IsCursorOnWord()
  return search('\%#\k', 'cnz')
endfunction


" 返り値
"   CursorがWordの先頭:             -1
"   CursorがWordの上(先頭でなはい):  1
"   CursorがWordの上でない:          0
function! CursorWord()
  if search('\<\%#\k', 'cnz')
    return -1
  elseif search('\%#\k', 'cnz')
    return 1
  endif
  return 0
endfunction

function! CursorWord()
  return search('\<\%#\k', 'cnz') ? -1 : search('\%#\k', 'cnz') ? 1 : 0
endfunction

" TODO rename CursorWord() -> CursorOnWord()

" Util Funtions }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



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



set renderoptions=type:directx,scrlines:1



" {{{
hi HlWord	guifg=#4050cd	guibg=white
hi HlWord	guibg=#4050cd	guifg=white
hi HlWord	guibg=NONE	guifg=NONE
hi HlWord	gui=reverse
hi HlWord	gui=NONE
hi HlWord	guibg=gray30	guifg=gray80
nnoremap <silent> <leader>` :<C-u>match HlWord /\<<C-r><C-w>\>/<CR>
"call EscEsc_Add('PushPosAll')
"call EscEsc_Add('windo match')
"call EscEsc_Add('PopPosAll')
augroup MyHiLight
  au!
  au WinLeave * match
augroup end
" `}}}



nnoremap <Leader>j       :<C-u>let &iminsert = (&iminsert ? 0 : 2) <Bar> exe "colorscheme " . (&iminsert ? "Asche" : "Rimpa") <CR>



" Refactoring  {{{

" 関数内のシンボルだけを置換
function!  RefactorLocalSymbol()
  let srch = @/
  let word = expand('<cword>')

  call PushPos()

  " 2jは、関数の先頭に居た時用
  " 2kは、関数定義行を含むため
  " いずれも暫定
  keepjumps normal! 2j[[2k
  let fl = line('.')
  keepjumps normal! ][
  let ll = line('.')

  let c_l = fl . ',' . ll
  "echo c_l

  let c_c = 's/' . srch . '/' . word . '/g'
  "echo c_c

  let c_u = c_l . c_c
  "echo c_u
  exe c_u

  call PopPos()
endfunction

"nnorema <silent> <Leader>d :<C-u>PushPos<CR>:g$.$s    /<C-r>//<C-r><C-w>/g<CR>:PopPos<CR>:let @/='<C-r><C-w>'<CR>
nnoremap <silent> <Leader>d :<C-u>call RefactorLocalSymbol()<CR>
nnorema <silent> <Leader>D :<C-u>PushPos<CR>:g$.$s    /<C-r>//<C-r><C-w>/g<CR>:PopPos<CR>:let @/='<C-r><C-w>'<CR>

" Refactoring  }}}



nnoremap <C-@> g-
nnoremap <C-^> g+



nnoremap <silent> <C-]> g;:FuncNameStl<CR>
nnoremap <silent> <C-\> g,:FuncNameStl<CR>



function! ZZ()
  let n = 25
  for i in range(n)
    execute "normal! " . g:comfortable_motion_scroll_down_key
    redraw
  endfor
endfunction



let plugin_dicwin_disable = v:true



ru! ftplugin/man.vim



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



nnoremap <Leader>$ :<C-u>setl scrollbind!<CR>
nmap <Leader>4 <Leader>$



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



"nnoremap  ]]  ]]f(bzt
"nnoremap g]]  ]]f(b
"nnoremap  [[  [[f(bzt
"nnoremap g[[  [[f(b
"nnoremap  ][  ][zb
"nnoremap g][  ][
"nnoremap  []  []zb
"nnoremap g[]  []




" TODO 
" BrowserJump  Orgへのジャンプもキーバインドを提供する



"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if 0
  nnoremap <C-i> g;
  nnoremap <C-o> g,

  nmap ' \

  set whichwrap+=hl
endif
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



" Basic {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Cursor Move, CursorLine, CursorColumn, and Scroll {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Emacs {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" EscEsc {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Search {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Substitute {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Grep {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Quickfix & Locationlist {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Tag, Jump, and Unified CR {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Diff {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Buffer {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Tab {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Tabline {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Battery {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Unified_Space {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Mru {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" i_Esc {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Snippets {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Configuration {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Swap Exists {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Other Key-Maps {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Clever-f {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Transparency {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" FuncName {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Util {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Basic {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{




" Cursor Move, CursorLine, CursorColumn, and Scroll {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Tag, Jump, and Unified CR {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Unified_Space {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Tabline {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Battery {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Buffer {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Tab {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Search {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Grep {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Quickfix & Locationlist {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Substitute {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Diff {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Snippets {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" i_Esc {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" EscEsc {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Configuration {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Emacs {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Swap Exists {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Clever-f {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Mru {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Transparency {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" FuncName {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Other Key-Maps {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Util {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{



"nnoremap <silent> <C-o> o<Esc>
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



nnoremap go :<C-u>MRU<Space>
nnoremap gO :<C-u>MRU<CR>
nnoremap gw :<C-u>w<CR>
nmap gr <Leader>e
nmap gt <Plug>(PrjTree-MyExplore)



let g:submode_timeoutlen = 5000



" {{{

let s:IsSpaceFree = v:false

if s:IsSpaceFree

  nnoremap <Space>w :<C-u>w<CR>
  nnoremap <Space>o :<C-u>MRU<Space>

  nmap <Space>v <Leader>v
  nmap <Space>V <Leader>V

  nmap <Leader>e <Nop>
  nmap <silent> <Space>e <Leader>e

  nmap <Space>- <Leader>-
  nmap <Space>_ <Leader>_

  nmap <Space>t <Leader>t

  nmap <Space><Space> <Leader><Space>

endif

" }}}






" Line
" 	1080
" 	90
" 
" 	768
" 	64
" 
" Col
" 	1920
" 	320
" 
" 	1024
" 	170.666667
" 
" set lines=64 columns0171
com! XGA set lines=64 columns=171

" Thinkpad
com! Thinkpad set lines=75 columns=267 | winpos 150 110


if has('mac')
  augroup IME_Mac
    autocmd!
    autocmd InsertLeave * :call job_start(
	  \ ['osascript', '-e', 'tell application "System Events" to key code {102}'],
	  \ {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
    autocmd VimEnter * :call job_start(
	  \ ['osascript', '-e', 'tell application "System Events" to key code {102}'],
	  \ {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
    autocmd GuiEnter * set guioptions=
  augroup END



  function! Mac_ime_off()
    call job_start(
	  \ ['osascript', '-e', 'tell application "System Events" to key code {102}'],
	  \ {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
  endfunction
  call EscEsc_Add('call Mac_ime_off()')
endif


set termguicolors

nnoremap <C-j> J


nnoremap <C-g><C-g> :<C-u>vim "\<<C-r><C-w>\>" *.c *.h<CR>


nnoremap <D-o> <C-l>
