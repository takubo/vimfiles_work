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



" Substitute {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

nnoremap S               :<C-u>g$.$s    %%<Left>
nnoremap <C-s>           :<C-u>g$.$s    %<C-R>/%%g<Left><Left>
nnoremap gs              :<C-u>g$.$s    %<C-R><C-W>%%g<Left><Left>
"nnoremap gS              :<C-u>g$.$s    %<C-R><C-W>%<C-R><C-W>%g<Left><Left>
nnoremap gS              :<C-u>g$.$s    %<C-R>"%%g<Left><Left>
nnoremap <Leader>s           :<C-u>s    %%%g<Left><Left><Left>

vnoremap S                        :s    %%<Left>
vnoremap <C-s>                    :s    %<C-R>/%%g<Left><Left>
vnoremap gs                       :s    %<C-R>/%<C-R><C-W>%g
nnoremap gS                       :s    %<C-R>"%%g<Left><Left>

"cnoremap <expr> <C-g> match(getcmdline(), '\(g.\..s\\|s\)    /') == 0 ? '<End>/g' :
"                    \ match(getcmdline(), '\(g.\..s\\|s\)    %') == 0 ? '<End>/g' : ''

" Substitute }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Grep {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

set grepprg=$HOME/bin/ag\ --line-numbers
set grepprg=/usr/bin/grep\ -an
set grepprg=git\ grep\ --no-index\ -I\ --line-number

"========================================================

nnoremap !             :<C-u>grep ''<Left>
nnoremap <Leader>g     :<C-u>grep '<C-R>/'<CR>
nnoremap <silent> <C-g><C-g> :<C-u>grep '\<<C-R><C-W>\>'<CR>
nnoremap <silent> <C-g><C-g> :<C-u>grep '\<<C-R><C-W>\>' -- ':!.svn/' ':!tags'<CR>

"========================================================

let g:prj_root_file = '.git'

augroup MyVimrc_Grep
  au!
  exe "au WinEnter * if (&buftype == 'quickfix') | cd " . getcwd() . " | endif"
augroup end

function! CS(str)
  let save_autochdir = &autochdir
  set autochdir

  let pwd = getcwd()

  for i in range(7)
    if glob(g:prj_root_file) != ''  " prj_root_fileファイルの存在確認
      try
        if exists("*CS_Local")
          call CS_Local(a:str)
        else
          exe "silent grep! '" . a:str . "' **/*.c" . " **/*.h" . " **/*.s"
        endif
        call feedkeys("\<CR>:\<Esc>\<C-o>", "tn")  " 見つかった最初へ移動させない。
      finally
      endtry
      break
    endif
    cd ..
  endfor

  exe 'cd ' . pwd
  exe 'set ' . save_autochdir
endfunction

com! CS call CS("\<C-r>\<C-w>")

"nnoremap          <leader>g     :<C-u>call CS("\\<<C-r><C-w>\\>")<CR>
"nnoremap <silent> <C-g>         :<C-u>call CS("\\<<C-r><C-w>\\>")<CR>
"nnoremap          <leader>G     :<C-u>call CS("<C-r><C-w>")<CR>
"nnoremap          <leader><C-g> :<C-u>call CS('')<Left><Left>
"nnoremap <silent> <C-g>         :<C-u>call CS("\\b<C-r><C-w>\\b")<CR>
"nnoremap <silent> <leader>g     :<C-u>call CS("\\b<C-r><C-w>\\b")<CR>
"nnoremap          <leader>g     :<C-u>call CS('')<Left><Left>

"========================================================

nnoremap <Leader>g :<C-u>vim "\<<C-r><C-w>\>" *.c<CR>

" Grep }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



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



