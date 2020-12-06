set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

map r :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    silent! exec "!clear"
    exec "!time python3 %"
  elseif &filetype == 'html'
    exec "!firefox % &"
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  elseif &filetype == 'vimwiki'
    exec "MarkdownPreview"
  endif
endfunc


"设置文件的代码形式 utf8
set encoding=utf-8
set termencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936

"vim的菜单乱码解决
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim


"vim提示信息乱码的解决
language messages zh_CN.utf-8

filetype on
filetype plugin indent on
"colorscheme evening    "配色方案
colorscheme desert
set helplang=cn        "设置中文帮助
set history=500        "保留历史记录
set tabstop=4        "设置tab的跳数
set expandtab
set backspace=2     "设置退格键可用
"set nu!         "设置显示行号
set wrap         "设置自动换行
"set nowrap         "设置不自动换行
set linebreak         "整词换行，与自动换行搭配使用
"set list         "显示制表符
set autochdir         "自动设置当前目录为正在编辑的目录
set hidden         "自动隐藏没有保存的缓冲区，切换buffer时不给出保存当前buffer的提示
set scrolloff=5     "在光标接近底端或顶端时，自动下滚或上滚
"Toggle Menu and Toolbar     "隐藏菜单栏和工具栏
"set guioptions-=m
"set guioptions-=T
set showtabline=2     "设置显是显示标签栏
set autoread         "设置当文件在外部被修改，自动更新该文件
set mouse=a         "设置在任何模式下鼠标都可用
set nobackup         "设置不生成备份文件
"set go=                "不要图形按钮
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
 
"===========================
"查找/替换相关的设置
"===========================
set hlsearch "高亮显示查找结果
set incsearch "增量查找
 
"===========================
"状态栏的设置
"===========================
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%] "显示文件名：总行数，总的字符数
set ruler "在编辑过程中，在右下角显示光标位置的状态行
 
"===========================
"代码设置
"===========================
syntax enable "打开语法高亮
syntax on "打开语法高亮
set showmatch "设置匹配模式，相当于括号匹配
set smartindent "智能对齐
"set shiftwidth=4 "换行时，交错使用4个空格
set autoindent "设置自动对齐
set ai! "设置自动缩进
"set cursorcolumn "启用光标列
set cursorline    "启用光标行
set guicursor+=a:blinkon0 "设置光标不闪烁
set fdm=indent "

"设置主题
filetype off
set shellslash
set rtp+=~/vimfiles/bundle/Vundle.vim
call vundle#begin('~/vimfiles/bundle')
"""""""""以后插件都添加到这里"""""""""""
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'kien/ctrlp.vim'
Plugin 'eshion/vim-sync'
Plugin 'vim-airline/vim-airline'
Plugin 'connorholyday/vim-snazzy'                  
"Plugin 'shd101wyy/markdown-preview-enhanced'
Plugin 'tpope/vim-sensible'
Plugin 'junegunn/seoul256.vim'
Plugin 'iamcco/mathjax-support-for-mkdp'

"markdown
Plugin 'iamcco/markdown-preview.vim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plugin'] }
Plugin 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plugin 'vimwiki/vimwiki'

"python 
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-python/python-syntax', { 'for' :['python', 'vim-plug'] }
Plugin 'ycm-core/YouCompleteMe'
""""""""""""""""""""""""""""""""""""""
call vundle#end()   


" === MarkdownPreview
" ===
let g:mkdp_path_to_chrome = ""
    " 设置 chrome 浏览器的路径（或是启动 chrome（或其他现代浏览器）的命令）
    " 如果设置了该参数, g:mkdp_browserfunc 将被忽略

let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
    " vim 回调函数, 参数为要打开的 url

let g:mkdp_auto_start = 0
    " 设置为 1 可以在打开 markdown 文件的时候自动打开浏览器预览，只在打开
    " markdown 文件的时候打开一次

let g:mkdp_auto_open = 0
    " 设置为 1 在编辑 markdown 的时候检查预览窗口是否已经打开，否则自动打开预
    " 览窗口

let g:mkdp_auto_close = 1
    " 在切换 buffer 的时候自动关闭预览窗口，设置为 0 则在切换 buffer 的时候不
    " 自动关闭预览窗口

let g:mkdp_refresh_slow = 0
    " 设置为 1 则只有在保存文件，或退出插入模式的时候更新预览，默认为 0，实时
    " 更新预览

let g:mkdp_command_for_global = 0
    " 设置为 1 则所有文件都可以使用 MarkdownPreview 进行预览，默认只有 markdown
    " 文件可以使用改命令

let g:mkdp_open_to_the_world = 0
    " 设置为 1, 在使用的网络中的其他计算机也能访问预览页面
    " 默认只监听本地（127.0.0.1），其他计算机不能访问' 
	
source ~/vimfiles/snippits.vim 

"
" === Python-syntax
" ===
let g:python_highlight_all = 1
let g:python_slow_sync = 0
let g:ycm_autoclose_preview_window_after_completion=1


" 关闭NERDTree快捷键
map <leader>t :NERDTreeToggle<CR>
" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 设置宽度
let NERDTreeWinSize=21
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 显示书签列表
let NERDTreeShowBookmarks=1

"设置主题
colorscheme snazzy
let g:SnazzyTransparent = 1
"设置字体为Monaco，大小18
set guifont=Consolas:h18



