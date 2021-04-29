"===========================================================
" Set Settings
"===========================================================
set number                                "行番号を表示する
set tabstop=4                             "タブ位置を４にする
set shiftwidth=4                          "オートインデントでずれる幅
set softtabstop=4                         "バックスペースで削除するスペース幅
set autoindent                            "オートインデントを使用する
set smartindent                           "スマートインデントを使用する
set expandtab                             "ソフトタブを有効にする
set showcmd                               "コマンドを画面最下部に表示する
set incsearch                             "インクリメンタルサーチ
set hlsearch                              "検索時に検索結果をハイライト
set termguicolors                         "TrueColorに設定
set cursorline                            "カーソル行をハイライト
set nowrap                                "文を折り返して表示しない
set helpheight=999                        "ヘルプ画面いっぱいに開く
set splitright                            "垂直分割の時は右に作成
set splitbelow                            "水平分割の時は下に作成
set laststatus=2                          "ステータスラインを２行に
set showtabline=1                         "複数の時にタブを表示
set ignorecase                            "検索時に大文字小文字を無視
set smartcase                             "検索時に大文字を入れた場合は大文字小文字を無視しない
set clipboard=unnamed                     "ヤンクでクリップボードにコピー
set background=dark                       "背景色を設定
set cmdheight=2                           "メッセージ表示欄を2行に
set signcolumn=yes                        "常にアイコン用のカラムを表示する
set wildmenu                              "ファイル補完時に選択肢を表示する
set hidden                                "保存されていないファイルがある場合でも別ファイルを開く
set backup                                "バックアップ機能を有効化
set backupdir=$XDG_CACHE_HOME/vim/backup  "バックアップディレクトリを指定
set undofile                              "Undoファイル機能を有効化
set undodir=$XDG_CACHE_HOME/vim/undo      "Undoディレクトリを指定
set backspace=indent,eol,start