" " Window {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

set noequalalways


"----------------------------------------------------------------------------------------
" Window Ratio
"
"   正方形 w:h = 178:78
"   横長なほど、大きい値が返る。
function! s:WindowRatio()
  let h = winheight(0) + 0.0
  let w = winwidth(0) + 0.0
  return (w / h - 178.0 / 78.0)
endfunction


"----------------------------------------------------------------------------------------
" Trigger

nmap <BS> <C-w>


"----------------------------------------------------------------------------------------
" Split & New

" Auto Split
nnoremap <silent> <expr> <Plug>(MyVimrc-Window-AutoSplit)     ( <SID>WindowRatio() >= 0 ? "\<C-w>v" : "\<C-w>s" ) . ':diffoff<CR>'
nnoremap <silent> <expr> <Plug>(MyVimrc-Window-AutoSplit-Rev) ( <SID>WindowRatio() <  0 ? "\<C-w>v" : "\<C-w>s" ) . ':diffoff<CR>'

nmap <BS><BS>         <Plug>(MyVimrc-Window-AutoSplit)
nmap <Leader><Leader> <Plug>(MyVimrc-Window-AutoSplit-Rev)

" Tag, Jump, and Unified CR を参照。

" Manual
nnoremap <silent> _                <C-w>s:setl noscrollbind<CR>
nnoremap <silent> g_               <C-w>n
nnoremap <silent> U                :<C-u>new<CR>
nnoremap <silent> <Bar>            <C-w>v:setl noscrollbind<CR>
nnoremap <silent> g<Bar>           :<C-u>vnew<CR>

" Auto New
nnoremap <silent> <expr> <Plug>(MyVimrc-Window-AutoNew) ( winwidth(0) > (&columns * 7 / 10) && <SID>WindowRatio() >=  0 ) ? ':<C-u>vnew<CR>' : '<C-w>n'


"----------------------------------------------------------------------------------------
" Close

" TODO NERDTreeも閉じられるようにする。
nnoremap <silent> q         <C-w><C-c>
nnoremap <silent> <Leader>q :<C-u>q<CR>

" 補償
nnoremap <C-q>  q
nnoremap <C-q>: q:
nnoremap <C-q>; q:
nnoremap <C-q>/ q/
nnoremap <C-q>? q?

" ウィンドウレイアウトを崩さないでバッファを閉じる   (http://nanasi.jp/articles/vim/kwbd_vim.html)
com! CloseWindow let s:kwbd_bn = bufnr('%') | enew | exe 'bdel '. s:kwbd_bn | unlet s:kwbd_bn

"----------------------------------------------------------------------------------------
" Focus

" Basic
nmap t <Plug>(Window-Focus-SkipTerm-Inc)
nmap T <Plug>(Window-Focus-SkipTerm-Dec)
" Unified_Spaceを参照。

" Direction Focus
nmap H <Plug>(Window-Focus-WrapMove-h)
nmap J <Plug>(Window-Focus-WrapMove-j)
nmap K <Plug>(Window-Focus-WrapMove-k)
nmap L <Plug>(Window-Focus-WrapMove-l)

" 補償
nnoremap gM M
nnoremap gH H
nnoremap gL L
if 1
  noremap m   J
  noremap gm gJ
else
  noremap M   J
  noremap gM gJ
endif

" Direction Focus (Terminal)
tnoremap <S-Left>  <C-w>h
tnoremap <S-Down>  <C-w>j
tnoremap <S-Up>    <C-w>k
tnoremap <S-Right> <C-w>l

" Terminal Windowから抜ける。 (Windowが１つしかないなら、Tabを抜ける。)
tnoremap <expr> <C-Tab> winnr('$') == 1 ? '<C-w>:tabNext<CR>' : '<C-w>p'


"----------------------------------------------------------------------------------------
" Resize

" 漸次
nnoremap <silent> <C-h> <Esc><C-w>+:call <SID>best_scrolloff()<CR>
nnoremap <silent> <C-l> <Esc><C-w>-:call <SID>best_scrolloff()<CR>
nnoremap <silent> <S-BS> <Esc><C-w>+:call <SID>best_scrolloff()<CR>
nnoremap <silent> <C-BS> <Esc><C-w>-:call <SID>best_scrolloff()<CR>
nnoremap <silent> (     <Esc><C-w>3<
nnoremap <silent> )     <Esc><C-w>3>

tnoremap <silent> <C-up>    <C-w>+:call <SID>best_scrolloff()<CR>
tnoremap <silent> <C-down>  <C-w>-:call <SID>best_scrolloff()<CR>
tnoremap <silent> <C-left>  <C-w><
tnoremap <silent> <C-right> <C-w>>

" 補償
nnoremap <silent> <A-o> <C-l>

" 最小化・最大化
"nnoremap <silent> g<C-j> <esc><C-w>_:call <SID>best_scrolloff()<CR>
"nnoremap <silent> g<C-k> <esc>1<C-w>_:call <SID>best_scrolloff()<CR>
"nnoremap <silent> g<C-h> <esc>1<C-w>|
"nnoremap <silent> g<C-l> <esc><C-w>|

nmap @ <Plug>(Window-Resize-EqualOnlyWidth)
nmap g@ <Plug>(Window-Resize-EqualOnlyHeight)

nmap <Leader><Leader> <Plug>(Window-Resize-OptimalWidth)

" Submode
call submode#enter_with('WinSize', 'n', 's', '<C-w>+', '<C-w>+:call BestScrolloff()<CR>')
call submode#enter_with('WinSize', 'n', 's', '<C-w>-', '<C-w>-:call BestScrolloff()<CR>')
call submode#enter_with('WinSize', 'n', 's', '<C-w>>', '<C-w>>')
call submode#enter_with('WinSize', 'n', 's', '<C-w><', '<C-w><')
call submode#map(       'WinSize', 'n', 's', '+', '<C-w>+:call BestScrolloff()<CR>')
call submode#map(       'WinSize', 'n', 's', '=', '<C-w>+:call BestScrolloff()<CR>') " Typo対策
call submode#map(       'WinSize', 'n', 's', '-', '<C-w>-:call BestScrolloff()<CR>')
call submode#map(       'WinSize', 'n', 's', '>', '<C-w>>')
call submode#map(       'WinSize', 'n', 's', '<', '<C-w><')
if 1
  call submode#enter_with('WinSize', 'n', 's', '<C-w>h', '<C-w><')
  call submode#enter_with('WinSize', 'n', 's', '<C-w>j', '<C-w>+:call BestScrolloff()<CR>')
  call submode#enter_with('WinSize', 'n', 's', '<C-w>k', '<C-w>-:call BestScrolloff()<CR>')
  call submode#enter_with('WinSize', 'n', 's', '<C-w>l', '<C-w>>')
endif
if 0
  call submode#map(       'WinSize', 'n', 's', 'h', '<C-w>h')
  call submode#map(       'WinSize', 'n', 's', 'j', '<C-w>j')
  call submode#map(       'WinSize', 'n', 's', 'k', '<C-w>k')
  call submode#map(       'WinSize', 'n', 's', 'l', '<C-w>l')
else
  call submode#map(       'WinSize', 'n', 's', 'h', '<C-w><')
  call submode#map(       'WinSize', 'n', 's', 'j', '<C-w>+:call BestScrolloff()<CR>')
  call submode#map(       'WinSize', 'n', 's', 'k', '<C-w>-:call BestScrolloff()<CR>')
  call submode#map(       'WinSize', 'n', 's', 'l', '<C-w>>')
endif


"----------------------------------------------------------------------------------------
" Window Move

nnoremap <silent> <A-h> <C-w>H:call <SID>best_scrolloff()<CR>
nnoremap <silent> <A-j> <C-w>J:call <SID>best_scrolloff()<CR>
nnoremap <silent> <A-k> <C-w>K:call <SID>best_scrolloff()<CR>
nnoremap <silent> <A-l> <C-w>L:call <SID>best_scrolloff()<CR>

tnoremap <silent> <A-left>  <C-w>H:call <SID>best_scrolloff()<CR>
tnoremap <silent> <A-down>  <C-w>J:call <SID>best_scrolloff()<CR>
tnoremap <silent> <A-up>    <C-w>K:call <SID>best_scrolloff()<CR>
tnoremap <silent> <A-right> <C-w>L:call <SID>best_scrolloff()<CR>


"----------------------------------------------------------------------------------------
" Reopen as Tab
" TODO diffのバッファも再現する。

nnoremap <C-w><C-w> :<C-u>tab split<CR>
nnoremap <C-w><C-t> <C-w>T

tnoremap <C-w><C-t> <C-w>T


"----------------------------------------------------------------------------------------
" Plug WinCmd

nnoremap <Plug>(MyVimrc-WinCmd-p) <C-w>p


" Window }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



" Terminal {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

function! OpenTerm_Sub(key, val)
  if bufwinnr(a:val) < 0
    return 9999
  endif
  if bufwinnr(v:val) >= winnr()
    let ret = bufwinnr(a:val) - winnr()
  else
    let ret = winnr('$') - winnr() + bufwinnr(a:val)
  endif
  return ret
endfunction

function! OpenTerm()
  let terms = term_list()
  "echo terms
  call map(terms, function('OpenTerm_Sub'))
  "echo terms
  let minval = min(terms)
  "echo minval
  if minval != 0 && minval != 9999
    exe (minval + winnr() - 1) % (winnr('$')) + 1 . ' wincmd w'
  else
    terminal
    exe "normal! \<C-w>p"
  endif
endfunction

"nnoremap <silent> gt         :<C-u>call OpenTerm()<CR>
"nnoremap <silent> gT         :terminal<CR>
"nnoremap <silent> <Leader>gt :vsplit<CR>:terminal ++curwin<CR>

"nnoremap <C-d> :<C-u>terminal<CR><C-w>p
nnoremap <C-d> :<C-u>call OpenTerm()<CR>

tnoremap <C-w>; <C-w>:
tnoremap <Esc><Esc> <C-w>N
tnoremap <S-Ins> <C-w>"*
"tnoremap <C-l> <C-l>
"tnoremap <expr> <S-Del> '<C-w>:call term_sendkeys(bufnr(""), "cd " . expand("#" . winbufnr(1) . ":h"))<CR>'
tnoremap <expr> <S-Del> 'cd ' . expand('#' . winbufnr(1) . ':p:h')

for k in split('0123456789abcdefghijklmnopqrstuvwxyz', '\zs')
  exec 'tnoremap <A-' . k . '> <Esc>' . k
endfor

nmap <expr> o &buftype == 'terminal' ? 'i' : 'o'

" Terminal }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



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



" Statusline {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


"----------------------------------------------------------------------------------------
" Battery (Battery.vimが存在しない場合に備えて。)
let g:BatteryInfo = '? ---% [--:--:--]'


"----------------------------------------------------------------------------------------
" Alt Statusline

function! s:SetStatusline(stl, local, time)
  " 旧タイマの削除
  if a:time > 0 && exists('s:TimerUsl') | call timer_stop(s:TimerUsl) | unlet s:TimerUsl | endif

  " Local Statusline の保存。および、WinLeaveイベントの設定。
  if a:local == 'l'
    let w:stl = getwinvar(winnr(), 'stl', &l:stl)
    augroup MyVimrc_Restore_LocalStl
      au!
      au WinLeave * if exists('w:stl') | let &l:stl = w:stl | unlet w:stl | endif
      au WinLeave * au! MyVimrc_Restore_LocalStl
    augroup end
  else
    let save_cur_win = winnr()
    windo let w:stl = getwinvar(winnr(), 'stl', &l:stl)
    silent exe save_cur_win . 'wincmd w'
    augroup MyVimrc_Restore_LocalStl
      au!
    augroup end
  endif

  " Statusline の設定
  exe 'set' . a:local . ' stl=' . substitute(a:stl, ' ', '\\ ', 'g')

  " タイマスタート
  if a:time > 0 | let s:TimerUsl = timer_start(a:time, 'RestoreDefaultStatusline', {'repeat': v:false}) | endif
endfunction

function! RestoreDefaultStatusline(force)
  " AltStlになっていないときは、強制フラグが立っていない限りDefaultへ戻さない。
  if !exists('s:TimerUsl') && !a:force | return | endif

  " 旧タイマの削除
  if exists('s:TimerUsl') | call timer_stop(s:TimerUsl) | unlet s:TimerUsl | endif

  " TODO これの呼び出し意図確認
  call s:SetStatusline(s:stl, '', -1)

  let save_cur_win = winnr()

  " Localしか設定してないときは、全WindowのStlを再設定するより、if existsの方が速いか？
  "windo let &l:stl = getwinvar(winnr(), 'stl', '')
  windo if exists('w:stl') | let &l:stl = w:stl | unlet w:stl | endif

  silent exe save_cur_win . 'wincmd w'
endfunction

augroup MyVimrc_Stl
  au!
  " このイベントがないと、AltStlが設定されているWindowを分割して作ったWindowの&l:stlに、
  " 分割元WindowのAltStlの内容が設定されっぱなしになってしまう。
  au WinEnter * let &l:stl = ''
augroup end


"----------------------------------------------------------------------------------------
" Make Default Statusline

function! s:SetDefaultStatusline(statusline_contents)

  let s:stl = "  "
  let s:stl .= "%#SLFileName#[ %{winnr()} ]%## ( %n ) "
  let s:stl .= "%##%m%r%{(!&autoread&&!&l:autoread)?'[AR]':''}%h%w "

  let g:MyStlFugitive = a:statusline_contents['Branch'] ? ' [fugitive]' : ' fugitive'
  let s:stl .= "%#hl_func_name_stl#%{bufname('') =~ '^fugitive' ? g:MyStlFugitive : ''}"
  let s:stl .= "%#hl_func_name_stl#%{&filetype == 'fugitive' ? g:MyStlFugitive : ''}"

  if a:statusline_contents['Branch']
    let s:stl .= "%#hl_func_name_stl# %{FugitiveHead(7)}"
  endif

  if a:statusline_contents['Path']
    let s:stl .= "%<"
    let s:stl .= "%##%#SLFileName# %F "
  else
    let s:stl .= "%##%#SLFileName# %t "
    let s:stl .= "%<"
  endif

  if a:statusline_contents['FuncName']
    let s:stl .= "%#hl_func_name_stl# %{cfi#format('%s()', '')}"
  endif


  " ===== Separate Left Right =====
  let s:stl .= "%#SLFileName#%="
  " ===== Separate Left Right =====

  if a:statusline_contents['Keywords']
   "let s:stl .= " %1{stridx(&isk,'.')<0?' ':'.'} %1{stridx(&isk,'_')<0?' ':'_'} "
   "let s:stl .= " %{&isk} "
   "let s:stl .= " %{substitute(substitute(&isk, '\\\\d\\\\+-\\\\d\\\\+', '', 'g'), ',,\\\\+', ',', 'g')} "
    let s:stl .= " %{substitute(substitute(&isk, '\\\\d\\\\+-\\\\d\\\\+', '', 'g'), ',\\\\+', ' ', 'g')} "
  endif

  let s:stl .= "%## %-4{&ft==''?'    ':&ft}  %-5{&fenc==''?'     ':&fenc}  %4{&ff} "

  let s:stl .= "%#SLFileName# %{&l:scrollbind?'$':'@'} "
  let s:stl .= "%1{c_jk_local!=0?'L':'G'} %1{&l:wrap?'==':'>>'} %{g:clever_f_use_migemo?'(M)':'(F)'} %4{&iminsert?'Jpn':'Code'} "

  let s:stl .= "%#SLFileName#  %{repeat(' ',winwidth(0)-178)}"

  let s:stl .= "%## %3p%% [%4L] "

  if a:statusline_contents['LineColumn']
    let s:stl .= "%## %4lL, %3v(%3c)C "
  elseif a:statusline_contents['Column']
    let s:stl .= "%## %3v,%3c "
  endif

  if a:statusline_contents['TabStop']
    let s:stl .= "%## %{&l:tabstop} "
  endif

  call RestoreDefaultStatusline(v:true)
endfunction


"----------------------------------------------------------------------------------------
" Switch Statusline Contents

let g:StatuslineContents = {}

let g:StatuslineContents['Column'] = v:false
let g:StatuslineContents['Branch'] = v:false
let g:StatuslineContents['FuncName'] = v:false
let g:StatuslineContents['Keywords'] = v:false
let g:StatuslineContents['LineColumn'] = v:false
let g:StatuslineContents['Path'] = v:false
let g:StatuslineContents['TabStop'] = v:false

function! CompletionStlContents(ArgLead, CmdLine, CusorPos)
  return join(keys(g:StatuslineContents),"\n")
endfunction
com! -nargs=1 -complete=custom,CompletionStlContents Stl let g:StatuslineContents['<args>'] = !g:StatuslineContents['<args>'] | call <SID>SetDefaultStatusline(g:StatuslineContents)

nnoremap <silent> <Leader>_ :<C-u>Stl Column<CR>
nnoremap <silent> <Leader>. :<C-u>Stl Branch<CR>
nnoremap <silent> <Leader>, :<C-u>Stl FuncName<CR>
nnoremap <silent> <Leader>- :<C-u>Stl Path<CR>


"----------------------------------------------------------------------------------------
" Initialize Statusline

" 初期設定のために1回は呼び出す。
call s:SetDefaultStatusline(g:StatuslineContents)


"----------------------------------------------------------------------------------------
" Alt-Statusline API

function! SetAltStatusline(stl, local, time)
  call s:SetStatusline(a:stl, a:local, a:time)
endfunction

function! AddAltStatusline(stl, local, time)
  call s:SetStatusline((a:local == 'l' ? &l:stl : &stl) . a:stl, a:local, a:time)
endfunction


" Statusline }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



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



" Completion, jj(gg)-inseert-leave, CR Hook, & Autosave {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{


" -----------------------------------------------------------------------------
" Options

set complete=.,w,b,u,i,t
set completeopt=menuone
set pumheight=25


" -----------------------------------------------------------------------------
" キーへの補完開始トリガの割り当て

function! SetCpmplKey(str)
  for k in split(a:str, '\zs')
    exec "inoremap <expr> " . k . " pumvisible() ? '" . k . "' : search('\\k\\{1\\}\\%#', 'bcn') ? TriggerCompleteDefault('" . k . "')" . " : '" . k . "'"
  endfor
endfunction

" 全文字キーへの補完開始トリガの割り当て
call SetCpmplKey('_0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')
"call SetCpmplKey('ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴヵヶヷヸヹヺー')

" BSキーへの補完開始トリガの割り当て
"inoremap <expr> <BS> pumvisible() ? (search('\k\k\k\k\%#', 'bcn') ? '<BS>' : "\<BS>") : (search('\k\k\k\%#', 'bcn') ? TriggerCompleteDefault("\<BS>") : "\<BS>")
inoremap <expr> <BS> pumvisible() ? "\<BS>" : (search('\k\k\k\%#', 'bcn') ? TriggerCompleteDefault("\<BS>") : "\<BS>")


" -----------------------------------------------------------------------------
" Configuration

" キーワード補完か、オムニ補完かを選ぶ。
let s:CompleteKey = "\<C-n>"


" -----------------------------------------------------------------------------

" 補完を開始する
function! TriggerCompleteDefault(insert_key)
  return TriggerComplete(s:CompleteKey, a:insert_key, 'x')
endfunc

" 初期化しておく必要あり。
let s:compl_kind = 'w'

function! TriggerComplete(start_key, insert_key, kind)
  let s:compl_kind = a:kind
  try
    iunmap jj
    call s:imap_gg()
  catch
  finally
  endtry
  return a:start_key . "\<C-p>" . a:insert_key
endfunc

" 補完中のj,kキーの処理を行う
function! Complete_jk(key)
  try
    iunmap jj
    call s:imap_gg()
  catch
  finally
  endtry
  return a:key
endfunction

function! s:imap_gg()
  "imap gg <Plug>(Completion-Yes-And-InsertLeave)
  imap <expr> gg pumvisible() ? '<Plug>(Completion-Yes-And-InsertLeave)' : '<Plug>(InsertLeave)'
endfunction

inoremap <Plug>(Completion-Yes) <C-y>
inoremap <Plug>(I-Esc)          <Esc>

inoremap <expr> <Plug>(InsertLeavePre)  InsertLeavePre_Hook()

" ここはnnoremapでなければならない。
" nnoremap <Plug>(InsertLeavePost) l:w<CR>
nnoremap <expr> <Plug>(InsertLeavePost) InsertLeavePost_Hook()

imap <Plug>(InsertLeave)                    <Plug>(InsertLeavePre)<Plug>(I-Esc)<Plug>(InsertLeavePost)
imap <Plug>(Completion-Yes-And-InsertLeave) <Plug>(Completion-Yes)<Plug>(InsertLeave)

" 候補選択
inoremap <expr> j pumvisible() ? Complete_jk("\<C-n>") : TriggerCompleteDefault('j')
inoremap <expr> k pumvisible() ? Complete_jk("\<C-p>") : TriggerCompleteDefault('k')

" 日本語入力時用 + 強制補完開始
inoremap <expr> <C-j> pumvisible() ? Complete_jk("\<C-n>") : TriggerCompleteDefault('')
inoremap <expr> <C-k> pumvisible() ? Complete_jk("\<C-p>") : TriggerCompleteDefault('')

" 日本語入力時の補完確定
"?imap <expr> <C-g> pumvisible() ? '<Plug>(Completion-Yes-And-InsertLeave)' : '<Plug>(InsertLeave)'

" いわゆる全角Ｊ
inoremap <buffer><expr> ｊ pumvisible() ? '<C-n>' : 'j'
" いわゆる全角ｋ
inoremap <buffer><expr> ｋ pumvisible() ? '<C-p>' : 'k'
"inoremap <buffer><expr> <C-j> pumvisible() ? '<C-n>' : '<C-j>'
"inoremap <buffer><expr> <C-k> pumvisible() ? '<C-p>' : '<C-k>'

"? inoremap <expr>   ｊｊ pumvisible() ? '<C-N><C-N>' : '<Esc>:w<CR>'
inoremap <expr>   ｇｇ pumvisible() ? '<C-N><C-N>' : '<Esc>:w<CR>'
"inoremap <expr>     ｊ pumvisible() ? '<C-N><C-N>' : '<Esc>:w<CR>'
"inoremap <expr>   っｊ pumvisible() ? '<C-N><C-N>' : '<Esc>:w<CR>'
"inoremap <silent> っj  <ESC>
"inoremap <expr>   っｇ pumvisible() ? '<C-N><C-N>' : '<Esc>:w<CR>'
"inoremap <silent> っｇ <ESC>

" ファイル名補完
"?inoremap <expr> <C-l>                                         TriggerComplete('<C-x><C-f>', '', 'f')
"?inoremap <expr> <C-l> "\<C-o>:cd " . GetPrjRoot() . "\<CR>" . TriggerComplete('<C-x><C-f>', '', 'f')

" 短縮入力を展開 & Hook発動 & 行ごとにUndo & 改行
inoremap <expr> <CR>  pumvisible() ? '<C-y>' : '<C-]>' . NewLine_Hook() . '<C-G>u' . '<CR>'
inoremap <expr> <Esc> pumvisible() ? '<C-e>' : '<Esc>l'

augroup MyVimrc_Completion
  au!

  au CompleteDone * if v:completed_item != {} | call s:EraceDouplicatedChar() | endif

  au InsertEnter,CompleteDone * imap jj <Plug>(InsertLeave)
  au InsertEnter let s:erace_num = 0

  " Insert Mode を<C-c>で抜けたとき用に、InsertEnterでも無効化する。
  au InsertEnter,CompleteDone * try | iunmap gg | catch | finally
augroup end


" -----------------------------------------------------------------------------
" 補完よってできた重複部分を消す。

function! s:EraceDouplicatedChar()
  " TODO メタ文字 兼 キーワードのエスケープ 要る？
  if search('\%#\k\+', 'cnz')

    let left_word = v:completed_item['word']
    let cursor_word = expand(s:compl_kind == 'f' ? '<cfile>' : '<cword>')
    let right_word = substitute(cursor_word, '^\V' . left_word, '', 'g')

    " 中間補完のとき、カーソルが補完位置に留まるように、補完で挿入された文字を消す。
    if len(right_word) > 1
      " 念のため
      let left_left_word = substitute(left_word, '\V' . right_word . '\$', '', 'g')

      let erace_char_num = len(left_word) - len(left_left_word)

      " Delじゃなく、BS + Rightにしておかないと、ドットリピート時に意図しないことになる。
      " つまり、消すべきは、元の文字ではなく、補完で挿入された方のも文字でなければならない。
      "   例: 下記で、DefをXyzに変える場合。
      "       Abc_Def_ghi0
      "       Abc_Def_ghi1
      call feedkeys(repeat("\<BS>", erace_char_num) . repeat("\<Right>", erace_char_num), 'ni')
    endif
  endif
  return ''
endfunction
"com! CCC echo s:left_word s:compl_word s:cursor_word s:right_word s:left_left_word s:erace_num | "s:key


" -----------------------------------------------------------------------------
" Hooks

function! NewLine_Hook()
  " TODO semicolon
  return InsertLast()
  return ''
endfunction

function! InsertLeavePre_Hook()
  " TODO semicolon
  return InsertLast()
  return ''
endfunction


function! InsertLeavePost_Hook()
 "return "l:w\<CR>"
 "return repeat('h', s:erace_num) . "l:w\<CR>"
 "return repeat('h', s:erace_num) . "l:update\<CR>"
 "return repeat('h', s:erace_num) . 'l' . (bufname('')=='' ? '' : ":update\<CR>")
 "return repeat('h', s:erace_char_num) . 'l' . ":update\<CR>"
 "return repeat('h', s:erace_num) . 'l' . ':update<CR>'
  return 'l' . ":update\<CR>"
endfunction





" -----------------------------------------------------------------------------
  " TODO semicolon

function! InsertLast()
  if &ft == 'c' || &ft == 'cpp'
    " enumなどの中なら、セミコロンではなく、カンマとする。
    return Semicolon_plus()
  else
    return ''
  endif
endfunction

function! Semicolon_plus()
  return ''
endfunction


" Completion }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



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

  set grepprg=git\ grep\ -I\ --line-number

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
" Window {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Terminal {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Buffer {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Tab {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Tabline {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Statusline {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Battery {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Unified_Space {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Mru {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Completion {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
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
" Statusline {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Battery {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Window {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Terminal {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Buffer {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Tab {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Search {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Grep {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Quickfix & Locationlist {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Substitute {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" Diff {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

" Completion {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
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



" Window Temp {{{{{{{{{{{{{{{{{{{{{{{


" Submode Window Size {{{

if 0
  call submode#enter_with('WinSize', 'n', '', '<Space>l', '<C-w>>')
  call submode#enter_with('WinSize', 'n', '', '<Space>h', '<C-w><')
  call submode#enter_with('WinSize', 'n', '', '<Space>j', '<C-w>+')
  call submode#enter_with('WinSize', 'n', '', '<Space>k', '<C-w>-')
  call submode#map(       'WinSize', 'n', '', 'l', '<C-w>>')
  call submode#map(       'WinSize', 'n', '', 'h', '<C-w><')
  call submode#map(       'WinSize', 'n', '', 'j', '<C-w>+')
  call submode#map(       'WinSize', 'n', '', 'k', '<C-w>-')

  let g:submode_timeoutlen = 5000
endif

let g:submode_timeoutlen = 5000

" Submode Window Size }}}


" Window Wrap Focus 補償 {{{

"noremap zh H
"noremap zl L
"noremap zm M
"noremap zk H
"noremap zj L

"nnoremap <C-h> H
"nnoremap <C-l> L
"nnoremap <C-j> M


nnoremap M <C-w>n
nmap U *
nmap M <Plug>(MyVimrc-Window-AutoNew)


" Window Wrap Focus 補償 }}}



" Window Temp }}}}}}}}}}}}}}}}}}}}}}}



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
