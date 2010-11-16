" Windows compatibility
set runtimepath+=~/.vim
set viminfo+=n~/.viminfo

" Make vim behave in a more useful way (the default) than the vi-compatible manner
set nocompatible

" Pathogen is a simple library for manipulating comma delimited path options
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Enable 256-color terminal
set t_Co=256

" Make sure we use UTF-8 and Unix line-endings
set encoding=utf-8
set enc=utf-8
set ff=unix

set history=32  " keep ~500 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set showmode
set incsearch   " do incremental searching
set ignorecase
set smartcase
set showmatch

set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap
set autoindent

set nospell  " Turn off spell check by default

set scrolloff=3
set nu!    " Enable line numbers

set guioptions-=T  " Hide the top toolbar

set backup
set backupdir=$HOME/.vim/backup
set directory=$TEMP,.

let mapleader=","

nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>q gqip
nnoremap <leader>v V`]

" Toggle spell-checking
map <silent> <F1> :set nospell!<CR>:set nospell?<CR>

" EXPERIMENTAL
set wildmenu
set wildmode=list:longest,full
set visualbell
set ttyfast
set laststatus=2
set undofile
set undodir=$HOME/.vim/undo
set formatoptions=qrn1

nnoremap j gj
nnoremap k gk

if has('unix')
  let Tlist_Ctags_Cmd='/usr/bin/ctags'
  let Tlist_Inc_Winwidth=0
else
  let Tlist_Ctags_Cmd='c:\\bin\\tools\\ctags\\5.8\\ctags.exe'
  let Tlist_Inc_Winwidth=1
endif
let Tlist_Process_File_Always=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Auto_Highlight_Tag=1
let Tlist_Exit_OnlyWindow=1

nmap <silent> <F11> :TlistToggle<CR>
nmap <silent> <F12> :NERDTreeToggle<CR>

" For PHP code, enable some fancy options
let php_sql_query=1
let php_htmlInStrings=1

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors.
" Switch on highlighting the last used search pattern too.
if &t_Co > 2 || has("gui_running")
  syntax      on
  colorscheme vividchalk

  set hlsearch

  set guifont=Consolas:h13:cDEFAULT
  
  set guioptions-=t  " For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
  set guioptions+=b  " Enable the horizontal scrollbar

  au GUIEnter * simalt ~x  " Maximize on start-up
endif

" Mode-dependent cursor in MinTTY
if &term =~ "xterm\\|xterm-256color"
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

if has("autocmd")
  " Enable file type detection.
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END

  " Turn on auto-complete for supported file types
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType c set omnifunc=ccomplete#Complete

  " Turn off beep sounds
  autocmd VimEnter * set vb t_vb=
endif
