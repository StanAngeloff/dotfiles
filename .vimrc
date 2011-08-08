" Make Vim behave in a more useful way (the default) than the vi-compatible manner.
set nocompatible

" Pathogen, manage your runtimepath.
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Enable 256-colour terminal, switch syntax on and select a theme.
set t_Co=256
syntax on
colorscheme vim-zend55

" Use UTF-8 and Unix line-endings for new files.
set encoding=utf-8
set fileformats=unix,mac,dos

set history=1024
set undolevels=2048

set hidden     " Don't dispose buffers, hide them.
set ruler      " Show the cursor position all the time.
set showcmd    " Display incomplete commands.
set showmode   " Display Vim mode, e.g., INSERT, REPLACE, etc.
set incsearch  " Do incremental searching.
set ignorecase " Lowercase matches all.
set smartcase  " Uppercase matches uppercase only.

set backspace=indent,eol,start " Backspace wraps at start- and end-of-line.
set tabstop=2                  " Default number of spaces per tab character.
set softtabstop=2              " Tab size during editing operation.
set shiftwidth=2               " Default tab size.
set expandtab                  " Expand tab into spaces.
set nowrap                     " Don't wrap long lines.
set autoindent                 " Auto-indent new lines.
set timeoutlen=325             " Time to wait after ESC (default causes an annoying delay).
set clipboard+=unnamed         " Yank to clipboard.

set modeline
set modelines=5    " Default numbers of lines to read for modeline instructions.

set nospell        " Turn off spell checking by default

set scrolloff=8    " Scroll when 8 lines from edge of screen.
set nu!            " Enable line numbers.

set lazyredraw     " Do not redraw while running macros (much faster).
set ttyfast        " Enable fast-terminal.

set wildmenu                   " Show possible matches when <Tab> is pressed.
set wildmode=list:longest,full " Include possible matches from these groups.
set novisualbell               " Disable annoying sounds and use visual feedback instead.
set noerrorbells               " Disable more annoying noise.
set laststatus=2               " Always display a status line.
set formatoptions=qrn1         " Format comments, numbered-lists, one-letter words.

set guioptions=grL             " Grey menu items, RHS scrollbar and LHS if in a split.
set hlsearch                   " Highlight the last used search pattern.
set cursorline!                " Highlight line under cursor.

set colorcolumn=78             " Gutter position.

set backup   " Keep backups of files in case we mess up.
set backupdir=$HOME/.vim/backup
set undofile " Keep undo files for cross-session edits.
set undodir=$HOME/.vim/undo

set directory=/tmp,. " Store swap files in /tmp if possible.

set wildignore+=.git,.svn,CVS,.sass-cache " Ignore rules for Vim and plug-ins.

set sessionoptions=blank,buffers,curdir,folds,tabpages,slash,unix " Session Handling.

set tags=./.tags;,~/.vim/tags " tags can be stored in cwd and globally.

