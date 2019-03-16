if !&compatible
  set nocompatible
endif

"------------------
"dein
"-----------------
let s:cache_home = expand('~/.vim')
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
let s:toml_file = s:dein_dir.'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#add('Shougo/dein.vim')
  call dein#add('arcticicestudio/nord-vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('scrooloose/nerdtree')
  call dein#end()
  call dein#save_state()
endif

" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif


"------------------
" basic
"------------------
set encoding=utf-8
scriptencoding utf-8         "vim script内のエンコーディング 以下日本語ok
syntax on                    "syntaxをおん
set noswapfile
set hidden                   "バッファを保存しなくても他のバッファを表示可
set confirm                  "バッファが変更されててもエラー吐かず確認
set wildmenu wildmode=list   "コマンドラインでtab補完 listで表示
set showcmd                  "入力中のコマンドを表示 右下に
set backspace=start,eol,indent  "backspaceの挙動
                                "start:既存の文字 eol:改行 indent:インデント
set nostartofline            "移動コマンドを使った時行頭に移動しない
set whichwrap+=h,l,<,>,[,],b,s " 行末・行頭から次の行へ移動可能に
set visualbell               "ビープの代わりにビジュアルベル
set t_vb=                    "そしてビジュアルベルも無効化する
set autoread                 "内容が変更されたら自動的に再読み込み
set mouse=a                  "全モードでマウスon（賛否両論） 
set backupskip=/tmp/*,/private/tmp/*  "cronのためにバックアップをしない

"------------------
" 見た目
"------------------
set ruler                    "画面最下行にルーラーを表示する
set number                   "行番号を表示
set cursorline               "カーソルのある行に線を表示
let g:hybrid_use_iTerm_colors = 1
colorscheme nord
set scrolloff=4              "上下4行の視界を確保
set laststatus=2             "ステータスラインを常に表示
set cmdheight=2              "コマンドラインの高さを2行に
"ステータスバーの設定
set statusline=%F%m%r%h%w%=\|%{&ff}/%Y\|\ \|line\ %l\/%L,\ col\ %c\|

"-----------------
" 検索
"-----------------
set hlsearch                 "検索結果をハイライト
set ignorecase               "大文字小文字を区別しないが
set smartcase                "混在した場合は区別する
set wrapscan                 "最後尾から先頭へ移動

"------------------
" インデント
"------------------
set autoindent               "オートインデント
set smartindent              "行の末尾に応じて次の行のインデントを増減
set tabstop=4                "画面上でタブ文字が閉める幅
set shiftwidth=4             "自動インデントでずれる幅
set softtabstop=2            "連続した空白に対してbsが消す幅
set expandtab                "タブ入力を連続した空白に

"------------------
"NERDTree
"------------------
"幅
let NERDTreeWinSize=20
" 隠しファイルを表示する
let NERDTreeShowHidden = 1
" minimalなUI
let g:NERDTreeMinimalUI = 1
noremap <silent><C-e> :NERDTreeToggle<CR>

"------------------
" マッピング
"------------------
noremap ; :
noremap : ;
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
" Yの動作をDやCと同じにする
map Y y$

"括弧を連続で入力すると括弧内にカーソルが移動（便利）
inoremap {} {}<LEFT>
inoremap [] []<LEFT>
inoremap () ()<LEFT>
inoremap "" ""<LEFT> 
inoremap '' ''<LEFT> 
inoremap <> <><LEFT>

" 行頭、行末移動
nnoremap <Space>h  ^
vnoremap <Space>h  ^
nnoremap <Space>l  $
vnoremap <Space>l  $
nnoremap <Space><LEFT>  ^
vnoremap <Space><LEFT>  ^
nnoremap <Space><RIGHT>  $
vnoremap <Space><RIGHT>  $

nnoremap <Space>/  *

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

noremap <DOWN> g<DOWN>
noremap <UP> g<UP>

nnoremap <C-DOWN> <C-w>j
nnoremap <C-UP> <C-w>k
nnoremap <C-RIGHT> <C-w>l
nnoremap <C-LEFT> <C-w>h

" Map <Esc> (redraw screen) to also turn off search highlighting until the
" next search
" <ESc>二回で検索後の強調表示を解除する
nnoremap <Esc><Esc> :nohl<CR><Esc>

" ファイル名と内容によってファイルタイプを判別し、ファイルタイププラグインを有効にする
filetype indent plugin on

