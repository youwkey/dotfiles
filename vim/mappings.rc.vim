"===========================================================
" Mapping Settings
"===========================================================
" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <ESC>
" 入力モード中に<CTRL>とhjklの組み合わせで移動
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>
" 検索のハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR>
" コマンド履歴検索
cnoremap <C-p> <up>
cnoremap <C-n> <down>
" ウィンドウのリサイズ
nnoremap <C-h> 10<C-w>>
nnoremap <C-l> 10<C-w><
nnoremap <C-k> 10<C-w>+
nnoremap <C-j> 10<C-w>-
" Terminalの設定
tnoremap <silent> <ESC> <C-\><C-n>
" 括弧の自動補完
inoremap { {}<ESC>i
inoremap {<Enter> {}<ESC>i<CR><ESC><S-o>
inoremap {} {}
inoremap ( ()<ESC>i
inoremap (<Enter> ()<ESC>i<CR><ESC><S-o>
inoremap () ()

nnoremap [CORE] <Nop>
nmap <CR> [CORE]

nnoremap <silent> [CORE]t :tabnew<CR>:terminal<CR>:startinsert<CR>
