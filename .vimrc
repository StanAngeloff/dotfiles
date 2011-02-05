" Make Vim behave in a more useful way (the default) than the vi-compatible manner
set nocompatible

" Windows compatibility (default is vimfiles)
set runtimepath+=~/.vim

" Pathogen for managing plug-in bundles
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Windows compatibility (default is _viminfo)
set viminfo+=n~/.viminfo

" Enable 256-color terminal
set t_Co=256

" Make sure we use UTF-8 and Unix line-endings for new files
set encoding=utf-8
set fileformats=unix,mac,dos

set history=1024
set undolevels=2048
set hidden         " Don't dispose buffers, hide them

set ruler          " Show the cursor position all the time
set showcmd        " Display incomplete commands
set showmode
set incsearch      " Do incremental searching
set ignorecase
set smartcase

set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap
set autoindent
set clipboard+=unnamed

set nospell        " Turn off spell checking by default

set scrolloff=3
set nu!            " Enable line numbers

set ttyfast
set lazyredraw     " Do not redraw while running macros (much faster)

set wildmenu
set wildmode=list:longest,full
set visualbell
set laststatus=2
set formatoptions=qrn1

set guioptions=grL " Grey menu items, RHS scrollbar and LHS if split

set colorcolumn=78

" Keep backups of files in case we mess up
set backup
set backupdir=$HOME/.vim/backup
set directory=$TEMP,.
" Keep undo files for cross-session edits
set undofile
set undodir=$HOME/.vim/undo

let mapleader="\\"

" Session Handling
set sessionoptions=blank,buffers,curdir,folds,tabpages,slash,unix

let g:session_autosave=0
let g:session_autoload=0
let g:session_directory='~/.vim/sessions'

" Ignore rules for Vim and plug-ins, e.g., Command+T
set wildignore+=.git,.svn,CVS,.sass-cache

" For PHP code, enable some fancy options
let php_htmlInStrings=1

" Disable <F11> mappings in shell.vim
let g:shell_mappings_enabled=0

" Easytags
let g:easytags_file='~/.vim/tags'
let g:easytags_on_cursorhold=0  " Wastes too much CPU
set tags=./.tags;,~/.vim/tags

" Taglist options
let Tlist_Process_File_Always=0
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Auto_Highlight_Tag=1
let Tlist_Exit_OnlyWindow=1

let tlist_php_settings='php;c:class;d:constant;f:function'

let Grep_Skip_Dirs = '.git .svn CVS .sass-cache'

if has('unix')
  let g:easytags_cmd='/usr/bin/ctags'
  let Tlist_Ctags_Cmd='/usr/bin/ctags'
  let Tlist_Inc_Winwidth=0
else
  let g:easytags_cmd='c:\bin\tools\ctags\5.8\ctags.exe'
  let Tlist_Ctags_Cmd='c:\bin\tools\ctags\5.8\ctags.exe'
  let Tlist_Inc_Winwidth=1

  " On Windows we map to the Cygwin utilities"
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

  " Ack for grepping, on Windows this runs under the Perl interpreter
  let g:ackprg='c:\bin\cygwin\bin\perl.exe c:\bin\cygwin\usr\local\bin\ack -H --nocolor --nogroup --column'
endif

let g:CommandTMaxFiles=64000
let g:CommandTMaxDepth=24

nmap j gj
nmap k gk

map  / /\v
nmap / /\v
vmap / /\v
nmap <silent> <leader><Space> :noh<CR>

map <leader>ss :SaveSession user<CR>
map <leader>sr :OpenSession user<CR>

nmap <silent> <leader>o :CommandT<CR>

" Clean trailing whitespace
nmap <silent> <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

nmap <leader>q gqip
nmap <leader>v V`]

" Toggle spell-checking
map <silent> <F1> :set nospell!<CR>:set nospell?<CR>

" Toggle paste-mode
nmap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Toggle task status (vim-task)
imap <silent> <buffer> <leader>m <ESC>:call Toggle_task_status()<CR>i
nmap <silent> <buffer> <leader>m      :call Toggle_task_status()<CR>

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

" Quickly adjust the tab/shift width
nmap <leader>w2 :set tabstop=2<CR>:set shiftwidth=2<CR>
nmap <leader>w4 :set tabstop=4<CR>:set shiftwidth=4<CR>
nmap <leader>w8 :set tabstop=8<CR>:set shiftwidth=8<CR>

" Snippets
if has('unix')
  imap <leader>iu <C-R>=substitute(system('bash --norc -c "date +%s"'), '\n', '', 'g')<CR>
else
  imap <leader>iu <C-R>=substitute(system('c:\bin\cygwin\bin\bash.exe --norc -c "date +%s"'), '\n', '', 'g')<CR>
endif

" Abbreviations
iabbrev </ </<C-X><C-O>

" Exit INSERT mode
imap jj <Esc>
imap kk <Esc>

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

  " Highlight trailing whitespace in red
  if has('autocmd')
    highlight                  ExtraWhitespace ctermbg=red guibg=red
    autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
  endif

  set guifont=Consolas:h13:cDEFAULT

  " Toggle menubar visibility
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
  autocmd FileType python     set omnifunc=pythoncomplete#Complete
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
  autocmd FileType c          set omnifunc=ccomplete#Complete

  " Turn off beep sounds
  autocmd VimEnter * set vb t_vb=

  " Filetype specific settings
  autocmd FileType css    set shiftwidth=2
  autocmd FileType css    set tabstop=2
  autocmd FileType css    set expandtab

  autocmd FileType scss   set shiftwidth=2
  autocmd FileType scss   set tabstop=2
  autocmd FileType scss   set expandtab

  autocmd FileType coffee set shiftwidth=2
  autocmd FileType coffee set tabstop=2
  autocmd FileType coffee set expandtab
endif