if has('statusline')
  set statusline=                   " Clear the statusline, allow for rearranging parts.
  set statusline+=%f                " Path to the file, as typed or relative to current directory.
  set statusline+=%#errormsg#       " Change colour.
  set statusline+=%{&ff!='unix'?'['.&ff.']':''} " Display a warning if fileformat isn't unix.
  set statusline+=%*                " Reset colour to normal statusline colour.
  set statusline+=%#errormsg#       " Change colour.
  set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''} " Display a warning if file encoding isn't UTF-8.
  set statusline+=%*                " Reset colour to normal statusline colour.
  set statusline+=\ %y              " Filetype.
  set statusline+=%([%R%M]%)        " Read-only (RO), modified (+) and unmodifiable (-) flags between braces.
  set statusline+=%#StatusLineNC#%{&ff=='unix'?'':&ff.'\ format'}%* " Shows '!' if file format is not platform default.
  set statusline+=%{'~'[&pm=='']}   " Shows a '~' if in patch-mode.
  if exists('fugitive#statusline')
    set statusline+=\ %{fugitive#statusline()} " Show Git info, via fugitive.git.
  endif
  set statusline+=%#error#          " Change colour.
  set statusline+=%{&paste?'[paste]':''} " Display a warning if &paste is set.
  set statusline+=%*                " Reset colour to normal statusline colour.
  set statusline+=%=                " Right-align following items.
  set statusline+=#%n               " Buffer number.
  set statusline+=\ %l/%L,          " Current line number/total number of lines.
  set statusline+=%c                " Column number.
  set statusline+=%V                " -{virtual column number} (not displayed if equal to 'c').
  set statusline+=\ %p%%            " Percentage of lines through the file%.
  set statusline+=\                 " Trailing space.
  if has('title')
    set titlestring=%t%(\ [%R%M]%)
  endif
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Configure taglist window.
let Tlist_Process_File_Always=0
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Auto_Highlight_Tag=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Ctags_Cmd='ctags'
let Tlist_Inc_Winwidth=0
let tlist_php_settings='php;c:class;d:constant;f:function'

let mapleader="\\"

" Keyboard bindings.
nmap j gj
nmap k gk

map  / /\v
nmap / /\v
vmap / /\v

imap jj <Esc>
imap kk <Esc>

imap <Up>    <NOP>
map  <Up>    <NOP>
imap <Down>  <NOP>
map  <Down>  <NOP>
imap <Left>  <NOP>
map  <Left>  <NOP>
imap <Right> <NOP>
map  <Right> <NOP>

" Tab keyboard bindings.
nmap <leader>tn :tabnew<CR>
nmap <leader>tm :tabmove

" Reformat a paragraph in NORMAL mode.
nmap <leader>q gqip
" Restore last visual selection in LINE mode.
nmap <leader>v V`]

" Clean trailing whitespace keyboard bindings.
nmap <silent> <leader>W :%s/\s\+$//<CR>:let @/=''<CR>
" Turn off active highlighting keyboard bindings.
nmap <silent> <leader><Space> :noh<CR>

" Toggle spell-checking keyboard binding.
map <silent> <F1> :set nospell!<CR>:set nospell?<CR>
" Toggle paste-mode keyboard binding.
nmap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Toggle taglist window.
nmap <silent> <F11> :TlistToggle<CR>

" Adjust the tab/shift width keyboard bindings.
nmap <leader>w2 :set tabstop=2<CR>:set shiftwidth=2<CR>
nmap <leader>w4 :set tabstop=4<CR>:set shiftwidth=4<CR>
nmap <leader>w8 :set tabstop=8<CR>:set shiftwidth=8<CR>

" Snippets keyboard bindings.
" Unix timestamp
imap <leader>iu <C-R>=substitute(system('date +%s'), '\n', '', 'g')<CR>

if has("gui_running")
  set guifont=Inconsolata\ Medium\ 14
endif

" Mode-dependent cursor for gnome-terminal.
if &term =~ "xterm\\|xterm-256color"
  if has("autocmd") && executable('gconftool-2')
    au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
    au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
    au VimLeave    * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
  endif
endif

" Enable file type detection.
filetype plugin indent on

if has('autocmd')
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

  " Highlight trailing whitespace in red.
  highlight                  ExtraWhitespace ctermbg=red guibg=red
  autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

  " Recognise additional types.
  au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru} set ft=ruby
  au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                     set ft=markdown
  au BufRead,BufNewFile {COMMIT_EDITMSG}                            set ft=gitcommit
endif

" Vundle, the plug-in manager for Vim.
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'StanAngeloff/vim-zend55'

Bundle 'ciaranm/detectindent'
" When the correct value for 'expandtab' cannot be determined, it will revert to the default value below.
let g:detectindent_preferred_expandtab=1
if has('autocmd')
  " Attempt to detect indentation for the buffer
  autocmd BufReadPost * :DetectIndent
endif

Bundle 'godlygeek/csapprox'

Bundle 'godlygeek/tabular'

Bundle 'gregsexton/gitv'

Bundle 'juvenn/mustache.vim'

Bundle 'kchmck/vim-coffee-script'

Bundle 'leshill/vim-json'

Bundle 'mattn/zencoding-vim'

Bundle 'mexpolk/vim-taglist'

Bundle 'mileszs/ack.vim'
nmap <LocalLeader># "ayiw:Ack <C-r>a<CR>
vmap <LocalLeader># "ay:Ack <C-r>a<CR>

Bundle 'msanders/snipmate.vim'

Bundle 'othree/html5.vim'

Bundle 'pangloss/vim-javascript'

Bundle 'samsonw/vim-task'
" Toggle task status on current line.
imap <silent> <buffer> <leader>m <ESC>:call Toggle_task_status()<CR>i
nmap <silent> <buffer> <leader>m      :call Toggle_task_status()<CR>

Bundle 'scrooloose/nerdcommenter'

Bundle 'scrooloose/nerdtree'
let NERDTreeChDirMode=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
" Toggle NERD tree.
nmap <silent> <F12> :NERDTreeToggle<CR>

Bundle 'scrooloose/syntastic'
" Check for syntax errors.
nmap <silent> <leader>E :SyntasticEnable<CR>:w<CR>:SyntasticDisable<CR>:Errors<CR><C-W>w
if has('autocmd')
  " Disable syntax checking for all files by default.
  autocmd BufRead * :SyntasticDisable
endif

Bundle 'sjl/gundo.vim'
" Toggle Gundo undo tree.
nmap <silent> <F5> :GundoToggle<CR>

Bundle 'tpope/vim-fugitive'

Bundle 'tpope/vim-git'

Bundle 'tpope/vim-haml'

Bundle 'tpope/vim-markdown'

Bundle 'tpope/vim-repeat'

Bundle 'tpope/vim-surround'

Bundle 'tpope/vim-unimpaired'

Bundle 'tsaleh/vim-supertab'

Bundle 'vim-scripts/Conque-Shell'
let g:ConqueTerm_TERM='xterm-256'
let g:ConqueTerm_CloseOnEnd=1
let g:ConqueTerm_PromptRegex='^(\w\+)\s*\[[0-9A-Za-z_./\~,:-]\+\]\s*[\~\%\$\#]'

Bundle 'easytags.vim'
let g:easytags_on_cursorhold=0  " Wastes too much CPU
let g:easytags_cmd='ctags'
let g:easytags_file='~/.vim/tags'

Bundle 'Gist.vim'

Bundle 'grep.vim'
let Grep_Skip_Dirs='.git .svn CVS .sass-cache'
nmap <silent> <F3> :Grep<CR>

Bundle 'IndexedSearch'

Bundle 'php.vim--Garvin'
Bundle 'phpcomplete.vim'
Bundle 'phpfolding.vim'
Bundle 'PHP-correct-Indenting'
" For PHP code, disable fancy options.
let php_sql_query=0
let php_htmlInStrings=1
let php_asp_tags=0

Bundle 'session.vim--Odding'
let g:session_autosave=0
let g:session_autoload=0
let g:session_directory='~/.vim/sessions'
map <leader>ss :SaveSession user<CR>
map <leader>sr :OpenSession user<CR>

Bundle 'shell.vim--Odding'
" Disable <F11> mappings.
let g:shell_mappings_enabled=0

Bundle 'git://git.wincent.com/command-t.git'
let g:CommandTMaxFiles=64000
let g:CommandTMaxDepth=24
" Start fuzzy match.
nmap <silent> <leader>o :CommandT<CR>

Bundle "gmarik/vim-visual-star-search.git"

Bundle 'ManPageView'
let g:manpageview_pgm_php='pman'
