" 定義快捷鍵的前綴，即<Leader>
let mapleader=";"

" pathogen plugin manager
execute pathogen#infect()
filetype plugin indent on

" 基本設定
set nocompatible
set backspace=indent,eol,start
set autoindent
set nobackup
set noswapfile
set number
set ruler
set showcmd
set incsearch
set expandtab
set wildmenu
set hlsearch
set ignorecase
set smartcase

" 編碼設定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" 基礎快捷鍵
nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>v :Vex<CR>

" 分割視窗快捷鍵
nnoremap <Leader>gg <C-W><C-W>
nnoremap <leader>h <C-W><C-H>
nnoremap <leader>l <C-W><C-L>
nnoremap <Leader>k <C-W><C-K>
nnoremap <Leader>j <C-W><C-J>

" NERDTree 設定
nnoremap <silent> <Leader>n :NERDTreeToggle <CR>
let NERDTreeWinPos="left"
let NERDTreeIgnore=['\.pyc$', '\~$', '\.o$', '\.d$', '\.out$']

" 語法高亮
syntax enable
syntax on

" 主題設定
colorscheme Monokai_Gavin

" Python 專用設定
autocmd FileType python set tabstop=4
autocmd FileType python set softtabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set textwidth=120
autocmd FileType python set expandtab
autocmd FileType python set autoindent
autocmd FileType python set fileformat=unix
autocmd FileType python set colorcolumn=120

" Python 語法檢查設定
let g:syntastic_python_checkers = ['pylint', 'flake8']
let g:syntastic_python_pylint_args = '--rcfile=~/.pylintrc'
let g:syntastic_python_flake8_args = '--max-line-length=120'

" Python 執行快捷鍵優化
autocmd FileType python nnoremap <buffer> <F1> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python inoremap <buffer> <F1> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" Python 文件模板
func SetPythonTitle()
    call setline(1, "\#!/usr/bin/env python3")
    call append(line("."), "\# -*- coding: utf-8 -*-")
    call append(line(".")+1, "\# Author: 程序員Carl")
    call append(line(".")+2, "\# Date: ".strftime("%Y-%m-%d"))
    call append(line(".")+3, "\# Description: ")
    call append(line(".")+4, "")
endfunc
autocmd BufNewFile *.py call SetPythonTitle()

" 自動補全設定
set completeopt=menu,menuone

" 重新打開文件時回到上次位置
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \ exe "normal g'\"" |
    \ endif
endif

" 括號配對高亮
set showmatch
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap ' ''<ESC>i
inoremap " ""<ESC>i

" 當前行高亮
set cursorline
autocmd InsertEnter * se cul

" Python 語法高亮增強
let python_highlight_all = 1
let g:syntastic_python_python_exec = 'python3'

" 自動縮排
autocmd FileType python set foldmethod=indent
autocmd FileType python set foldlevel=99

" 狀態列設定
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" 使用 vim-commentary 風格設定 Python 註釋
autocmd FileType python set commentstring=#\ %s

" 複製粘貼優化
vnoremap <C-c> :w! ~/tmp/clipboard.txt <CR>
inoremap <C-v> <Esc>:r ~/tmp/clipboard.txt <CR>

" Python 代碼片段
iabbrev pyif if:<left>
iabbrev pyfor for:<left>
iabbrev pyfun def ():<left><left><left>
iabbrev pyclass class :<left>

" 在文件開頭添加，禁用 Taglist
let loaded_taglist = 1  " 這會阻止 Taglist 插件加載
