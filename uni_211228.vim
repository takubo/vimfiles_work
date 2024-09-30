set encoding=utf-8
scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0 expandtab:
" (この行に関しては:help modelineを参照)


if !isdirectory($HOME . "/vim_buckup")
  call mkdir($HOME . "/vim_buckup")
endif

if !isdirectory($HOME . "/vim_swap")
  call mkdir($HOME . "/vim_swap")
endif


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
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
set formatoptions-=o
"set gp=grep\ -n
set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,a:blinkon0
set hidden
if !&hlsearch
  " ReVimrcする度にハイライトされるのを避ける。
  set hlsearch
endif
" 最大値
set history=10000
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
set tagcase=followscs
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
set virtualedit=block,onemore
set virtualedit=onemore
set wildmenu
"set wildmode=longest:full,full
"set wildmode=longest,list:longest,full
set wildmode=longest,full
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set nowrapscan
set noundofile
set nrformats=bin,hex
set shiftround
set fileformats=unix,dos,mac
" for 1st empty buffer
setg fileformat=unix
"set tag+=;
set tags=./tags,./tags;
"grepコマンドの出力を取り込んで、gfするため。
set isfname-=:

"set viminfo+='100,c
set sessionoptions+=unix,slash
" set_end set end

set display+=lastline

set visualbell t_vb=

if 0
  set belloff=backspace,cursor,complete,copy,ctrlg,error,esc,ex,hangul,insertmode,lang,mess,showmatch,operator,register,shell,spell,wildmode
  set belloff-=shell
  set visualbell
else
 "set novisualbell
  set belloff=all
endif


filetype on

syntax enable

" 最後に置かないと、au ColorScheme が実行されないので、最後へ移動した。
"colorscheme Rimpa
" TODO hi CursorLine ctermbg=NONE guibg=NONE

set mouse=
set mouse=a
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

" 本ファイル内で使用するので、先にloadする必要あり。
packadd vim-submode



let g:UseHHKB = 1
"let g:UseHHKB = 0

" HHKB
let mapleader = ' '
" Leader(Space)の空打ちで、カーソルが一つ進むのが鬱陶しいので。
nnoremap <Leader> <Nop>



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
  noremap E ge
  map <silent> ge <Plug>CamelCaseMotion_e
  map <silent> gE <Plug>CamelCaseMotion_ge
elseif 1
  map E  <Plug>CamelCaseMotion_e
  map gE <Plug>CamelCaseMotion_ge
else
  map E  <Plug>CamelCaseMotion_e
  map gE <Plug>CamelCaseMotion_ge

  call submode#enter_with('ge', 'nvo', '', 'ge', 'ge')
  call submode#map(       'ge', 'nvo', '', 'e',  'ge')
  call submode#map(       'ge', 'nvo', '', 'E',  'e')
  call submode#enter_with('gE', 'nvo', 'r', 'gE', '<Plug>CamelCaseMotion_ge')
  call submode#map(       'gE', 'nvo', 'r', 'E',  '<Plug>CamelCaseMotion_ge')
  call submode#map(       'gE', 'nvo', 'r', 'e',  '<Plug>CamelCaseMotion_e')
endif


" 検索時に/, ?を楽に入力する
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'


" 正規表現のメタ文字を楽に入力する
cnoremap (( \(
cnoremap )) \)
cnoremap << \<
cnoremap >> \>
cnoremap <Bar><Bar> \<Bar>


cnoremap <C-o> <C-\>e(getcmdtype() == '/' <Bar><Bar> getcmdtype() == '?') ? '\<' . getcmdline() . '\>' : getcmdline()<CR><Left><Left>


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

nnoremap <silent> <Leader># :<C-u>call <SID>SwitchLineNumber()<CR>


" コメント行の後の新規行の自動コメント化のON/OFF
nnoremap <expr> <Leader>@
      \ &formatoptions =~# 'o' ?
      \ ':<C-u>set formatoptions-=o<CR>:set formatoptions-=r<CR>' :
      \ ':<C-u>set formatoptions+=o<CR>:set formatoptions+=r<CR>'


