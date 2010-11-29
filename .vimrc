" Make vim behave in a more useful way (the default) than the vi-compatible manner
set nocompatible

set runtimepath+=~/.vim

" Pathogen is a simple library for manipulating comma delimited path options
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Windows compatibility
set viminfo+=n~/.viminfo

" Enable 256-color terminal
set t_Co=256

" Make sure we use UTF-8 and Unix line-endings
set encoding=utf-8
set fileformats=unix,mac,dos

set history=32  " keep ~500 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set showmode
set incsearch   " do incremental searching
set ignorecase
set smartcase

set backspace=indent,eol,start
set tabstop=2
set shiftwidth=2
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
set undofile
set undodir=$HOME/.vim/undo

let mapleader="\\"

set wildmenu
set wildmode=list:longest,full
set visualbell
set ttyfast
set laststatus=2
set formatoptions=qrn1

" For PHP code, enable some fancy options
let php_htmlInStrings=1

let Tlist_Process_File_Always=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Auto_Highlight_Tag=1
let Tlist_Exit_OnlyWindow=1

let tlist_php_settings='php;c:class;d:constant;f:function'

let Grep_Skip_Dirs = 'RCS CVS SCCS .git .svn'

if has('unix')
  let Tlist_Ctags_Cmd='/usr/bin/ctags'
  let Tlist_Inc_Winwidth=0
else
  let Tlist_Ctags_Cmd='c:\\bin\\tools\\ctags\\5.8\\ctags.exe'
  let Tlist_Inc_Winwidth=1

  let Grep_Path = 'c:\bin\cygwin\bin\grep.exe'
  let Fgrep_Path = 'c:\bin\cygwin\bin\fgrep.exe'
  let Egrep_Path = 'c:\bin\cygwin\bin\egrep.exe'
  let Agrep_Path = 'c:\bin\cygwin\bin\agrep.exe'
  let Grep_Find_Path = 'c:\bin\cygwin\bin\find.exe'
  let Grep_Xargs_Path = 'c:\bin\cygwin\bin\xargs.exe'
  let Grep_Cygwin_Find = 1
  let Grep_Shell_Escape_Char = '\'
  let Grep_Shell_Quote_Char = "'"
  let Grep_Null_Device = '/dev/null'

  let g:ackprg='c:\bin\cygwin\bin\perl.exe c:\bin\cygwin\usr\local\bin\ack -H --nocolor --nogroup --column'
endif

nmap j gj
nmap k gk

map  / /\v
nmap / /\v
vmap / /\v
nmap <leader><space> :noh<cr>

nmap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nmap <leader>q gqip
nmap <leader>v V`]

" Toggle spell-checking
map <silent> <F1> :set nospell!<CR>:set nospell?<CR>

nmap <silent> <F3>  :Grep<CR>

nmap <silent> <F11> :TlistToggle<CR>
nmap <silent> <F12> :NERDTreeToggle<CR>

" Tab handling and Firefox-like navigation
nmap <C-tab>   :tabnext<CR>
map  <C-tab>   :tabnext<CR>
nmap <C-S-tab> :tabprevious<CR>
map  <C-S-tab> :tabprevious<CR>

" Terminal handling of [Ctrl+][Shift+]Tab
nmap <Esc>[1;5I :tabnext<CR>
map  <Esc>[1;5I :tabnext<CR>
nmap <Esc>[1;6I :tabprevious<CR>
map  <Esc>[1;6I :tabprevious<CR>

nmap <leader>tn :tabnew<CR>
nmap <leader>tc :tabclose<CR>
nmap <leader>tm :tabmove

if has('unix')
  imap <leader>iu <C-R>=substitute(system('bash --norc -c "date +%s"'), '\n', '', 'g')<CR>
else
  imap <leader>iu <C-R>=substitute(system('c:\bin\cygwin\bin\bash.exe --norc -c "date +%s"'), '\n', '', 'g')<CR>
endif
            \
" Exit INSERT mode
imap jj <Esc>

" HARDCORE
imap  <Up>     <NOP>
imap  <Down>   <NOP>
imap  <Left>   <NOP>
imap  <Right>  <NOP>
map   <Up>     <NOP>
map   <Down>   <NOP>
map   <Left>   <NOP>
map   <Right>  <NOP>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors.
" Switch on highlighting the last used search pattern too.
if &t_Co > 2 || has("gui_running")
  syntax      on
  colorscheme zend55

  set hlsearch
  set cursorline! " Highlight line under cursor

  set guifont=Consolas:h13:cDEFAULT

  set guioptions-=t  " For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
  set guioptions+=b  " Enable the horizontal scrollbar

  set guioptions-=m  " Hide the menubar and use F10 to toggle it on/off
  nmap <F10> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

  au GUIEnter * simalt ~x  " Maximize on start-up
endif

" Mode-dependent cursor in MinTTY
if &term =~ "xterm\\|xterm-256color"
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

if has('autocmd')
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