nmap <Leader>2 <Leader>@
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
"
onoremap i0 i)
onoremap i9 i(
onoremap a0 a)
onoremap a9 a(

" Double Quote
onoremap id i"
onoremap ad a"

" Text_Objects }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" " Cursor Move, CursorLine, CursorColumn, and Scroll {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


"----------------------------------------------------------------------------------------
" Vertical Move

"set noshowcmd

nnoremap j  gj
nnoremap k  gk

xnoremap j  gj
xnoremap k  gk


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
" HHKB
nmap <Leader>j <Plug>(ComfortableMotion-Flick-Down)
nmap <Leader>k <Plug>(ComfortableMotion-Flick-Up)

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
  au WinEnter,BufEnter * setl cursorline "cursorcolumn
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
nnoremap g<Space>  :<C-u> let g:BrowsingScroll = !g:BrowsingScroll
                  \ <Bar> exe g:BrowsingScroll ? 'normal! zz' : ''
                  \ <Bar> call <SID>best_scrolloff()
                  \ <Bar> echo g:BrowsingScroll ? 'Global BrowsingScroll' : 'Global NoBrowsingScroll'<CR>
nnoremap z<Space>  :<C-u> let w:BrowsingScroll = !w:BrowsingScroll
                  \ <Bar> exe w:BrowsingScroll ? 'normal! zz' : ''
                  \ <Bar> call <SID>best_scrolloff()
                  \ <Bar> echo w:BrowsingScroll ? 'Local BrowsingScroll' : 'Local NoBrowsingScroll'<CR>

augroup MyVimrc_ScrollOff
  au!
  au WinNew              * let w:BrowsingScroll = v:false
  au WinEnter,VimResized * call <SID>best_scrolloff()
  " -o, -Oオプション付きで起動したWindowでは、WinNew, WinEnterが発火しないので、別途設定。
  au VimEnter * PushPosAll | exe 'tabdo windo let w:BrowsingScroll = v:false | call <SID>best_scrolloff()' | PopPosAll
augroup end


" Cursor Move, CursorLine, CursorColumn, and Scroll }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Emacs {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" コマンドラインでのキーバインドを Emacs スタイルにする
" 行頭へ移動
noremap! <C-a>		<Home>
" 一文字戻る
noremap! <C-b>		<Left>
" カーソルの下の文字を削除
noremap! <C-d>		<Del>
" 行末へ移動
noremap! <C-e>		<End>
" 一文字進む
noremap! <C-f>		<Right>
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

"if !exists('s:EscEsc_Add_Done')

" おかしくなったときにEscEscで復帰できるように、念のためforceをTrueにして呼び出す。
call EscEsc_Add('call RestoreDefaultStatusline(v:true)')
call EscEsc_Add('call clever_f#reset()')

"endif
"let s:EscEsc_Add_Done = v:true

" EscEsc }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Search {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


"----------------------------------------------------------------------------------------
" General Mapping

cmap <expr> <CR> ( getcmdtype() == '/' ) ?
               \ ( '<Plug>(Search-SlashCR)' ) :
               \ ( '<CR>' )

nmap n  <Plug>(Search-n)
nmap N  <Plug>(Search-N)

" 末尾が\|でないときだけ、\|を追加するようにしておかないと、\|の後でEscでキャンセルすると、\|が溜まっていってしまう。
"nnoremap ? /<C-p><C-\>e getcmdline() . ( match(getcmdline(), '\|$') == -1 ? '\\|' : '') <CR>
nnoremap g/ /<C-p><C-r>=match(getcmdline(), '\|$') == -1 ? '\\|' : ''<CR>


"----------------------------------------------------------------------------------------
" CWord

nmap  * <Plug>(Search-CWord-New-Word-Keep-Strict)
nmap  U <Plug>(Search-CWord-New-Word-Keep-Strict)
"nmap z* <Plug>(Search-CWord-New-Word-Keep-Option)
nmap z* <Plug>(Search-CWord-New-Word-Keep-Ignore)
nmap  # <Plug>(Search-CWord-New-Part-Keep-Strict)
nmap z# <Plug>(Search-CWord-New-Part-Keep-Option)
nmap  & <Plug>(Search-CWord-Add-Word-Keep-Option)
nmap z& <Plug>(Search-CWord-Add-Part-Keep-Option)

nmap z8 z*
nmap z3 z#
nmap z7 z&


"----------------------------------------------------------------------------------------
" 補償

nnoremap g9 g8
nnoremap 8g9 8g8
nnoremap 9g9 8g8


"----------------------------------------------------------------------------------------
" シンボル名のPart

"nnoremap z* :<C-u>setl isk-=_ <Bar> let @/=expand("<cword>") <Bar> set hlsearch <Bar> setl isk+=_<CR>
"nnoremap z& :<C-u>setl isk-=_ <Bar> let @/.='\\|'.expand("<cword>") <Bar> set hlsearch <Bar> setl isk+=_<CR>

nmap g* "xyiv/\C<C-r>x<CR>
nmap g# "xyiv/<C-r>x<CR>
nmap g& "xyiv/<C-p>\\|<C-r>x<CR>

nmap g8 g*
nmap g3 g#
nmap g7 g&


"----------------------------------------------------------------------------------------
" 行検索

nnoremap <Leader>* ^y$:let lstmp = @"<CR>/\C\V<C-r>=escape(lstmp, '/\|\\')<CR><CR>
nnoremap <Leader>* ^y$/\C\V<C-r>=escape(@", '/\|\\')<CR><CR>
nmap     <Leader>8 <Leader>*

nnoremap <Leader>& 0y$/\C\V\_^<C-r>=escape(@", '/\|\\')<CR>\_$<CR>
nmap     <Leader>7 <Leader>&

vnoremap <Leader>* y:let lstmp = @"<CR>/\C\V<C-r>=escape(lstmp, '/\|\\')<CR><CR>
vnoremap         * y:let lstmp = @"<CR>/\C\V<C-r>=escape(lstmp, '/\|\\')<CR><CR>
vmap     <Leader>8 <Leader>*
"vnoremap         *   y:let lstmp = @"<CR>/\C\V<C-r>=escape(lstmp, '/\|\\')<CR><CR>
"vnoremap <Leader>#   y:let lstmp = @"<CR>/\C\V<C-r>=escape(lstmp, '/\|\\')<CR><CR>
"vnoremap         #   y:let lstmp = @"<CR>/\C\V<C-r>=escape(lstmp, '/\|\\')<CR><CR>


"----------------------------------------------------------------------------------------
" 検討

"nnoremap ? /<C-p>\<Bar>

"nnoremap <Leader>& <Plug>(Search-TopUnderScore)
"nnoremap <Leader>@ <Plug>(MySearchT-ToggleMultiHighLight)

" clear status
"nmap <Esc><Esc> <Plug>(anzu-clear-search-status)

"nmap g8 :<C-u>setl isk-=_<CR>#:setl isk+=_<CR>
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

nmap <silent> <Del> <Plug>(MyVimrc-QfNext)
nmap <silent> <Ins> <Plug>(MyVimrc-QfPrev)
"nmap <silent> <A-n> <Plug>(MyVimrc-LlNext)
"nmap <silent> <A-m> <Plug>(MyVimrc-LlPrev)

" Quickfix & Locationlist }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Tag, Jump, and Unified CR {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Browse
if 0
  "nnoremap H <C-o>
  "nnoremap L <C-i>

  "nmap H <Plug>(BrowserJump-Back)
  "nmap L <Plug>(BrowserJump-Foward)

  "nnoremap <silent> H :<C-u>pop<CR>
  "nnoremap <silent> L :<C-u>tag<CR>

  "nmap <BS>H  <Plug>(MyVimrc-WindowSplitAuto)<C-w>p<Plug>(BrowserJump-Back)
  "nmap <BS>L  <Plug>(MyVimrc-WindowSplitAuto)<C-w>p<Plug>(BrowserJump-Foward)

  "nmap <BS>H  <Plug>(MyVimrc-WindowSplitAuto)<Plug>(MyVimrc-WinCmd-p)<Plug>(BrowserJump-Back)
  "nmap <BS>L  <Plug>(MyVimrc-WindowSplitAuto)<Plug>(MyVimrc-WinCmd-p)<Plug>(BrowserJump-Foward)
else
  nmap <C-p>      <Plug>(BrowserJump-Back)
  nmap <C-n>      <Plug>(BrowserJump-Foward)

  nmap <BS><C-p>  <Plug>(MyVimrc-Window-AutoSplit)<Plug>(MyVimrc-WinCmd-p)<C-p>
  nmap <BS><C-n>  <Plug>(MyVimrc-Window-AutoSplit)<Plug>(MyVimrc-WinCmd-p)<C-n>
endif


" ---------------
" Unified CR
"   数字付きなら、行へジャンプ
"   qfなら当該行へジャンプ
"   helpなら当該行へジャンプ
"   それ以外なら、タグジャンプ
" ---------------
function! Unified_CR(mode)

  if v:prevcount
    "jumpする前に登録しないと、v:prevcountが上書されてしまう。
    call histadd('cmd', v:prevcount)
    "jumplistに残すために、Gを使用。
    exe 'normal!' v:prevcount . 'G'
    return
  endif

 "if &ft == 'qf'
  if &buftype == 'quickfix'
    "call feedkeys("\<CR>:FF2\<CR>", 'nt')
    call feedkeys("\<CR>", 'nt')
    return
 "elseif &ft == 'help'
  elseif &buftype == 'help'
    call feedkeys("\<C-]>", 'nt')
    return
  endif

  "if EmIsNum()
  "  EmDispNoTimeOut
  "  return
  "endif

  if JumpToDefine(a:mode) <= 0
    return
  endif

  if &ft == 'vim'
    try
      exe 'help ' . expand('<cword>')

      let g:TagMatch = matchadd('TagMatch', '\<' . expand("<cword>") . '\>')
      let g:TimerTagMatch = timer_start(s:TagHighlightTime, 'TagHighlightDelete')
      let g:TagMatchI[g:TimerTagMatch] = g:TagMatch
      augroup ZZZZ
        au!
        au WinLeave * call TagHighlightDelete(g:TimerTagMatch)
      augroup end
      return
    catch
      "keeppatterns normal! gd
    endtry
  endif
  "keeppatterns normal! gd

  if search('\%#\f', 'bcn')
    try
      normal! gf
      if v:version < 802
        echohl Search
        echo 'Go File' . repeat(' ', &columns - 40)
        echohl None
      elseif 1
        " Cursor 下
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
      else
        " Center
        call popup_create('                G o    F i l e                ' , #{
              \ line: 'cursor+2',
              \ col: 'cursor',
              \ pos: 'center',
              \ posinvert: v:true,
              \ wrap: v:false,
              \ zindex: 200,
              \ highlight: 'SLFileName',
              \ border: [1, 1, 1, 1],
              \ borderhighlight: ['QuickFixLine'],
              \ padding: [1, 1, 1, 1],
              \ moved: 'any',
              \ time: 2000,
              \ })
      endif
    catch /E447/
    finally
    endtry
    return
  endif

  keeppatterns normal! gd

endfunction


" ----------------------------------------------------------------------------------------------
" Tag Match

augroup MyVimrc_TagMatch
  au!
  au ColorScheme * hi TagMatch	guibg=#c0504d	guifg=white
augroup end

function! TagHighlightDelete(dummy)
  call timer_stop(a:dummy)

  "echo a:dummy
  "sleep 5
  "call matchdelete(g:TagMatch)
  call matchdelete(g:TagMatchI[a:dummy])
  call remove(g:TagMatchI, a:dummy . '')
  "echo g:TagMatchI

  if a:dummy == g:TimerTagMatch0
    au! ZZZZ0
    "ここでreturnしないと、この下のif文でg:TimerTagMatchが未定義エラーになる。
    return
  endif
  if a:dummy == g:TimerTagMatch
    au! ZZZZ
    return
  endif
endfunction

let g:TagMatchI = {}
let s:TagHighlightTime = 1500  " [ms]

" TODO
"   ラベルならf:b
"   変数なら、スクロールしない
"   引数のタグ
"   asmのタグ
function! JumpToDefine(mode)
  let w0 = expand("<cword>")

  if w0 !~ '\<\i\+\>'
    return -1
  endif

  let w = w0

  let g:TagMatch0 = matchadd('TagMatch', '\<'.w.'\>')
  let g:TimerTagMatch0 = timer_start(s:TagHighlightTime, 'TagHighlightDelete')
  let g:TagMatchI[g:TimerTagMatch0] = g:TagMatch0
  augroup ZZZZ0
    au!
    au WinLeave * call TagHighlightDelete(g:TimerTagMatch0)
  augroup end
  redraw

  for i in range(2)
    try
      if 1
        if a:mode =~? 's'
          exe (a:mode =~? 'p' ? 'p' : (a:mode =~? 'w' ? 's' : '')) . "tselect " . w
        else
          exe (a:mode =~? 'p' ? 'p' : (a:mode =~? 'w' ? 's' : '')) . "tjump " . w
        endif
      else
        if ! TTTT(w, a:mode)
          " TODO 無理やり例外を発生させる
          throw ':E426:'
        endif
      endif
      " 表示範囲を最適化
      exe "normal! z\<CR>" . (winheight(0)/4) . "\<C-y>"
      " カーソル位置を調整 (C専用)
      call PostTagJumpCursor_C()
      let g:TagMatch = matchadd('TagMatch', '\<'.w.'\>')
      let g:TimerTagMatch = timer_start(s:TagHighlightTime, 'TagHighlightDelete')
      let g:TagMatchI[g:TimerTagMatch] = g:TagMatch
      augroup ZZZZ
	au!
	au WinLeave * call TagHighlightDelete(g:TimerTagMatch)
      augroup end
      return 0
    catch /:E426:/
      if w0 =~ '^_'
	" 元の検索語は"_"始まり
	let w = substitute(w0, '^_', '', '')
      else
	" 元の検索語は"_"始まりでない
	let w = '_' . w0
      endif
      if i == 0
	" エラーメッセージ表示用にオリジナル単語でのエラー文字列を保存
      let exception = v:exception
      endif
    catch /:E433:/
      echohl ErrorMsg | echo matchstr(v:exception, 'E\d\+:.*') | echohl None
      return 1
    endtry
  endfor
  echohl ErrorMsg | echo matchstr(exception, 'E\d\+:.*') | echohl None
  return 1
endfunction

" カーソル位置を調整 (C専用)
function! PostTagJumpCursor_C()
  if search('\%##define\s\+\k\+(', 'bcn')
  "関数形式マクロ
    normal! ww
  elseif search('\%##define\s\+\k\+\s\+', 'bcn')
  "定数マクロ
    normal! ww
  elseif search('\%#.\+;', 'bcn')
  "変数
    normal! f;b
  else
    "関数
    normal! $F(b
  endif
endfunction

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

" mode
"   s:select
"   p:preview
"   w:別ウィンドウ
"
" 最初の<Esc>がないと、prevcountをうまく処理できない。
nnoremap <silent> <CR>         <Esc>:call Unified_CR('')<CR>
nnoremap <silent> g<CR>        <Esc>:call Unified_CR('p')<CR>
nnoremap <silent> <Leader><CR> <Esc>:call Unified_CR('w')<CR>
nnoremap <silent> <C-CR>       <Esc>:call Unified_CR('s')<CR>
nnoremap <silent> <S-CR>       <Esc>:call Unified_CR('sp')<CR>
nnoremap <silent> <C-S-CR>     <Esc>:call Unified_CR('sw')<CR>
nnoremap          <C-S-CR>     <Esc>:tags<CR>;pop

nmap <BS><CR>     <Plug>(MyVimrc-Window-AutoSplit)<CR>
nmap <S-CR>       <Plug>(MyVimrc-Window-AutoSplit)<CR>
nmap <Leader><CR> <Plug>(MyVimrc-Window-AutoSplit-Rev)<CR>

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

  if 0
    " CmdlineEnterイベントを起こすためには、feedkeysとする必要がある。
    function! KKK()
      call feedkeys(":ls \<CR>:b\<Space>", 'nt')
    endfunction
    nnoremap <C-k>         :<C-u>call KKK()<CR>
  endif
  nnoremap <C-k>         :<C-u>KKK<CR>:ls <CR>:b<Space>
 "nnoremap <expr> <C-k> ':<C-u>KKK<CR>' . (bufnr("$") < (&lines - 2) ? ':ls<CR>' : '') . ':b<Space>'
endif

if 0
  packadd EasyBuffer
 "nnoremap <silent>        <C-u>  :<C-u>EasyBufferToggle<CR>
 "nnoremap <silent> <expr> <C-u> ':<C-u>EasyBuffer' . ( <SID>WindowRatio() >=  0 ? 'Vertical' : 'Horizontal' ) . '<CR>'
  nnoremap <silent>        <C-u>  :<C-u>EasyBufferBotRight<CR>:OptimalWindowHeight<CR>
  nnoremap <C-k>         :<C-u>KKK<CR>:b<Space>
endif

nnoremap <silent> <A-n> :<C-u>bnext<CR>
nnoremap <silent> <A-i> :<C-u>bnext<CR> | " Temp TODO
nnoremap <silent> <A-p> :<C-u>bprev<CR>

nnoremap <Leader>z :<C-u>bdel
nnoremap <Leader>Z :<C-u>bdel!

" Buffer }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Tab {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


nnoremap <silent>  <C-t>  :<C-u>tabnew<CR>
nnoremap <silent>  <C-t>  :<C-u>tabnew<CR>:SetpathSilent<CR>
nnoremap          g<C-t>  :<C-u>tabnew<Space>
"nnoremap <silent> z<C-t>  :<C-u>tab split<CR>

nnoremap <C-f> gt
nnoremap <C-b> gT
nnoremap t gt
nnoremap T gT

nnoremap <silent> <A-f> :exe tabpagenr() == tabpagenr('$') ? 'tabmove 0' : 'tabmove +1'<CR>
nnoremap <silent> <A-b> :exe tabpagenr() == 1              ? 'tabmove $' : 'tabmove -1'<CR>

nnoremap <silent> gt :<C-u>tabs<CR>:tabnext<Space>


"----------------------------------------------------------------------------------------
" On tab close move to previouse tab

if !exists('g:PreviouseTab')
  let g:PreviouseTab = 1
endif

augroup MyVimrc_LastTab
  au!
  if 0
    " Leave , Closeイベント発生の順番がおかしいようなので、TmpとEnterが必要。
    au TabLeave  * let g:PreviouseTabTmp = tabpagenr()
    au TabEnter  * let g:PreviouseTab = g:PreviouseTabTmp
    au TabClosed * let g:PreviouseTab -= ( tabpagenr() < g:PreviouseTab ? 1 : 0 ) | exe 'tabn' g:PreviouseTab
  endif

  " ??? Leave , Closeイベント発生の順番がおかしいようなので、TmpとEnterが必要。
  au TabLeave  * let g:PreviouseTabTmp = tabpagenr()
  au TabEnter  * let g:PreviouseTab = g:PreviouseTabTmp
  au TabClosed * let g:PreviouseTab -= ( tabpagenr() < g:PreviouseTab ? 1 : 0 ) | let g:PreviouseTabTmp = g:PreviouseTab | exe 'tabn' g:PreviouseTab
augroup end

if 0
  " Leave , Closeイベント発生の順番がおかしい。

  augroup MyVimrc_Tab
    au!
  augroup end

  augroup MyVimrc_LastTab
    au!
    au TabLeave  * let g:PreviouseTab = tabpagenr()
    "au TabClosed * exe 'tabn' g:PreviouseTab
    au TabClosed * call LastTab()
  augroup end

  if !exists('g:PreviouseTab')
    let g:PreviouseTab = 1
  endif

  function! LastTab()
    echo 's' g:PreviouseTab tabpagenr()
    redraw
    sleep 2

    let g:PreviouseTab -= tabpagenr() < g:PreviouseTab ? 1 : 0

    echo 'e' g:PreviouseTab tabpagenr()
    redraw
    sleep 2

    call feedkeys(g:PreviouseTab . 'gt', 'nt' )
  endfunction

endif

" Tab }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Tabline {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


"----------------------------------------------------------------------------------------
" Battery (Battery.vimが存在しない場合に備えて。)
let g:BatteryInfo = '? ---% [--:--:--]'


"----------------------------------------------------------------------------------------
" Make TabLineStr

function! TabLineStr()
  " Tab Label
  let tab_labels = map(range(1, tabpagenr('$')), 's:make_tabpage_label(v:val)')
  let sep = '%#SLFileName# | '  " タブ間の区切り
  let tabpages = sep . join(tab_labels, sep) . sep . '%#TabLineFill#%T'

  " Left
  let left = ''
  if 0
    let left .= '%#TabLineDate#  ' . strftime('%Y/%m/%d (%a) %X') . '  '
  else
    let left .= '%#TabLineDate#  ' . strftime('%X') . ' '
  endif
  let left .= '%#SLFileName#  ' . g:BatteryInfo . '  '
  let left .= '%#TabLineDate#  '

  " Right
  let right = ''
  let right .= "%#TabLineDate#  "
 "let right .= "%#SLFileName# %{'[ '. substitute(&diffopt, ',', ', ', 'g') . ' ]'} "
  let right .= '%#TabLineDate#  ' . s:TablineStatus . '/' . (s:TablineStatusNum - 1)
  let right .= '%#TabLineDate#  '

  return left . '%##    %<' . tabpages . '%=  ' . right
endfunction
function! TabLineStr()
  " Tab Label
  let tab_labels = map(range(1, tabpagenr('$')), 's:make_tabpage_label(v:val)')
 "let sep = '%#SLFileName# | '  " タブ間の区切り
  let sep = '%#TabLineSep#| '  " タブ間の区切り
  let sep = '%#TabLineSep# | '  " タブ間の区切り
  let tabpages = sep . join(tab_labels, sep) . sep . '%#TabLineFill#%T'

  " Left
  let left = ''
  if 0
    let left .= '%#TabLineDate#  ' . strftime('%Y/%m/%d (%a) %X') . '  '
  else
   "let left .= '%#TabLineDate# 💮 %#SLFileName#  ' . strftime('%X') . '  %#TabLineDate#    '
    let left .= '%#TabLineDate# ' . (winnr('$') > g:WinFocusThresh ? '💎' : '🐎') . ' %#SLFileName#  ' . strftime('%X') . '  %#TabLineDate#    '
  endif
  let left .= '%#SLFileName# ' . g:BatteryInfo . '  '
  let left .= '%#TabLineDate#    '

  " Right
  let right = ''
  let right .= "%#TabLineDate#  "

  if 0
    let right .= "%#SLFileName# %{'[ '. substitute(&diffopt, ',', ', ', 'g') . ' ]'} "
  elseif 0
    let right .= "%#SLFileName# [ "
    let right .= "(&diffopt =~ '\<iwhite\>' ? '%#SLNoNameDir#' : '%#SLFileName#') " . "White"
    let right .= "(&diffopt =~ 'icase'  ? '%#SLNoNameDir#' : '%#SLFileName#') " . "Case"
    let right .= "%#SLFileName ] "
  else
    let right .= "%#SLFileName# [ "
    let right .= (&diffopt =~ '\<iwhite\>' ? "%#SLNoNameDir#" : "%#SLFileName#") . "White "
    let right .= (&diffopt =~ 'icase'  ? "%#SLNoNameDir#" : "%#SLFileName#") . "Case"
    let right .= "%#SLFileName# ] "
  endif

 "let right .= '%#TabLineDate#  ' . s:TablineStatus . '/' . (s:TablineStatusNum - 1)
  let right .= '%#TabLineDate# 💻 ' . s:TablineStatus . '/' . (s:TablineStatusNum - 1)
  let right .= '%#TabLineDate#  '

  return left . '%#TabLineFill#    %<' . tabpages . '%#TabLineFill#%=  ' . right
  "return left . '%#SLFileName#    %<' . tabpages . '%#SLFileName#%=  ' . right
  return left . '%##%<' . tabpages . '%=  ' . right
endfunction


"----------------------------------------------------------------------------------------
" Make TabLabel

function! s:make_tabpage_label(n)
  " カレントタブページかどうかでハイライトを切り替える
  "let hi = a:n is tabpagenr() ? '%#Directory#' : '%#TabLine#'
  "let hi = a:n is tabpagenr() ? '%#SLFileName#' : '%#TabLine#'
  "let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#VertSplit#'

  if s:TablineStatus == 1 | return hi . ' [ ' . a:n . ' ] %#TabLineFill#' | endif

  " タブ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:n)

  " タブ内に変更ありのバッファがあったら '+' を付ける
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? ' +' : ''

  " バッファ数
  let num = '(' . len(bufnrs) . ')'

  if s:TablineStatus == 2 | return hi . ' [ ' . a:n . ' ' . num . mod . ' ] %#TabLineFill#' | endif

  " タブ番号
  let no = '[' . a:n . ']'

  " カレントバッファ
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin
  let buf_name = ( s:TablineStatus =~ '[345]' ? expand('#' . curbufnr . ':t') : pathshorten(bufname(curbufnr)) )  " let buf_name = pathshorten(expand('#' . curbufnr . ':p'))
 "let buf_name = buf_name == '' ? 'No Name' : buf_name  " 無名バッファは、バッファ名が出ない。
 "let buf_name = buf_name == '' ? '-' : buf_name  " 無名バッファは、バッファ名が出ない。
  let buf_name = buf_name == '' ? ' ' : buf_name  " 無名バッファは、バッファ名が出ない。

  " 最終的なラベル
  let label = no . (s:TablineStatus != 3 ? (' ' . num) : '') . (s:TablineStatus =~ '[57]' ? mod : '') . ' '  . buf_name
  return '%' . a:n . 'T' . hi . '  ' . label . '%T  %#TabLineFill#'
endfunction


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
function! s:CompletionTabline(ArgLead, CmdLine, CusorPos)
  return range(0, s:TablineStatusNum)
endfunction
com! -nargs=? -complete=customlist,s:CompletionTabline Tabline call <SID>ToggleTabline(<args>)


"----------------------------------------------------------------------------------------
" TabLine Timer

function! UpdateTabline(dummy)
  redrawtabline
  return
  set tabline=%!TabLineStr()
endfunction

" 旧タイマの削除  vimrcを再読み込みする際、古いタイマを削除しないと、どんどん貯まっていってしまう。
if exists('TimerTabline') | call timer_stop(TimerTabline) | endif

let s:UpdateTablineInterval = 1000
let TimerTabline = timer_start(s:UpdateTablineInterval, 'UpdateTabline', {'repeat': -1})
"let TimerTabline = timer_start(s:UpdateTablineInterval, { dummy -> execute('redrawtabline') }, {'repeat': -1})


"----------------------------------------------------------------------------------------
" Initial Setting

" 0
" 1  タブ番号
" 2  タブ番号 バッファ数 Mod
" 3  タブ番号                バッファ名
" 4  タブ番号 バッファ数     バッファ名
" 5  タブ番号 バッファ数 Mod バッファ名
" 6  タブ番号 バッファ数     フルバッファ名
" 7  タブ番号 バッファ数 Mod フルバッファ名
let s:TablineStatusNum = 8

" 初期設定
" 最後に実施する必要あり。
"silent call <SID>ToggleTabline(3)


" Tabline }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Unified_Space {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
"
"nmap <expr> <Space>   winnr('$') == 1 ? '<Plug>(ComfortableMotion-Flick-Down)' : '<Plug>(Window-Focus-SkipTerm-Inc)'
"nmap <expr> <S-Space> winnr('$') == 1 ? '<Plug>(ComfortableMotion-Flick-Up)'   : '<Plug>(Window-Focus-SkipTerm-Dec)'

"nmap <Space>   <Plug>(ComfortableMotion-Flick-Down)
"nmap <S-Space> <Plug>(ComfortableMotion-Flick-Up)

" Unified_Space }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" MRU {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

augroup MyVimrc_MRU
  au!
 "au VimEnter,VimResized * let MRU_Window_Height = max([8, &lines / 3 ])
  au VimEnter,VimResized * let MRU_Window_Height = max([8, &lines / 2 ])
augroup end

nnoremap <Leader>o :<C-u>MRU<Space>

" MRU }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



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


let g:vimrc_path  = has('win32') ? '~/vimfiles/.vimrc' : '~/.vimrc'
let g:gvimrc_path = has('win32') ? '~/vimfiles/.gvimrc' : '~/.gvimrc'
let g:colors_dir = '~/vimfiles/colors/'


com! ReVimrc :exe 'so ' . g:vimrc_path
com! ReloadRc :exe 'so ' . g:vimrc_path


com! EVIMRC  :exe 'e      ' . g:vimrc_path
com! SVIMRC  :exe 'sp     ' . g:vimrc_path
com! TVIMRC  :exe 'tabnew ' . g:vimrc_path
com! VVIMRC  :exe 'vs     ' . g:vimrc_path
"com! VIMRC   :exe IsEmptyBuf() ? ':EVIMRC' : <SID>SplitDirection() >= 0 ? 'VVIMRC' : 'SVIMRC'
com! Vimrc   :VIMRC

com! EGVIMRC :exe 'e      ' . g:gvimrc_path
com! SGVIMRC :exe 'sp     ' . g:gvimrc_path
com! TGVIMRC :exe 'tabnew ' . g:gvimrc_path
com! VGVIMRC :exe 'vs     ' . g:gvimrc_path
com! GVIMRC  :exe IsEmptyBuf() ? ':EGVIMRC' : <SID>SplitDirection() >= 0 ? 'VGVIMRC' : 'SGVIMRC'
com! Gvimrc  :Gvimrc

com! EEditColor :exe 'e      ' . g:colors_dir . g:colors_name . '.vim'
com! SEditColor :exe 'sp     ' . g:colors_dir . g:colors_name . '.vim'
com! TEditColor :exe 'tabnew ' . g:colors_dir . g:colors_name . '.vim'
com! VEditColor :exe 'vs     ' . g:colors_dir . g:colors_name . '.vim'
com! EditColor  :exe IsEmptyBuf() ? ':EEditColor' : <SID>SplitDirection() >= 0 ? 'VEditColor' : 'SEditColor'


" let g:vimrc_buf_name  = '^' . g:vimrc_path
let g:gvimrc_buf_name = '^' . g:gvimrc_path

if 0
nnoremap <expr> <silent> <Leader>v
	\ ( len(win_findbuf(bufnr(g:vimrc_buf_name))) > 0 ) && ( win_id2win(reverse(win_findbuf(bufnr(g:vimrc_buf_name)))[0]) > 0 ) ?
	\  ( win_id2win(reverse(win_findbuf(bufnr(g:vimrc_buf_name)))[0]) . '<C-w><C-w>' ) : ':VIMRC<CR>'
else
  function! s:Vimrc()
    let win_id_list = bufnr(g:vimrc_buf_name)->win_findbuf()

    " 現在のタブページ内で開かれていれば
    for w in win_id_list
      if win_id2win(w) > 0
        "exe win_id2win(reverse(win_id_list)[0]) 'wincmd w'
        call win_gotoid(w)
        return
      endif
    endfor

    " 別のタブページで開かれていれば
    if 0
      for w in win_id_list
        if win_id2tabwin(w) > 0
          call win_gotoid(w)
          return
        endif
      endfor
    endif

    if IsEmptyBuf()
      EVIMRC
    elseif <SID>SplitDirection() >= 0
      VVIMRC
    else
      SVIMRC
    endif
  endfunction

  function! s:Vimrc(path)
    let buf_name  = '^' . a:path
    let win_id_list = bufnr(buf_name)->win_findbuf()

    " 現在のタブページ内で開かれていれば
    for w in win_id_list
      if win_id2win(w) > 0
        "exe win_id2win(reverse(win_id_list)[0]) 'wincmd w'
        call win_gotoid(w)
        return
      endif
    endfor

    " 別のタブページで開かれていれば
    if 0
      for w in win_id_list
        if win_id2tabwin(w) > 0
          call win_gotoid(w)
          return
        endif
      endfor
    endif

    if IsEmptyBuf()
      "EVIMRC
      exe 'e'  a:path
    elseif <SID>SplitDirection() >= 0
      "VVIMRC
      exe 'vs' a:path
    else
      "SVIMRC
      exe 'sp' a:path
    endif
  endfunction

  com! -bar VIMRC call <SID>Vimrc(g:vimrc_path)
  nnoremap <silent> <Leader>v :<C-u>VIMRC<CR>
endif

nnoremap <expr> <silent> <Leader><C-v>
	\  ( len(win_findbuf(bufnr(g:gvimrc_buf_name))) > 0 ) && ( win_id2win(reverse(win_findbuf(bufnr(g:gvimrc_buf_name)))[0]) > 0 ) ?
	\  ( win_id2win(reverse(win_findbuf(bufnr(g:gvimrc_buf_name)))[0]) . '<C-w><C-w>' ) : ':GVIMRC<CR>'

nnoremap <expr> <silent> <Leader>V
	\ ( len(win_findbuf(bufnr(g:colors_dir . g:colors_name . '.vim$'))) > 0 ) && ( win_id2win(reverse(win_findbuf(bufnr(g:colors_dir . g:colors_name . '.vim$')))[0]) > 0 ) ?
	\  ( win_id2win(win_findbuf(bufnr(g:colors_dir . g:colors_name . '.vim$'))[0]) . '<C-w><C-w>' ) : ':EditColor<CR>'


" Configuration }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Swap_Exists {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

let s:swap_select = v:false

augroup MyVimrc_SwapExists
  au!
  au SwapExists * if s:swap_select | let v:swapchoice = '' | else | let v:swapchoice = 'o' | endif
augroup END

" function! s:swap_select()
"   let s:swap_select = v:true
"   edit %
"   let s:swap_select = v:false
" endfunction
" 
" com! SwapSelect call s:swap_select()

com! SwapSelect let s:swap_select = v:true | edit % | let s:swap_select = v:false

" Swap_Exists }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Other Key-Maps {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

nnoremap <leader>w :<C-u>w<CR>
nnoremap <silent> <leader>w :<C-u>update<CR>
"nnoremap <silent> <expr> <leader>w ':<C-u>' . (bufname('')=='' ? 'write' : 'update') . '<CR>'
"nnoremap <silent> <Leader>e :update<CR>
nmap <silent> <Leader>e <Leader>w

nnoremap <silent> <expr> <Leader>r &l:readonly ? ':<C-u>setl noreadonly<CR>' : ':<C-u>setl readonly<CR>'
nnoremap <silent> <expr> <Leader>R &l:modifiable ? ':<C-u>setl nomodifiable <BAR> setl readonly<CR>' : ':<C-u>setl modifiable<CR>'
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

nnoremap <Plug>(Normal-gF) gF
nmap <silent> gf <Plug>(MyVimrc-Window-AutoSplit)<Plug>(Normal-gF)

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

" TODO !!! clever-fが重い !!!
let g:clever_f_mark_char = 0
"   とするか、
"let g:clever_f_use_migemo = 0
"   とするかすれば、重いのが解消される。

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
let g:NERDTreeShowHidden = 1

if 0

  " DOS環境で、set shellslash がONのとき、NERDTreeVCSが無限ループに陥る。
  nnoremap <silent> gt :<C-u>echo 'Open NERDTree...'<CR>
        \:<C-u>exe 'silent NERDTreeVCS <Bar> NERDTreeFind' expand('%:p')<CR>
        \:OptimalWindowWidth<CR>
        \:set shellslash<CR>
        \:nunmap <buffer> J<CR>
        \:nunmap <buffer> K<CR>
        \:nunmap <buffer> f<CR>
        \:nunmap <buffer> F<CR>
  "     \:nunmap <buffer> m<CR>
  "     \:normal! ^<CR>

  augroup MyVimrc_NERDTree
    au!
    au TabNew NERD_tree_* setl winfixwidth
  augroup end

  " NERDTreeは時間が掛かるので、遅延ロード。
  augroup MyVimrc_NERDTree_AutoLoad
    au!
    au CmdUndefined NERDTree* packadd nerdtree | au! MyVimrc_NERDTree_AutoLoad CmdUndefined NERDTree*
  augroup END

  augroup MyVimrc_NERDTree_AutoLoad2
    au!
    au BufReadPost * if &filetype == 'netrw' | packadd nerdtree | echo 'edit' | au! MyVimrc_NERDTree_AutoLoad2 BufReadPost * | endif | echo GGG
  augroup END

elseif 0

    " NERDTreeは時間が掛かるので、遅延ロード。
    nnoremap <silent> gt :<C-u>call <SID>load_NERDTree()<CR>

    function! s:load_NERDTree()
      packadd nerdtree

      augroup MyVimrc_NERDTree
        au!
        au TabNew NERD_tree_* setl winfixwidth
      augroup end

      nnoremap <silent> gt :<C-u>echo 'Open NERDTree...'<CR>
            \:set noshellslash<CR>
            \:<C-u>exe 'silent NERDTreeVCS <Bar> NERDTreeFind' expand('%:p')<CR>
            \:OptimalWindowWidth<CR>
            \:set shellslash<CR>
            \:nunmap <buffer> J<CR>
            \:nunmap <buffer> K<CR>
            \:nunmap <buffer> f<CR>
            \:nunmap <buffer> F<CR>
      "     \:nunmap <buffer> m<CR>
      "     \:normal! ^<CR>

      normal gt
    endfunction

endif

" NERDTree }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" GUI {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


"----------------------------------------------------------------------------------------
" Font Size

if has('win32')
  let g:FontName      = "MeiryoKe_Console"
  "let g:FontHeight   = 9.5
  "let g:FontWidth    = 4.5
  "let g:FontWidth    = 4.45
  let g:FontHeight    = 9.0
  let g:FontWidth     = 4.2
  let g:FontHeight    = 9.0
  let g:FontWidth     = 4.5
  let g:FontHeight    = 8.5
  let g:FontWidth     = 4.5
  let g:MinFontHeight = 2.0
  let g:MinFontWidth  = 1.0
  let g:FontHVRatio   = 0.5   " 縦横比

  " FullHD NotePC {{{
  let g:FontHeight = 11.5
  let g:FontWidth  = 6
  " FullHD NotePC }}}

  let g:FontName      = "BIZ_UDゴシック"
  let g:FontHeight    = 10.5
endif

function! ResizeFont(r)
  if a:r == 0
    " デフォルトサイズに戻す
    let g:CurFontHeight = g:FontHeight
    let g:CurFontWidth  = g:FontWidth
  else
    "let g:CurFontWidth += a:r * (g:CurFontWidth / g:CurFontHeight)
    let g:CurFontHeight += a:r
    let g:CurFontWidth  += a:r * g:FontHVRatio

    if g:CurFontHeight < g:MinFontHeight | let g:CurFontHeight = g:MinFontHeight | endif
    if g:CurFontWidth  < g:MinFontWidth  | let g:CurFontWidth  = g:MinFontWidth  | endif
    "let g:CurFontHeight = max([g:MinFontHeight, g:CurFontHeight])
    "let g:CurFontWidth  = max([g:MinFontWidth,  g:CurFontWidth ])
  endif

  "exe "set guifont=" . g:FontName . ":h" . printf("%.2f", g:CurFontHeight) . ":w" . printf("%.2f", g:CurFontWidth)
  exe "set guifont=" . g:FontName . ":h" . printf("%.2f", g:CurFontHeight)
endfunction

" mapping
"nnoremap <Home>   :<C-u>call ResizeFont(+0.5)<CR>:EchoGuiFont<CR>
"nnoremap <End>    :<C-u>call ResizeFont(-0.5)<CR>:EchoGuiFont<CR>
"nnoremap <C-Home> :<C-u>call ResizeFont(0)<CR>:EchoGuiFont<CR>
"nnoremap <C-End>  :<C-u>call ResizeFont(0)<CR>:EchoGuiFont<CR>
"nnoremap <S-End>  :<C-u>call ResizeFont(-99999)<CR>:EchoGuiFont<CR>

" mapping HHKB
nnoremap <A-q> :<C-u>call ResizeFont(+0.5)<CR>:EchoGuiFont<CR>
nnoremap <A-w> :<C-u>call ResizeFont(-0.5)<CR>:EchoGuiFont<CR>
nnoremap <A-e> :<C-u>call ResizeFont(0)<CR>:EchoGuiFont<CR>
nnoremap <A-r> :<C-u>call ResizeFont(-99999)<CR>:EchoGuiFont<CR>

nnoremap <A-a> :<C-u>call ResizeFont(+0.5)<CR>:EchoGuiFont<CR>
nnoremap <A-x> :<C-u>call ResizeFont(-0.5)<CR>:EchoGuiFont<CR>
nnoremap <A-0> :<C-u>call ResizeFont(0)<CR>:EchoGuiFont<CR>
nnoremap <A--> :<C-u>call ResizeFont(-99999)<CR>:EchoGuiFont<CR>

com! EchoGuiFont echo '' &guifont

" initialize
if !exists('g:font_init_done')
  let g:CurFontHeight = g:FontHeight
  let g:CurFontWidth  = g:FontWidth

  call ResizeFont(0)
endif
let g:font_init_done = v:true


"----------------------------------------------------------------------------------------
" Screen Size & Position

if g:UseHHKB
  nnoremap <silent> <A-h>   :exe 'winpos' getwinposx() - 7 ' ' getwinposy() - 0<CR>
  nnoremap <silent> <A-j>   :exe 'winpos' getwinposx() + 0 ' ' getwinposy() + 7<CR>
  nnoremap <silent> <A-k>   :exe 'winpos' getwinposx() - 0 ' ' getwinposy() - 7<CR>
  nnoremap <silent> <A-l>   :exe 'winpos' getwinposx() + 7 ' ' getwinposy() + 0<CR>
else
  nnoremap <silent> <Left>    :exe 'winpos' getwinposx() - 7 ' ' getwinposy() - 0<CR>
  nnoremap <silent> <Down>    :exe 'winpos' getwinposx() + 0 ' ' getwinposy() + 7<CR>
  nnoremap <silent> <Up>      :exe 'winpos' getwinposx() - 0 ' ' getwinposy() - 7<CR>
  nnoremap <silent> <Right>   :exe 'winpos' getwinposx() + 7 ' ' getwinposy() + 0<CR>
endif

nnoremap <silent> <S-Left>  :exe 'winpos' getwinposx() - 1 ' ' getwinposy() - 0<CR>
nnoremap <silent> <S-Down>  :exe 'winpos' getwinposx() + 0 ' ' getwinposy() + 1<CR>
nnoremap <silent> <S-Up>    :exe 'winpos' getwinposx() - 0 ' ' getwinposy() - 1<CR>
nnoremap <silent> <S-Right> :exe 'winpos' getwinposx() + 1 ' ' getwinposy() + 0<CR>

nnoremap <silent> <C-Left>  :let &columns -= 1<CR>
nnoremap <silent> <C-Down>  :let &lines   += 1<CR>
nnoremap <silent> <C-Up>    :let &lines   -= 1<CR>
nnoremap <silent> <C-Right> :let &columns += 1<CR>

nnoremap <silent> <A-Left>  :let &columns -= 1<CR>
nnoremap <silent> <A-Down>  :let &lines   += 1<CR>
nnoremap <silent> <A-Up>    :let &lines   -= 1<CR>
nnoremap <silent> <A-Right> :let &columns += 1<CR>

com! XGeometry echo 'Line:' &lines ' Column:' &columns ' X:' getwinposx() ' Y:' getwinposy()


"----------------------------------------------------------------------------------------
" Transparency

let g:my_transparency = 229
let g:my_transparency = 227
let g:my_transparency = 235

" nnoremap <silent><expr> <PageUp>   ':<C-u>se transparency=' .    ( &transparency + 1      ) . '<Bar> XTransparency <CR>'
" nnoremap <silent><expr> <PageDown> ':<C-u>se transparency=' . max([&transparency - 1,   1]) . '<Bar> XTransparency <CR>'   | " transparencyは、0以下を設定すると255になってしまう。

" nnoremap <silent>       <C-PageUp>   :exe 'se transparency=' . (&transparency == g:my_transparency ? 255 : g:my_transparency) <Bar> XTransparency <CR>
" nnoremap <silent>       <C-PageDown> :exe 'se transparency=' . (&transparency == g:my_transparency ?  50 : g:my_transparency) <Bar> XTransparency <CR>

if 1  " HHKB
  nnoremap <silent><expr> <F11> ':<C-u>se transparency=' . max([&transparency - 1,   1]) . '<Bar> XTransparency <CR>'   | " transparencyは、0以下を設定すると255になってしまう。
 "nnoremap <silent><expr> <A--> ':<C-u>se transparency=' . max([&transparency - 1,   1]) . '<Bar> XTransparency <CR>'   | " transparencyは、0以下を設定すると255になってしまう。
  nnoremap <silent><expr> <F12> ':<C-u>se transparency=' .    ( &transparency + 1      ) . '<Bar> XTransparency <CR>'
 "nnoremap <silent><expr> <A-=> ':<C-u>se transparency=' .    ( &transparency + 1      ) . '<Bar> XTransparency <CR>'

  nnoremap <silent>       <S-F11> :<C-u>exe 'se transparency=' . (&transparency == g:my_transparency ?  50 : g:my_transparency) <Bar> XTransparency <CR>
  nnoremap <silent>       <S-F12> :<C-u>exe 'se transparency=' . (&transparency == g:my_transparency ? 255 : g:my_transparency) <Bar> XTransparency <CR>
endif

"com! TransparencyEcho echo printf(' Transparency = %4.1f%%', &transparency * 100 / 255.0)
com! XTransparency    echo printf(' Transparency = %4.1f%%', &transparency * 100 / 255.0)

" exe 'set transparency=' . g:my_transparency


"----------------------------------------------------------------------------------------
" Screen (ScreenMode & Special)

" line
"	HD:  1080:90
"	XGA:  768:64
" col
"	HD:  1920:320
"	XGA: 1024:170.666667
com! XGA set lines=64 columns=171
" Thinkpad X1 Carbon Gen.1st (HD Size)
com! Thinkpad set lines=75 columns=267 | winpos 150 110
" FullHD Visible Window's Tastesbar
com! Think    set lines=75 columns=270 | winpos 0 5
com! Think    set lines=75 columns=275 | winpos 0 3
"com! ThinkWUXGA    set lines=91 columns=304 | winpos 0 0 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1
"com! WuxgaVert     set lines=136 columns=156 | winpos 0 0 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1
"com! ThinkWUXGA    set lines=91 columns=304 | winpos 0 0 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1

" 画面に収まらない場合、自動で縮むので、大きめの行列を指定すればよい。(WUGA縦横、FHDに対応。)
com! ThinkWUXGA    set lines=136 columns=304 | winpos 0 0 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1 | exe 'winpos' getwinposx() - 1

"com! MaxScreen     winpos 85 0 | set lines=136 columns=305
"com! MaxScreen     set lines=136 columns=305 | winpos 85 0
"com! MaxScreen     set lines=136 columns=305 | winpos 0 0
com! MaxScreen     set lines=136 columns=305 | winpos 85 0  " タスクバー左
com! MaxScreen     set lines=999 columns=999 | winpos 0  0  " タスクバー右

if has('kaoriya')
  " nnoremap <silent> <S-PageUp>   :<C-u>ScreenMode 5<CR>
  " nnoremap <silent> <S-PageDown> :<C-u>ScreenMode 4<CR>
  " nnoremap <silent> <A-PageUp>   :<C-u>ScreenMode 5<CR>:Thinkpad<CR>
  " nnoremap <silent> <A-PageDown> :<C-u>ScreenMode 4<CR>:Thinkpad<CR>
  " if 1  " HHKB
  "  "nnoremap <silent> <F5> :<C-u>ScreenMode 5<CR>
  "   nnoremap <silent> <F6> :<C-u>ScreenMode 4<CR>
  "   nnoremap <silent> <F7> :<C-u>ScreenMode 5<CR>:Thinkpad<CR>
  "   nnoremap <silent> <F8> :<C-u>ScreenMode 4<CR>:Thinkpad<CR>
  " endif

  "com! FullScreen ScreenMode 5
  nnoremap <silent> <F5> :<C-u>FullScreen<CR>

  "nnoremap <silent> <F6> :<C-u>ScreenMode 5<CR>:Think<CR>
  "nnoremap <silent> <F4> :<C-u>Think<CR>

  "nnoremap <silent> <F7> :<C-u>XGA<CR>
  "nnoremap <silent> <F6> :<C-u>ThinkWUXGA<CR>
  nnoremap <silent> <F6> :<C-u>MaxScreen<CR>

  "nnoremap <silent> <F7> :<C-u>WuxgaVert<CR>

  com! OriginalScreen ScreenMode 0
  nnoremap <silent> <F7> :<C-u>OriginalScreen<CR>

endif


"----------------------------------------------------------------------------------------
" Guioptions & Disable Menu

if 0
  let did_install_default_menus = 1
  " TODO $VIMRUNTIME/menu.vimを削除する。
else
  " menu.vim の読み込みを抑止
  " ReVimrc時のちらつき防止のため、+=で設定。
  " https://hail2u.net/blog/software/dont-load-menu-in-gvim.html

  "set guioptions+=M

  if has('kaoriya')
    set ambiwidth=auto
    set guioptions=!CM
  else
    set guioptions=!M
  endif
endif


"----------------------------------------------------------------------------------------
" Autocmd

augroup MyVimrc_GUI
  au!

  " Screen Size & Position
  if has('kaoriya')
   "au GUIEnter * ScreenMode 5
    au GUIEnter * FullScreen
  else
    au GUIEnter * simalt ~x
  endif

  " Transparency
  exe 'au GUIEnter * set transparency=' . g:my_transparency
augroup end


" GUI }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



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


function! ToCapital(str)
  return substitute(a:str, '.*', '\L\u&', '')
 "return toupper(a:str[0]) . a:str[1:]
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

" 返り値
"   CursorがWordの先頭:             -1
"   CursorがWordの上(先頭でなはい):  1
"   CursorがWordの上でない:          0
function! CursorWord()
  return search('\<\%#\k', 'cnz') ? -1 : search('\%#\k', 'cnz') ? 1 : 0
endfunction

" TODO rename CursorWord() -> CursorOnWord()

" Util Funtions }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



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



nnoremap <Leader>J       :<C-u>let &iminsert = (&iminsert ? 0 : 2) <Bar> exe "colorscheme " . (&iminsert ? "Asche" : "Rimpa.new") <CR>



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
"vnoremap J :Brace<CR>
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



" Basic {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Emacs {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Cursor Move, CursorLine, CursorColumn, and Scroll {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" EscEsc {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Tag, Jump, and Unified CR {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


" Search {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Substitute {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Grep {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Quickfix & Locationlist {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Diff {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Buffer {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Tab {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Tabline {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Battery {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Snippets {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" i_Esc {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Swap Exists {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" EscEsc {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Configuration {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Emacs {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


" MRU {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" FuncName {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" GUI {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Clever-f {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Other Key-Maps {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{



" Util {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{



"nnoremap <silent> <C-o> o<Esc>
"nnoremap <silent> <C-o> :<C-u>call append(expand('.'), '')<CR>j

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



nnoremap go :<C-u>MRU<Space>
nnoremap gO :<C-u>MRU<CR>

nnoremap <C-o>  :<C-u>MRU<Space>
nnoremap g<C-o> :<C-u>MRU<CR>

nnoremap gw :<C-u>w<CR>
"nmap gr <Leader>e



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

if 0
  "let mapleader = '\'
  nmap <Space>w <Leader>w
  nmap <Space>e <Leader>e
  nmap <Space>e <Leader>e
  nmap <Space>o <Leader>o
  nmap <Space>v <Leader>v
  nmap <Space>V <Leader>V
elseif 0  " HHKB
  nmap <Space>w \w
  nmap <Space>e \e
  nmap <Space>o \o
  nmap <Space>v \v
  nmap <Space>V \V
  nmap <Space>f \f
endif







" Undo Redo {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
call submode#map('undo/redo', 'n', '', '-', 'g-')
call submode#map('undo/redo', 'n', '', '+', 'g+')

" Undo Redo  }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



com! -nargs=1 -complete=custom,VimrcContents V VIMRC <Bar> silent 1 <Bar> call search(<q-args> . ' {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{', 'cW')
com! -nargs=1 -complete=custom,VimrcContents V VIMRC <Bar> silent 1 <Bar> call search(<q-args> . ' {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{', 'cW') <Bar> normal! z<CR>

" function! Grep()
"   let g:strs = ''
"   redir => g:strs
"   g/ {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{/p
"   redir END
" endfunction
" 
" function! Grep()
"   let g:strs = execute('vimgrep ' . '" {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{" %')
" endfunction

function! Grep()
  vimgrep ' {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{' %
endfunction

let s:vimrc_conts = [ 'Basic', 'Text_Objects', 'Visual_Mode', 'Cursor Move, CursorLine, CursorColumn, and Scroll', 'Emacs', 'EscEsc', 'Search', 'Substitute', 'Grep', 'Quickfix & Locationlist', 'Tag, Jump, and Unified CR', 'Diff', 'Window', 'Terminal', 'Buffer', 'Tab', 'Tabline', 'Statusline', 'Unified_Space', 'Mru', 'Completion', 'i_Esc', 'Snippets', 'Configuration', 'Swap Exists', 'Other Key-Maps', 'Clever-f', 'Vertical-f', 'NERDTree', 'EasyMotionn', 'Transparency', 'FuncName', 'Undo Redo', 'Util Functions', 'Util Commands', 'Basic', 'Cursor Move, CursorLine, CursorColumn, and Scroll', 'Emacs', 'EscEsc', 'Search', 'Substitute', 'Grep', 'Quickfix & Locationlist', 'Tag, Jump, and Unified CR', 'Diff', 'Window', 'Terminal', 'Buffer', 'Tab', 'Tabline', 'Statusline', 'Battery', 'Unified_Space', 'Mru', 'Completion', 'i_Esc', 'Snippets', 'Configuration', 'Swap Exists', 'Other Key-Maps', 'Clever-f', 'Transparency', 'FuncName', 'Util', 'Basic', 'Cursor Move, CursorLine, CursorColumn, and Scroll', 'Tag, Jump, and Unified CR', 'Unified_Space', 'Tabline', 'Statusline', 'Battery', 'Window', 'Terminal', 'Buffer', 'Tab', 'Search', 'Grep', 'Quickfix & Locationlist', 'Substitute', 'Diff', 'Completion', 'Snippets', 'i_Esc', 'EscEsc', 'Configuration', 'Emacs', 'Swap Exists', 'Clever-f', 'Mru', 'Transparency', 'FuncName', 'Other Key-Maps', 'Util', 'SetPath' ]

function! VimrcContents(ArgLead, CmdLine, CusorPos)
  return join(s:vimrc_conts,"\n")
endfunction




" TODO
" Diff Specialの判定では、NERDTreeのWindowを無視して、2個ならDiffするようにする。おなじくTerminalも。Quickfix, Locationlistも。

"
"■お気に入り
"
"Window
"
"CWord Search
"
"Completion
"
"Numbers (Em)
"
"
"■力を入れざるを得ないもの
"
"Scroll
"
"Tag Browsing
"
"
"■力を入れてしまったもの
"
"Diff
"
"Stl
"
"(Esc_Esc)
"


" 🐹
" 🌀
" 🐎
" 🐬
" 🐜
" 🐝
" 👉
" 💀
" 💉
" 💻
" 💮
" 📜
" 📓
" 💎
" 💿
" 📎
" 🔗
" 🔘
" 🔃



" word
" part
"
" strict
" smart
"
" add
" new
"
"
"
" word	new	strict
" word	new	smart
"
" word	add	strict
" word	add	smart
"
" part	new	strict
" part	new	smart
"
" part	add	strict
" part	add	smart
"
"
"
" word	new	strict	*
" word	new	smart	g#
"
" part	new	strict	#
" part	new	smart	g#
"
" word	add		&
" part	add		g&



" vn vg vw Gcommit gitcon


" so ~/vimfiles/new.vim







" match\(pattern\)\@=
" 
" \@=	幅ゼロの肯定先読み。先行するアトムに幅ゼロでマッチします。
" 	foo\(bar\)\@=		"foobar" の "foo"
" 
" 
" match\(pattern\)\@!
" 
" \@!	幅ゼロの否定先読み。先行するアトムが現在の位置でマッチしない場合に、幅ゼロでマッチします。
" 	foo\(bar\)\@!		後ろに "bar" のない "foo"
" 
" 
" \(pattern\)\@<=match
" 
" \@<=	幅ゼロの肯定後読み。先行するアトムが、この後に続くパターンの直前にマッチする場合に、幅ゼロでマッチします。
" 	\(an\_s\+\)\@<=file	"an" と空白文字 (改行含む) の後の "file"
" 
" 
" \(pattern\)\@<!match
" 
" \@<!	幅ゼロの否定後読み。先行するアトムが、この後に続くパターンの直前にマッチしない場合に、幅ゼロでマッチします。
" 	\(foo\)\@<!bar		"foobar" 以外の "bar"
"



"cmap <C-j> <Tab>
"cmap <C-k> <S-Tab>
"set wildchar=<C-j>




"nnoremap L gt
"nnoremap H gT

cnoremap <C-l> <C-d>
cnoremap <C-j> <C-d>
" cunmap <C-d>
cnoremap <C-j> <C-d>
cnoremap <C-k> <S-Tab>


let g:ctrlp_map = '<C-j>'

highlight link MRUFileName Identifier
highlight link MRUFileName Statement
highlight link MRUFileName MyMru
highlight link MRUFileName DirectoryMyMru
highlight link MRUFileName String



"================================================================================



" MakeTags {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" ( ctags -aR && \awk '{ print $1 }' tags > tag_only ) &
" ( git rev-parse --show-toplevel; ctags -aR && \awk '{ print $1 }' tags > tag_only ) &
" ( cd `git rev-parse --show-toplevel` && ctags -Rf tags_tmp && mv tags_tmp tags && \awk '{ print $1 }' tags > tag_only ) &

" let job = job_start('sh -c "cd `git rev-parse --show-toplevel` && ctags -Rf tags_tmp && mv tags_tmp tags && awk ' . "'{ print $1 }'" . ' tags > tag_only"')
" echo job_status(job)

com! MakeTags let mk_tag_job = job_start('sh -c "cd `git rev-parse --show-toplevel` && ctags -Rf tags_tmp && mv tags_tmp tags && awk ' . "'{ print $1 }'" . ' tags > tag_only"')

com! MakeTags call MakeTags()

augroup MyVimrc_AutCtags
  au!
  au BufWritePost *.c,*.h MakeTags
augroup end

let s:mk_tag_exe = 0
function! MakeTags()
  if s:mk_tag_exe
    if job_status(s:mk_tag_job) == 'run'
      return
    endif
  endif
  if 0  " UTF-8
    let s:mk_tag_job = job_start('sh -c "cd `git rev-parse --show-toplevel && git rev-parse --show-toplevel` && ctags -Rf tags_tmp && mv tags_tmp tags && awk ' . "'{ print $1 }'" . ' tags > tag_only"')
  elseif 0  " cp932 失敗
    "let s:mk_tag_job = job_start('sh -c "cd `git rev-parse --show-toplevel && git rev-parse --show-toplevel` && echo "!_TAG_FILE_ENCODING	CP932" > tags_tmp && ctags -Raf tags_tmp && mv tags_tmp tags && awk ' . "'{ print $1 }'" . ' tags > tag_only"')
  else  " cp932
    let s:mk_tag_job = job_start('sh -c "cd `git rev-parse --show-toplevel && git rev-parse --show-toplevel` && ctags -Rf tags_tmp && sed ' . "'1i!_TAG_FILE_ENCODING	CP932'" . ' tags_tmp > tags && awk ' . "'{ print $1 }'" . ' tags > tag_only"')
  endif
  let s:mk_tag_exe = 1
endfunction

function! MakeTags()
  if exists('s:mk_tag_job')
    if job_status(s:mk_tag_job) == 'run'
      return
    endif
  endif
  if &fileencoding == 'cp932'
   "let s:mk_tag_job = job_start('sh -c "git rev-parse --show-toplevel && cd `git rev-parse --show-toplevel` && rm tags_tmp && ctags -Rf tags_tmp && sed -i -e' . "'1i!_TAG_FILE_ENCODING	CP932'" . ' tags_tmp && mv tags_tmp tags && awk ' . "'{ print $1 }'" . ' tags > tag_only"')
    let s:mk_tag_job = job_start('sh -c "git rev-parse --show-toplevel && cd `git rev-parse --show-toplevel` &&                ctags -Rf tags_tmp && sed -i -e' . "'1i!_TAG_FILE_ENCODING	CP932'" . ' tags_tmp && mv tags_tmp tags && awk ' . "'{ print $1 }'" . ' tags | sort | uniq > tag_only"')
  else
    " utf-8
   "let s:mk_tag_job = job_start('sh -c "git rev-parse --show-toplevel && cd `git rev-parse --show-toplevel` && ctags -Rf tags_tmp && mv tags_tmp tags && awk ' . "'{ print $1 }'" . ' tags > tag_only"')
    let s:mk_tag_job = job_start('sh -c "git rev-parse --show-toplevel && cd `git rev-parse --show-toplevel` && ctags -Rf tags_tmp && mv tags_tmp tags && awk ' . "'{ print $1 }'" . ' tags | sort | uniq > tag_only"')
  endif
endfunction

" 最終版
" ( git rev-parse --show-toplevel && cd `git rev-parse --show-toplevel` && ctags -Rf tags_tmp && mv tags_tmp tags && awk '{ print $1 }' tags > tag_only ) &
" ( git rev-parse --show-toplevel && cd `git rev-parse --show-toplevel` && rm tags_tmp && ctags -Rf tags_tmp && sed -i -e'1i!_TAG_FILE_ENCODING	CP932' tags_tmp && mv tags_tmp tags && awk '{ print $1 }' tags > tag_only)


" MakeTags }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" ReadTag {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

if 0
  com! ReadTag silent sfind tag_only | setl autoread | close
  set complete=.,w,b,u,U
  com! ReadTag try | silent sfind tag_only | setl autoread | bdelete | catch | finally | endtry
  com! ReadTag try | silent exe 'split' GetPrjRoot() . 'tag_only' | setl autoread | bdelete | catch | finally | endtry
  augroup MyVimrc_ReadTag
    au!
    "au BufReadPost *.c,*.h let v:swapchoice = 'o' | ReadTag
    " TODO 遅延化
    au BufReadPost *.c,*.h ReadTag
  augroup end
elseif 0
  augroup MyVimrc_ReadTag
    au!
    au BufReadPost *.c,*.h exe 'set complete+=k' . GetPrjRoot() . 'tag_only'
  augroup end
elseif 0
  set complete=.,w,b
  augroup MyVimrc_ReadTag
    au!
    au BufReadPost * exe 'set complete+=k' . GetPrjRoot() . 'tag_only'
  augroup end
else
  set complete=.,w,b,u
  set complete=.,w,b
 "com! ReadTag try | silent exe 'sview' GetPrjRoot() . '/tag_only' | setl autoread | close | catch | finally | endtry
  com! ReadTag try | silent exe 'sview' GetPrjRoot() . 'tag_only' | setl autoread | close | catch | finally | endtry
  augroup MyVimrc_ReadTag
    au!
    "au BufReadPost *.c,*.h let v:swapchoice = 'o' | ReadTag
    " TODO 遅延化
   "au BufReadPost *.c,*.h ReadTag
    au BufReadPost * ReadTag
  augroup end
endif

" ReadTag }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



cabb f find



" 初期設定
" 最後に実施する必要あり。
silent call <SID>ToggleTabline(3)




" ==============================  form .gvimrc  {{{

set mps+=（:）,「:」,『:』,【:】

call SetCpmplKey('ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴヵヶヷヸヹヺー')

" いわゆる全角Ｊ
inoremap <buffer><expr> ｊ pumvisible() ? '<C-n>' : 'j'
" いわゆる全角ｋ
inoremap <buffer><expr> ｋ pumvisible() ? '<C-p>' : 'k'
"inoremap <buffer><expr> <C-j> pumvisible() ? '<C-n>' : '<C-j>'
"inoremap <buffer><expr> <C-k> pumvisible() ? '<C-p>' : '<C-k>'

inoremap <expr>   ｊｊ pumvisible() ? '<C-N><C-N>' : '<Esc>:w<CR>'
inoremap <expr>   ｇｇ pumvisible() ? '<C-N><C-N>' : '<Esc>:w<CR>'
inoremap <expr>     ｊ pumvisible() ? '<C-N><C-N>' : '<Esc>:w<CR>'
"inoremap <expr>   っｊ pumvisible() ? '<C-N><C-N>' : '<Esc>:w<CR>'
"inoremap <silent> っj  <ESC>
"inoremap <expr>   っｇ pumvisible() ? '<C-N><C-N>' : '<Esc>:w<CR>'
"inoremap <silent> っｇ <ESC>

"highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#ffffff
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#333377
augroup MyVimrc_ZenkakuSpace
  au!
  au BufNewFile,BufRead * match ZenkakuSpace /　/
augroup end


iab <silent> q1  ①<C-R>=Eatchar('\s')<CR>
iab <silent> q2  ②<C-R>=Eatchar('\s')<CR>
iab <silent> q3  ③<C-R>=Eatchar('\s')<CR>
iab <silent> q4  ④<C-R>=Eatchar('\s')<CR>
iab <silent> q5  ⑤<C-R>=Eatchar('\s')<CR>
iab <silent> q6  ⑥<C-R>=Eatchar('\s')<CR>
iab <silent> q7  ⑦<C-R>=Eatchar('\s')<CR>
iab <silent> q8  ⑧<C-R>=Eatchar('\s')<CR>
iab <silent> q9  ⑨<C-R>=Eatchar('\s')<CR>
iab <silent> q10 ⑩<C-R>=Eatchar('\s')<CR>
iab <silent> q11 ⑪<C-R>=Eatchar('\s')<CR>
iab <silent> q12 ⑫<C-R>=Eatchar('\s')<CR>


iab <silent> qd ・<C-R>=Eatchar('\s')<CR>


function! C_A()
      if search('\%#①', 'bcn')	| return "s②\<Esc>"
  elseif search('\%#②', 'bcn')	| return "s③\<Esc>"
  elseif search('\%#③', 'bcn')	| return "s④\<Esc>"
  elseif search('\%#④', 'bcn')	| return "s⑤\<Esc>"
  elseif search('\%#⑤', 'bcn')	| return "s⑥\<Esc>"
  elseif search('\%#⑥', 'bcn')	| return "s⑦\<Esc>"
  elseif search('\%#⑦', 'bcn')	| return "s⑧\<Esc>"
  elseif search('\%#⑧', 'bcn')	| return "s⑨\<Esc>"
  elseif search('\%#⑨', 'bcn')	| return "s⑩\<Esc>"
  elseif search('\%#⑩', 'bcn')	| return "s⑪\<Esc>"
  elseif search('\%#⑪', 'bcn')	| return "s⑫\<Esc>"
  elseif search('\%#⑫', 'bcn')	| return "s⑬\<Esc>"
  elseif search('\%#⑬', 'bcn')	| return "s⑭\<Esc>"
  elseif search('\%#⑭', 'bcn')	| return "s⑮\<Esc>"
  elseif search('\%#⑮', 'bcn')	| return "s⑯\<Esc>"
  endif
  return ''
endfunc
function! C_X()
      if search('\%#②', 'bcn')	| return "s①\<Esc>"
  elseif search('\%#③', 'bcn')	| return "s②\<Esc>"
  elseif search('\%#④', 'bcn')	| return "s③\<Esc>"
  elseif search('\%#⑤', 'bcn')	| return "s④\<Esc>"
  elseif search('\%#⑥', 'bcn')	| return "s⑤\<Esc>"
  elseif search('\%#⑦', 'bcn')	| return "s⑥\<Esc>"
  elseif search('\%#⑧', 'bcn')	| return "s⑦\<Esc>"
  elseif search('\%#⑨', 'bcn')	| return "s⑧\<Esc>"
  elseif search('\%#⑩', 'bcn')	| return "s⑨\<Esc>"
  elseif search('\%#⑪', 'bcn')	| return "s⑩\<Esc>"
  elseif search('\%#⑫', 'bcn')	| return "s⑪\<Esc>"
  elseif search('\%#⑬', 'bcn')	| return "s⑫\<Esc>"
  elseif search('\%#⑭', 'bcn')	| return "s⑬\<Esc>"
  elseif search('\%#⑮', 'bcn')	| return "s⑭\<Esc>"
  elseif search('\%#⑯', 'bcn')	| return "s⑮\<Esc>"
  endif
  return ''
endfunc
nnoremap <C-a> :call C_A()<CR>
nnoremap <C-x> :call C_X()<CR>

nnoremap <expr> <C-a> search('\%#[\U2460-\U2473]', 'bcn') ? C_A() : "\<C-a>"
nnoremap <expr> <C-x> search('\%#[\U2460-\U2473]', 'bcn') ? C_X() : "\<C-x>"

"inoremap (( （
"inoremap )) ）

"nmap 　 <Space>


" ==============================  form .gvimrc  }}}


"com! -nargs=+ F
"      \ exe 'sfind ' . ('<args>'[0] == '.' ? '' : '*') . substitute('<args>', ' ', '*', 'g') . '*'


com! -nargs=+ F
      \ try | exe 'find' <q-args> | catch |
      \ try | exe 'find ' . ('<args>'[0] == '.' ? '' : '*') . substitute('<args>', ' ', '*', 'g') . '*' | catch |
      \ call feedkeys(':find *' . substitute('<args>', ' ', '*', 'g') . '*<Tab><Tab><Tab>', 'nt') | endtry | endtry

com! -nargs=+ S
      \ try | exe 'sfind' <q-args> | catch |
      \ try | exe 'sfind ' . ('<args>'[0] == '.' ? '' : '*') . substitute('<args>', ' ', '*', 'g') . '*' | catch |
      \ call feedkeys(':sfind *' . substitute('<args>', ' ', '*', 'g') . '*<Tab><Tab><Tab>', 'nt') | endtry | endtry

com! -nargs=+ T
      \ try | exe 'tab sfind' <q-args> | catch |
      \ try | exe 'tab sfind ' . ('<args>'[0] == '.' ? '' : '*') . substitute('<args>', ' ', '*', 'g') . '*' | catch |
      \ call feedkeys(':tab sfind *' . substitute('<args>', ' ', '*', 'g') . '*<Tab><Tab><Tab>', 'nt') | endtry | endtry


if 0
  com! -nargs=+ S
        \ try | exe 'sfind' <q-args> | catch
        \ try | exe 'sfind ' . ('<args>'[0] == '.' ? '' : '*') . substitute('<args>', ' ', '*', 'g') . '*' | 
        \ catch | call feedkeys(':sfind *' . substitute('<args>', ' ', '*', 'g') . '*<Tab>', 'nt') | endtry

  com! -nargs=+ T
        \ try | exe 'tab sfind' <q-args> | catch
        \ try | exe 'tab sfind ' . ('<args>'[0] == '.' ? '' : '*') . substitute('<args>', ' ', '*', 'g') . '*' | 
        \ catch | call feedkeys(':tab sfind *' . substitute('<args>', ' ', '*', 'g') . '*<Tab>', 'nt') | endtry
endif

"com! -nargs=+ F
"      \ exe 'find ' . ('<args>'[0] == '.' ? '' : '*') . substitute('<args>', ' ', '*', 'g') . '*'


"com! -nargs=+ F
"     \ call feedkeys(':find *' . substitute('<args>', ' ', '*', 'g') . '*<Tab>', 'nt')
"     \ try | exe 'find' <q-args> | catch
"     \ try | exe 'find ' . ('<args>'[0] == '.' ? '' : '*') . substitute('<args>', ' ', '*', 'g') . '*' | endtry |
"     \ catch | call feedkeys(':find *' . substitute('<args>', ' ', '*', 'g') . '*<Tab>', 'nt') | endtry



"nnoremap t ]m
"nnoremap T [m



com! Date echo system("date")
com! Cal echo system("cal")
com! Cal echo system("cal") <Bar> echo system("date")
com! Cal echo ' ' <Bar> echo system("date") <Bar> echo ' ' <Bar> echo ' ' <Bar> echo system("cal")



com! -bar -nargs=? ETempfile exe 'edit'      tempname() . (<q-args> =~ '^[^.]' ? '.' . <q-args> : <q-args>)
com! -bar -nargs=? STempfile exe 'split'     tempname() . (<q-args> =~ '^[^.]' ? '.' . <q-args> : <q-args>)
com! -bar -nargs=? VTempfile exe 'vsplit'    tempname() . (<q-args> =~ '^[^.]' ? '.' . <q-args> : <q-args>)
com! -bar -nargs=? TTempfile exe 'tab split' tempname() . (<q-args> =~ '^[^.]' ? '.' . <q-args> : <q-args>)
com! -bar -nargs=? Tempfile  STempfile <args>


"match CursorLineNr /\%#./


" TODO 不正なプリプロ命令をハイライト


set winminwidth=0



" nnoremap <silent> <F9>  :exe 'winpos' getwinposx() - 1 ' ' getwinposy() - 0<CR>
" nnoremap <silent> <F10> :exe 'winpos' getwinposx() + 0 ' ' getwinposy() + 1<CR>
" nnoremap <silent> <F11> :exe 'winpos' getwinposx() - 0 ' ' getwinposy() - 1<CR>
" nnoremap <silent> <F12> :exe 'winpos' getwinposx() + 1 ' ' getwinposy() + 0<CR>
" 
" nnoremap <silent> <S-F9>  :let &columns -= 1<CR>
" nnoremap <silent> <S-F10> :let &lines   += 1<CR>
" nnoremap <silent> <S-F11> :let &lines   -= 1<CR>
" nnoremap <silent> <S-F12> :let &columns += 1<CR>






let g:Words = [
      \ [ 'TRUE', 'FALSE' ],
      \ [ 'true', 'false' ],
      \ [ '==',   '!=' ],
      \ [ '0',    '1' ],
      \ [ '0U',   '1U' ],
      \ [ '0x0U', '0x1U' ],
      \ [ 'mcu_DI', 'mcu_EI' ],
\ ]







nnoremap <Leader>9 :<C-u>RainbowParenthesesToggle<CR>



com! WinOptimalWidth PushPosAll | exe 'silent windo call Window#Resize#SetOptimalWidth()' | PopPosAll

com! WinOptimalWidthRev PushPosAll | for i in reverse(range(1, winnr('$'))) | exe i 'wincmd w' | sile call Window#Resize#SetOptimalWidth() | endfor | PopPosAll


nnoremap <silent> gM :<C-u>enew<CR>



":amenu ]Toolbar.Make	:make
":amenu ]Toolbar.Mare	:Date
":popup ]Toolbar

"aunmenu ]Toolbar
com! -bar FAM aunmenu ]Toolbar | exe 'amenu' ']Toolbar.' . cfi#format('%s ()', '') ':echo<CR>'
com! FSM FAM | popup ]Toolbar
nnoremap , :<C-u>FSM<CR>
"nnoremap , :<C-u>FSM<CR>:3sleep<CR><Esc>




if 0
  set completeopt=longest
  set completeopt=
  inoremap <C-j> <C-n>
  inoremap <C-k> <C-p>
  imap jj <Plug>(InsertLeave)
endif
"iunmap jj

" so ~/vimfiles/ime.vim



augroup MyVimrc_WinColor
  au!
 "autocmd ColorScheme * highlight NormalNC guifg=NONE guibg=#121212
  "autocmd WinEnter,BufWinEnter * set wincolor=
  "autocmd WinLeave * set wincolor=NormalNC
augroup end


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


" iab IF0 #if 0
" #else
" #endif<C-R>=Eatchar('\s')<CR>

augroup MyVimrc_ChDir
  au!
 "au DirChanged window,tabpage,global pwd
  au DirChanged global pwd
augroup end

set cursorlineopt=number,screenline





" vim.vim {{{



command! -nargs=* BUF exe 'browse filter %\c' . substitute(<q-args>, '[ *]', '.*', 'g') . '% ls' | call feedkeys(':b ', 'n')

"nnoremap K :<C-u>BUF<Space>



iab <silent> inc  #include ""<Left><C-x><C-f><C-R>=Eatchar('\s')<CR>
iab <silent> inca #include ""<Left>src_a/<C-x><C-f><C-R>=Eatchar('\s')<CR>
iab <silent> inci #include ""<Left>inc/<C-x><C-f><C-R>=Eatchar('\s')<CR>



"? nnoremap <silent> <Leader>O :<C-u>MyExplore<CR>



"? function! PyCyg()
"? python3 << PYCODE
"? import subprocess
"? subprocess.Popen(["C:/cygwin/bin/mintty.exe", "--title", "Vim Term", "--size", "160,50", "-o", "Locale=ja_JP", "-o", "Charset=UTF-8", "C:/cygwin/bin/zsh.exe"])  # , "-B", "frame"
"? PYCODE
"? endfunction
"? com! PyCyg call PyCyg()

"nnoremap <silent> <C-z> :<C-u>SH2<CR>
"nnoremap <silent> <C-z> :<C-u>PyCyg<CR>



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



" test.vim {{{



function! s:GoToDeclaration()
  let cl0 = line(".")
  let bn0 = bufnr(0)

  set tags=./tags
  try
    "tjump
    "exe "normal! \<C-]>"
    normal! 
  catch
  endtry
  let cl = line(".")
  let bn = bufnr(0)
  if cl0 != cl || bn0 != bn | return | endif

  set tags=tags;
  try
    "tjump
    "exe "normal! \<C-]>"
    normal! 
  catch
  endtry
  let cl = line(".")
  let bn = bufnr(0)
  if cl0 != cl || bn0 != bn | return | endif

  try
    normal! gD
    let cl = line(".")
    let bn = bufnr(0)
  catch
  endtry
  if cl0 != cl || bn0 != bn | return | endif

  try
    normal! gd
    let cl = line(".")
    if cl0 != cl | return | endif
  catch
  endtry

  " echoe 'Declaration not found.'
  echo 'Declaration not found.'
endfunction
"call <SID>GoToDeclaration()
"nnoremap <buffer> <silent> <CR> :<C-u>call <SID>GoToDeclaration()<CR>
"nnoremap  <CR> :<C-u>call <SID>GoToDeclaration()<CR>

" TODO
" 念のため、バッファが変わったことも確認する。
" なぜか、statusline用のauが効かないので、独自にbuf_name_lenの設定を行う。
"



" ver 0.1
" function! s:GoToDeclaration()
" 	let cl0 = line(".")
" 
" 	try
" 		normal! 
" 	catch
" 	endtry
" 	let cl = line(".")
" 	if cl0 != cl | return | endif
" 
" 	normal! gD
" 	let cl = line(".")
" 	if cl0 != cl | return | endif
" 
" 	normal! gd
" 	let cl = line(".")
" 	if cl0 != cl | return | endif
" 
" 	echoe 'Declaration not found.'
" endfunction
" "call <SID>GoToDeclaration()
" nnoremap <silent> <CR> :<C-u>call <SID>GoToDeclaration()<CR>




func! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc
"iabbr <silent> if if ()<Left><C-R>=Eatchar('\s')<CR>
iabbr <silent> di mcu_DI();<CR><C-R>=Eatchar('\s')<CR>
iabbr <silent> ei mcu_EI();<CR><C-R>=Eatchar('\s')<CR>
iabbr <silent> DI mcu_DI();<CR><C-R>=Eatchar('\s')<CR>
iabbr <silent> EI mcu_EI();<CR><C-R>=Eatchar('\s')<CR>
iabbr <silent> bo <Tab>// ブレーク置き場<C-R>=Eatchar('\s')<CR>

"iabbr di Ghddrv_DI();<CR>


"echohl Special | echon 90 | echohl None | echon 80

"// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

"MMC
"#define	TAKUBO_PORT	CO_VVL_FS_RLY
"TAKUBO_PORT ^= 1UL;


"SMC ENG
"#define	TAKUBO_PORT		(PORT.PCR5_1.BIT.P)


" #define	TAKUBO_PORT		CO_VVL_FS_RLY
" #define TAKUBO_50us_DIV_125ns	400UL	/* ( 50000 / 125  ) */
" 
" volatile ulong	takubo;
"
"
"
"	,rammnt.bss.pm1 &	;RAM monitor
"	,main.bss.pm1 &








func! s:func_copy_cmd_output(cmd)
  redir @*>
  silent execute a:cmd
  redir END
endfunc

command! -nargs=1 -complete=command CopyCmdOutput call <SID>func_copy_cmd_output(<q-args>)



"echo "a"
"echo "a"
"echo "a"
"echo "a"
"call feedkeys(":b ")

" function! CollectFuncs()
function! s:GotoFunc()
  let n = 0
  let ftop = []

  call PushPos()

  keepjumps normal! gg
  "let old_line = line(".")
  "echo getline(".")
  "try
  while 1
    keepjumps normal! ]]
    "if old_line == line("$")
    if line(".") == line("$")
      break
    endif
    "let old_line = line(".")
    keepjumps normal! k
    " TODO 各スタイルに対応
    echo printf("%2d  %s", n + 1, getline("."))
    "exe "let ftop_" . n + 1 . " = line('.')"
    call add(ftop, line('.'))
    let n += 1
    keepjumps normal! j
  endwhile
  "finally
  "endtry

  call PopPos()
  "echo "normal! " . ftop_" . n . " = line('.')"

  if n >= 10
    let m = input("> ")
  else
    echo "> "
    let m = nr2char(getchar())
    call feedkeys("<CR>")
  endif

  if m =~# 'g'
    normal! gg
  elseif m =~# 'G'
    normal! G
  elseif m =~ '\d\+'
    exe "normal!" ftop[m - 1] . "G"
    "exe "normal!" ftop[m - 1] . "Gz\<CR>"
    normal! 0f(bz

  endif
  "if m !~ '\d\+' | return | endif
endfunction

function! s:GotoFunc()

  "便宜上の措置
  GotoFuncCloseWin

  let n = 0
  let funcs = []
  let ftop = []

  PushPos

  keepjumps normal! gg

  while 1
    keepjumps normal! ]]

    if line(".") == line("$")
      break
    endif

    keepjumps normal! k

    " TODO 各スタイルに対応

    call add(funcs, printf("%2s  %s", n + 1, getline(".")))
    if 1
      call add(funcs, '')
    endif

    call add(ftop, line('.'))
    let n += 1

    keepjumps normal! j
  endwhile

  PopPos

  let s:win_id = popup_create( funcs, #{
        \ line: 'cursor+1',
        \ col: 'cursor',
        \ pos: 'center',
        \ posinvert: v:true,
        \ minwidth: 30,
        \ maxheight: &lines - 4 - 3,
        \ tabpage: 0,
        \ wrap: v:false,
        \ zindex: 200,
        \ drag: 1,
        \ highlight: 'NormalPop',
        \ border: [1, 1, 1, 1],
        \ close: 'click',
        \ padding: [1, 1, 0, 1],
        \ })
        " cursorline: 1,
        " moved: 'any',
        " time: a:time,
        " mask: mask
        " filter: 'popup_filter_menu',

  call setbufvar(winbufnr(s:win_id), '&filetype', getbufvar(bufnr(), '&filetype'))

  redraw

  if n >= 10
    let m = input("> ")
  else
    echo "> "
    let m = nr2char(getchar())
    call feedkeys("<CR>")
  endif

  if m =~# 'g'
    normal! gg
  elseif m =~# 'G'
    normal! G
  elseif m =~ '\d\+'
    exe "normal!" ftop[m - 1] . "G"
   "exe "normal!" ftop[m - 1] . "Gz\<CR>"
    normal! 0f(bz<CR>
  else "if n < 10
    "call feedkeys(m, 'mt')
  endif

  call popup_close(s:win_id)
endfunction

let s:keys = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
let s:keys = '123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ0'
let s:keys = 'FJGHKDLTUYREA;\123456789BCIMNOPSVWXZ0Q'
let s:keys = 'JFHGKDLSTUYREA;\123456789BCIMNOPVWXZ0Q'
" Qは使わない
let s:keys = 'JFHGKDLSTUYREA;\123456789BCIMNOPVWXZ0'

function! s:GotoFunc()

  "便宜上の措置
  GotoFuncCloseWin

  let n = 0
  let funcs = []
  let ftop = []

  PushPos

  keepjumps normal! gg

  while 1
    keepjumps normal! ]]

    if line(".") == line("$")
      break
    endif

    keepjumps normal! k

    " TODO 各スタイルに対応

   "call add(funcs, printf("%2d  %2s  %s", n + 1, n < len(s:keys) ? s:keys[n] : n + 1, getline(".")))
   "call add(funcs, printf("%2s  %s    // %2d  ", n < len(s:keys) ? s:keys[n] : n + 1, getline("."), n + 1))
    call add(funcs, printf("%2s   %s", n < len(s:keys) ? s:keys[n] : n + 1, getline(".")))
    if 1
      call add(funcs, '')
    endif

    call add(ftop, line('.'))
    let n += 1

    keepjumps normal! j
  endwhile

  call add(funcs, printf("[  %d  ]  ", n))

  PopPos

  let s:win_id = popup_create( funcs, #{
        \ line: 'cursor+1',
        \ col: 'cursor',
        \ posinvert: v:true,
        \ pos: 'center',
        \ minwidth: 30,
        \ maxheight: &lines - 4 - 3,
        \ tabpage: 0,
        \ wrap: v:false,
        \ zindex: 200,
        \ mousemoved: [0, 0, 0],
        \ drag: 1,
        \ highlight: 'NormalPop',
        \ border: [1, 1, 1, 1],
        \ close: 'click',
        \ padding: [1, 4, 1, 1],
        \ })
        " cursorline: 1,
        " moved: 'any',
        " time: a:time,
        " mask: mask
        " filter: 'popup_filter_menu',

  call setbufvar(winbufnr(s:win_id), '&filetype', getbufvar(bufnr(), '&filetype'))

  redraw

  if n >= len(s:keys)
    let m = input("> ")
  else
    echo "> "
    let m = nr2char(getchar())
    call feedkeys("<CR>")
  endif

  let nn = match(s:keys, m)

  if nn >= 0 && nn < n
   "exe "normal!" ftop[nn] . "G"
    exe "normal!" ftop[nn] . "Gz\<CR>"
    normal! 0f(bz<CR>
  elseif m =~ '\d\+'
    " 救済
   "exe "normal!" ftop[m - 1] . "G"
    exe "normal!" ftop[m - 1] . "Gz\<CR>"
    normal! 0f(bz<CR>
  endif

  call popup_close(s:win_id)
endfunction

let s:win_id = 0

function! GotoFunc_CloseWin()
  call popup_close(s:win_id)
endfunction
call EscEsc_Add('call GotoFunc_CloseWin()')

nnoremap <silent> <leader>f :call <SID>GotoFunc()<CR>
com! GotoFuncCloseWin call GotoFunc_CloseWin()




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



""" Form Vimrc


" Cscope
" nnoremap <C-j><C-a> :<C-u>cscope add cscope.out<CR>
" nnoremap <C-j><C-j> :<C-u>cscope find 
" nnoremap <C-j>c     :<C-u>cscope find c 
" nnoremap <C-j>d     :<C-u>cscope find d 
" nnoremap <C-j>e     :<C-u>cscope find e 
" nnoremap <C-j>f     :<C-u>cscope find f 
" nnoremap <C-j>g     :<C-u>cscope find g 
" nnoremap <C-j>i     :<C-u>cscope find i 
" nnoremap <C-j>s     :<C-u>cscope find s 
" nnoremap <C-j>t     :<C-u>cscope find t 
" nnoremap <C-j>C     :<C-u>cscope find c <C-r><C-w><CR>
" nnoremap <C-j>D     :<C-u>cscope find d <C-r><C-w><CR>
" nnoremap <C-j>E     :<C-u>cscope find e <C-r><C-w><CR>
" nnoremap <C-j>F     :<C-u>cscope find f <C-r><C-w><CR>
" nnoremap <C-j>G     :<C-u>cscope find g <C-r><C-w><CR>
" nnoremap <C-j>I     :<C-u>cscope find i <C-r><C-w><CR>
" nnoremap <C-j>S     :<C-u>cscope find s <C-r><C-w><CR>
" nnoremap <C-j>T     :<C-u>cscope find t <C-r><C-w><CR>


if exists('*smartchr#one_of')
  "TODO 行末
  inoremap <expr> , smartchr#one_of(', ', ',')

  " 演算子の間に空白を入れる
  inoremap <expr> + smartchr#one_of(' = ', ' == ', '=')
  inoremap <expr> + smartchr#one_of(' + ', '++', '+')
  inoremap <expr> - smartchr#one_of(' - ', '--', '-')
  inoremap <expr> * smartchr#one_of(' * ', '*')
  inoremap <expr> / smartchr#one_of(' / ', '/')
  inoremap <expr> % smartchr#one_of(' % ', '%')
  inoremap <expr> & smartchr#one_of(' & ', ' && ', '&')
  inoremap <expr> <Bar> smartchr#one_of(' <Bar> ', ' <Bar><Bar> ', '<Bar>')

  if &filetype == "c"
    " 下記の文字は連続して現れることがまれなので、二回続けて入力したら改行する
    inoremap <buffer><expr> } smartchr#one_of('}', '}<cr>')
    inoremap <buffer><expr> ; smartchr#one_of(';', ';<cr>')
  endif
  inoremap <expr> + smartchr#one_of(' = ', ' == ', '=')
endif


"nnoremap s f_l
"nnoremap S F_h
"nnoremap ci s
"nnoremap cI S


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



" test.vim }}}




" 起動速度

" どうしようもない時間は、170ms程度。余裕を見て180～200msくらいか。

"let did_install_default_menus = 1
" TODO $VIMRUNTIME/menu.vimを削除する。

" 以下を削除。
" $VIM\gvimrc
" $HOME\_gvimrc
" $VIMRUNTIME\gvimrc_example.vim




" .gvimrc {{{
" set guioptions=

"? scriptencoding utf-8
"? " vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"? 
"? 
"? " set visualbell t_vb=
"? 
"? " set guioptions=
"? 
"? " colorscheme Rimpa
"? 
"? " set transparency=235
"? 
"? " set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,a:blinkon0
"? " set guicursor=n-v-c:ver10-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,a:blinkon0
"? 
"? " call ResizeFont(0)
"? 
"? 
"? 
" .gvimrc }}}




if !g:UseHHKB
  inoremap <Left>   <Nop>
  inoremap <Right>  <Nop>
  inoremap <Down>   <Nop>
  inoremap <Up>     <Nop>

  cnoremap <Left>  <Nop>
  cnoremap <Right> <Nop>
  cnoremap <Down>  <Nop>
  cnoremap <Up>    <Nop>
"else
"  iunmap <Left>
"  iunmap <Right>
"  iunmap <Down>
"  iunmap <Up>
"
"  cunmap <Left>
"  cunmap <Right>
"  cunmap <Down>
"  cunmap <Up>
endif

cnoremap <S-Ins>  <Nop>




com! Utf8  setl fileencoding=utf-8
com! Cp932 setl fileencoding=cp932





" 最後に置かないと、au ColorScheme が実行されない。
colorscheme Rimpa.new




" Bug Issue
"     ・E443のメッセージ
"     ・NerdTreeVCS が無限ループ
"     ・zl zh が動かなくなる
"     ・find でワイルドカードを使用すると、E480のエラー。
"     ・CursorLineがONで、改行を含む文字列を検索したとき、hlsearchでの改行のハイライトがカレント行のときだけになるのは、おかしい。
"

com! QfStl setlocal stl=%#SLFileName#[\ %{winnr()}\ ]%##\ (\ %n\ )\ %t%{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P



set cedit=<C-q>

augroup MyVimrc_CmdWin
  au!
  au CmdwinEnter * call s:init_cmdwin()
augroup end
function! s:init_cmdwin()
  "nnoremap <buffer> q :<C-u>quit<CR>
  "nnoremap <buffer> <TAB> :<C-u>quit<CR>
  "inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
  "inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  "inoremap <buffer><expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"

  "" Completion.
  "inoremap <buffer><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

  "startinsert!

  nnoremap <buffer> <CR> <CR>
endfunction


hi PPP	guifg=#f6f3f0	guibg=#292927	gui=none	ctermfg=254	ctermbg=235
set previewpopup=height:30,width:120,highlight:PPP




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




" Tag_Test {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

"■仕様
"
" タグが1つならそれ
" 内部タグがあればそれ（内部タグ複数はない想定）
" 外タグなら
"   IncludeFilesに対して
"     1つならそれ
"     同Dirに1つならそれ
"     下位Dirに1つならそれ
"     TODO: ファイル名の特徴から推測
"   非IncludeFilesに対して
"     同Dirに1つならそれ
"     下位Dirに1つならそれ
"     TODO: ファイル名の特徴から推測
" ユーザ選択
"

function! GetTags(word)
 "echo len(taglist(expand('<cword>')))
 "let word = expand('<cword>')
 "let taglist = len(taglist(word))
  let taglist = taglist(a:word)
  let num_tag = len(taglist)
  PrettyPrint taglist
  echo num_tag
endfunction

com! GetTags call GetTags(expand('<cword>'))


function! GetIncludeFiles(file)
  let inclist = execute('checkpath!')
  "echo inclist
  let incs = split(inclist, '\n')
  call remove(incs, 0)
  call filter(incs, { idx, val -> val !~ '-->$' })
  call filter(incs, { idx, val -> val !~ ')$' })  " '(既に列挙)'行を削除
  call filter(incs, { idx, val -> val !~ '"\f\+"' })  " '見つかりません'行を削除
  "PrettyPrint incs

  return incs
endfunction

com! GetIncludeFiles call GetIncludeFiles(expand('%f'))

function! TTTT(word, mode)
  let taglist = taglist(a:word)
  "PrettyPrint taglist

  " タグが1つならそれ
  if len(taglist) == 1
    "return v:false
    exe 'tag' a:word
    return v:true
  endif

  let cmd_tag     = (a:mode =~? 'w' ? 's' : '') . 'tag'
  let cmd_tselect = (a:mode =~? 'w' ? 's' : '') . 'tselect'

  let t_file = range(len(taglist))

  " 内部タグがあればそれ（内部タグ複数はない想定）
  let cur_file = expand('%:p')
  for i in range(len(taglist))
    let t_file = fnamemodify(taglist[i]['filename'], ':p')
    " cache
    "let t_file[i] = fnamemodify(taglist[i]['filename'], ':p')
    if t_file == cur_file
      "exe i (a:mode =~? 'w' ? 's' : '')) . 'tag' a:word
      exe i cmd_tag a:word
      return v:true
    endif
    "echo i
  endfor

  "   IncludeFilesに対して
  let incs = GetIncludeFiles(expand('%f'))

  for i in range(len(taglist))
    "let t_file = fnamemodify(taglist[i]['filename'], ':p')
    for j in incs
      " TODO
      let inc = substitute(j, ' \+', '', 'g')
      let inc_file = fnamemodify(inc, ':p')
      "echo inc_file
      if t_file == inc_file
        "exe i (a:mode =~? 'w' ? 's' : '')) . 'tag' a:word
        exe i cmd_tag a:word
        return v:true
      endif
    endfor
    "echo i
  endfor

  " TODO
  "exe (a:mode =~? 'w' ? 's' : '')) . 'tselect' a:word
  exe cmd_tselect a:word

  """  "let num_tag = len(taglist)
  """  "echo num_tag

  """  "let org_dir = getcwd()

  """  if 0
  """    if 0
  """      for i in tagfiles()
  """        let dir = fnamemodify(i, ':h')
  """        echo dir
  """      endfor
  """    else
  """      let dir = GetPrjRoot()
  """    endif
  """  endif

  """  "exe 'cd ' . org_dir

  return v:false
endfunction

function! TTTT(word, mode)
  "let org_dir = getcwd()

  "if 0
  "  for i in tagfiles()
  "    let dir = fnamemodify(i, ':h')
  "    echo dir
  "  endfor
  "else
  "  let dir = GetPrjRoot()
  "endif
  "exe 'cd ' . dir

  let taglist = taglist('\<' . a:word . '\>')
  "PrettyPrint taglist

  "exe 'cd ' . org_dir

  if len(taglist) == 0
    return v:false
  endif

  let cmd_tag     = (a:mode =~? 'p' ? 'p' : (a:mode =~? 'w' ? 's' : '')) . 'tag'
  let cmd_tselect = (a:mode =~? 'p' ? 'p' : (a:mode =~? 'w' ? 's' : '')) . 'tselect'
  if a:mode =~? 's'
    let cmd_tag = cmd_tselect
  endif

  " タグが1つならそれ
  if len(taglist) == 1
    "return v:false
    exe cmd_tag a:word
    return v:true
  endif

  " 内部タグがあればそれ（内部タグ複数はない想定）
  let cur_file = expand('%:p')
  " カレントディレクトリ相対にしないと、ctagsとDOSでパスの形式が異なる。
  let cur_file = fnamemodify(cur_file, ':.')

  for i in range(len(taglist))
    let t_file = taglist[i]['filename']
    let t_file = fnamemodify(t_file, ':.')

     "echo '^r' t_file '$'
     "echo '^r' cur_file '$'
     "echo '^m' fnamemodify(t_file, ':.') '$'
     "echo '^m' fnamemodify(cur_file, ':.') '$'

    if t_file == cur_file
      "echo i
      exe i+1 cmd_tag a:word
      return v:true
    endif
    "echo i
  endfor

  "   IncludeFilesに対して

  "let dir = GetPrjRoot()
  "exe 'cd ' . dir
  let incs = GetIncludeFiles(expand('%f'))
  "exe 'cd ' . org_dir

  for i in range(len(taglist))
    let t_file = taglist[i]['filename']
    for j in incs
      " TODO Trim
      let inc = substitute(j, ' \+', '', 'g')

      let inc_file = inc
      "echo inc_file
      if t_file == inc_file
        " echo i
        " echo taglist[i - 1]
        " echo taglist[i    ]
        " echo taglist[i + 1]
        " sleep 2
        exe i+1 cmd_tag a:word
        return v:true
      endif
    endfor
    "echo i
  endfor

  exe cmd_tselect a:word

  return v:true
endfunction

com! TTTT call TTTT(expand('<cword>'), '')

if 0
  augroup TTTT
    au!
    au CursorHold *.[ch] nested exe "silent! psearch " . expand("<cword>")
  augroup end
  set previewpopup=
else
  augroup TTTT
    au!
  augroup end
endif

" Tag_Test }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



com! Unicode normal! g8
nnoremap ga ^C
nnoremap gA S



"nunmap gU

"? Substitute nmap S *
"? Substitute 
"? Substitute nnoremap <C-s>           :<C-u>g$.$s    %%<Left>
"? Substitute vnoremap <C-s>                    :s    %%<Left>

nnoremap gs              :<C-u>g$.$s    %<C-R>/%%g<Left><Left>
vnoremap gs                       :s    %<C-R>/%%g<Left><Left>


augroup example
  autocmd!
  autocmd CmdUndefined Foo* execute 'command! -nargs=*' expand('<afile>') 'echo' string(expand('<afile>'))
augroup END
"FooBar
"" => FooBar


vnoremap ga :EasyAlign<Space>//<Left>
vnoremap g= :EasyAlign<Space>//<Left>
vnoremap A  :EasyAlign<Space>//<Left>



" onoremap ib iB
" onoremap ab aB

" onoremap ip ib
" onoremap ap ab

" onoremap iP ip
" onoremap aP ap

let NumWin = function('winnr',     ['$'])
let NumTab = function('tabpagenr', ['$'])



com! III normal! i" Path {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{<CR>" Path }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}<Esc>k0w


let g:EmAutoState = v:false



"com! -nargs=? CheckIncludes CommnadOutputCapture checkpath! | normal! /<args><CR>
com! -nargs=? CheckIncludes CommnadOutputCapture checkpath! | call feedkeys('/<args><CR>', 'n')
com! -nargs=? CheckPath CommnadOutputCapture checkpath! | call feedkeys('/<args><CR>', 'n')



" 正規表現 (肯|否)定(先|後)読み {{{
cnoremap <C-@>! \%()\@<!<Left><Left><Left><Left><Left>
cnoremap <C-@>@ \%()\@<=<Left><Left><Left><Left><Left>
cnoremap <C-@># \%()\@=<Left><Left><Left><Left>
cnoremap <C-@>$ \%()\@!<Left><Left><Left><Left>
" }}}


nnoremap <Leader>D :<C-u>e .<CR>



" Fold {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


nnoremap ]z :try <Bar> exe 'normal! ]z' <Bar> catch exe 'normal! zj' <Bar> endtry<CR>

com! ToggleFold if foldclosed(line('.')) != -1 | foldopen | else | foldclose | endif

" Fold }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



"nnoremap  r gr
"nnoremap gr r
"nnoremap  R gR
"nnoremap gR R


if 0
  set shellpipe=2>\&1\|iconv\ -f\ cp932\ -t\ utf-8\ -c>%s
  set shellpipe=2>\&1\|iconv\ -f\ cp932\ -t\ utf-8\ -c\ 2>\&1\|tee\ >%s
  set shellpipe=2>\&1\|iconv\ -f\ cp932\ -t\ utf-8\ -c\ 2>\&1\|tee
else
  "set shellpipe&
  set shellpipe=2>\&1\|tee
endif



cnoremap <C-r><C-t> <C-r><C-r>*
cnoremap <C-r><C-r> <C-r><C-r>*
inoremap <C-r><C-r> <C-r><C-r>*



" IME状態の切り替えをさせない。
inoremap <C-^> <Nop>


" Gdiffsplit
" :ReVimrc
" ":!git
" :e



" nmap alt 使用済み <A-
" f b o n p
" h j k l


"cnoremap <C-v><Space> <Space>



"nnoremap <Leader>t :<C-u>tabs<CR>:let g:tabbb = input('> ')<CR>:exe 'normal!' g:tabbb 'gt'<CR>
"nnoremap <Leader>t :<C-u>tabs<CR>:exe 'normal!' input('#Tab#> ', 21) 'gt'<CR>

function! s:select_tab()
  tabs

  if 0
    let num_tab = tabpagenr('$')
    if num_tab < 10
      echo '#Tab#> '
      let n = GetKey()
    else
      let n = input('#Tab#> ')
    endif
  else
    let n = input('#Tab#> ')
  endif

  if n =~# '\d\+'
   "exe 'normal!' n 'gt'
    exe n 'tabnext'
   "echo '^'.n.'$'
  endif
endfunction
nnoremap <Leader>t :<C-u>call <SID>select_tab()<CR>




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



if g:UseHHKB
  inoremap <Down>   <C-n>
  inoremap <Up>     <C-p>
  "cnoremap <Down>   <C-n>
  "cnoremap <Up>     <C-p>
endif



nnoremap gcc 0cc



" 折り畳みトグル
function! Toggle_folding()
  for i in range(1, line('$'))
    if foldclosed(i) != -1
      normal! zR
      "echo "folding open"
      return
    endif
  endfor
  normal! zM
  "echo "folding close"
  return
endfunction
nnoremap ZZ :<C-u>call Toggle_folding()<CR>


unmap *
unmap #

inoremap (( （
inoremap )) ）

function! Mdbar()
  let s = getline('.')
  let l = strdisplaywidth(s)
  exe 'normal! o' . repeat('-', l) . '<Esc>'
endfunction
com! Mdbar call MdBar()


so ~/vimfiles/unified_tab.vim
so ~/vimfiles/custome.vim

"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set encoding=utf-8
scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0 expandtab:
" (この行に関しては:help modelineを参照)


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



"---------------------------------------------------------------------------------------------
nnoremap <Leader><C-s>           :<C-u>g%<C-r>/%s    %%%g<Left><Left><Left>
vnoremap <Leader><C-s>                :g%<C-r>/%s     %%%g<Left><Left><Left>

nnoremap <Leader><C-s>           :<C-u>g!<C-r>/!<Space>
vnoremap <Leader><C-s>                :g!<C-r>/!<Space>


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

cnoremap <expr> <C-v><Space> '<' . 'Space' . '>'



"---------------------------------------------------------------------------------------------

" 無名バッファなら、pwd。そうでなければ、保存。
nnoremap <expr> <silent> <leader>w bufname() == '' ? ':<C-u>pwd<CR>' : ':<C-u>update<CR>'



"---------------------------------------------------------------------------------------------

cmap <expr> <CR> ( getcmdtype() == '/' ) ?
               \ ( '<Plug>(Search-SlashCR)' ) :
               \ ( getcmdtype() == ':' && getcmdline() =~# '^:*cd ') ?
               \ ( '<C-e><C-u>echo "cdは使用禁止。pw[d]かlc[d]を使用。"<CR>' ) :
               \ ( getcmdtype() == ':' && getcmdline() =~# '^:*lcd\? *$') ?
               \ ( '<C-e><C-u>echo "引数なしのlcdは使用禁止。pw[d]を使用。"<CR>' ) :
               \ ( '<CR>' )



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

nnoremap ' "






"---------------------------------------------------------------------------------------------
inoremap $$ ${}<LEFT>




"---------------------------------------------------------------------------------------------

" ^に、|の機能を付加
"nnoremap <silent> U <Esc>:exe v:prevcount ? ('normal! ' . v:prevcount . '<Bar>') : 'normal! ^'<CR>
"nnoremap <expr> <silent> U v:prevcount ? (v:prevcount . '<Bar>') : '^'
"nnoremap <expr> <silent> U v:prevcount ? (v:prevcount . '<Bar>') : search('^\s*\%#', 'bcn') ? '0' : '^'
"nnoremap <expr> <silent> U v:prevcount ? (v:prevcount . '<Bar>') : search('^\s\+\%#\S', 'bcn') ? '0' : '^'
nnoremap <expr> <silent> U v:prevcount ? (v:prevcount . '<Bar>') : search('^\s\+\%#\S\?', 'bcn') ? '0' : '^'
vnoremap <expr> <silent> U v:prevcount ? (v:prevcount . '<Bar>') : search('^\s\+\%#\S\?', 'bcn') ? '0' : '^'
"nnoremap <expr> <silent> U v:prevcount ? (v:prevcount . '<Bar>') : search('^\s\+\%#\(\S\|\s$\)', 'bcn') ? '0' : '^'
"vnoremap <expr> <silent> U v:prevcount ? (v:prevcount . '<Bar>') : '^'

"""  " ^に、|の機能を付加
"""  nnoremap <silent> ^ <Esc>:exe v:prevcount ? ('normal! ' . v:prevcount . '<Bar>') : 'normal! ^'<CR>
nnoremap <silent> U <Esc>:exe 'normal!' v:prevcount ? (v:prevcount . '<Bar>') : search('^\s\+\%#\S\?', 'bcn') ? '0' : '^' <CR>
vnoremap <silent> U <Esc>:exe 'normal!' v:prevcount ? (v:prevcount . '<Bar>') : search('^\s\+\%#\S\?', 'bcn') ? '0' : '^' <CR>
"onoremap <silent> U <Esc>:exe 'normal!' v:prevcount ? (v:prevcount . '<Bar>') : search('^\s\+\%#\S\?', 'bcn') ? '0' : '^' <CR>
onoremap <expr> <silent> U search('^\s\+\%#\S\?', 'bcn') ? '0' : '^'
"nnoremap <expr> <silent> U v:prevcount ? (v:prevcount . '<Bar>') : search('^\s\+\%#\S\?', 'bcn') ? '0' : '^' <CR>

"nnoremap U ^
"nnoremap : $
"vnoremap U ^
"vnoremap : $


" 補償
vnoremap gu u
vnoremap gU U


" 矯正
" nnoremap ^ <Nop>
" nnoremap $ <Nop>
" vnoremap ^ <Nop>
" vnoremap $ <Nop>



"---------------------------------------------------------------------------------------------

onoremap ia iW
onoremap aa aW
vnoremap ia iW
vnoremap aa aW



"---------------------------------------------------------------------------------------------

if 0
  nnoremap <silent> t <Esc>:exe 'normal!' v:prevcount ? (v:prevcount . '<Bar>') : search('^\s\+\%#\S\?', 'bcn') ? '0' : '^' <CR>
  vnoremap <silent> t <Esc>:exe 'normal!' v:prevcount ? (v:prevcount . '<Bar>') : search('^\s\+\%#\S\?', 'bcn') ? '0' : '^' <CR>

  nmap U *
  nnoremap T $
endif



"---------------------------------------------------------------------------------------------

nnoremap <Leader>6 ^y$/\C\V<C-r>=substitute(escape(@", '/\|\\'), '\s', '\\s\\+', 'g')<CR><CR>



"---------------------------------------------------------------------------------------------

iab LOOP while ( 1 ) {<CR>}


"---------------------------------------------------------------------------------------------

nmap ? *


"---------------------------------------------------------------------------------------------

com! KakkoZen s/(/（/g |  s/)/）/g


"---------------------------------------------------------------------------------------------

function! Find(arg)
  "echo a:arg
  "et f = a:arg

  let f = substitute(a:arg, ' ', '*', 'g')

  if a:arg !~ '^\^'
    let f = substitute(f, '^', '*', '')
  elseif a:arg !~ '^;'
    let f = substitute(f, '^;', '^', '')
  else
    let f = substitute(f, '^\^', '', '')
  endif

  if a:arg !~ '\$$'
    let f = substitute(f, '$', '*', '')
  elseif a:arg !~ ';$'
    let f = substitute(f, ';$', '$', '')
  else
    let f = substitute(f, '\$$', '', '')
  endif

  "exe 'find' f
  call feedkeys(':find '. f . "\<Tab>\<Tab>", 'nt')
endfunction

com! -bar -nargs=* Find call Find(<q-args>)
com! -bar -nargs=* F Find <args>


"---------------------------------------------------------------------------------------------

com! NoWrap PushPosAll | exe 'windo set nowrap' | PopPosAll




"---------------------------------------------------------------------------------------------

" 折り畳みトグル
function! Toggle_folding()
  normal! zi
  if &l:foldenable
    normal! zM
  endif
  return
endfunction
nnoremap zi :<C-u>call Toggle_folding()<CR>



"---------------------------------------------------------------------------------------------

com! MacStart normal! qq
com! MacEnd   normal! q

nnoremap ! q



"---------------------------------------------------------------------------------------------

nnoremap <Leader><C-s> :<C-u>wind %s/<C-r>//<C-r><C-w>/g<CR>:wind up<CR><C-w>t



"---------------------------------------------------------------------------------------------




"---------------------------------------------------------------------------------------------




"---------------------------------------------------------------------------------------------




"---------------------------------------------------------------------------------------------




"---------------------------------------------------------------------------------------------
