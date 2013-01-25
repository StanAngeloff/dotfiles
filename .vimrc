" Make Vim behave in a more useful way (the default) than the vi-compatible manner.
set nocompatible

" Pathogen, manage your runtimepath.
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Enable 256-colour terminal if no GUI.
if !has("gui_running")
  set t_Co=256
end
" Switch syntax on and select a theme.
syntax on
colorscheme vim-zend55
set synmaxcol=2048

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

" 'i' is avoided as it can be extremely slow on large trees.
set complete-=i
" The Preview/Scratch window is extremely annoying.
set completeopt-=preview

set modeline
set modelines=5    " Default numbers of lines to read for modeline instructions.

set nospell        " Turn off spell checking by default

set scrolloff=120  " Scroll when lots of lines from edge of screen. Bigger numbers work better with ':help rnu'.
set rnu            " Show the line number relative to the line with the cursor in front of each line.

set lazyredraw     " Do not redraw while running macros (much faster).
set ttyfast        " Enable fast-terminal.

set wildmenu                   " Show possible matches when <Tab> is pressed.
set wildmode=list:longest,full " Include possible matches from these groups.
set novisualbell               " Disable annoying sounds and use visual feedback instead.
set noerrorbells               " Disable more annoying noise.
set laststatus=2               " Always display a status line.
set formatoptions=qrn1lo       " Format comments, numbered-lists, one-letter words.

set guioptions=                " No GUI.
set hlsearch                   " Highlight the last used search pattern.
set cursorline!                " Highlight line under cursor.

set colorcolumn=78             " Gutter position.
set textwidth=120

set listchars=tab:→\ ,eol:§    " Display a placeholder character for tabs and newlines.

set matchpairs+=<:> " Balance HTML tags.

set backup   " Keep backups of files in case we mess up.
set backupdir=$HOME/.vim/backup

set undofile " Keep undo files for cross-session edits.
set undodir=$HOME/.vim/undo

set directory=/tmp,. " Store swap files in /tmp if possible.

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/* " Ignore rules for Vim and plug-ins.

set sessionoptions=blank,buffers,curdir,folds,tabpages,slash,unix " Session Handling.

set tags=./.tags;,~/.vim/tags " Tags can be stored in working directory or globally.

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
  set mousehide " Hide mouse after chars typed
endif

" Syntax highlight shell scripts as per POSIX, not the original Bourne shell which very few use.
let g:is_posix = 1

let mapleader="\\"

" Keyboard bindings.
nnoremap j gj
nnoremap k gk

noremap  / /\v
nnoremap / /\v
vnoremap / /\v

inoremap jj <Esc>
inoremap kk <Esc>

inoremap <Up>    <NOP>
noremap  <Up>    <NOP>
inoremap <Down>  <NOP>
noremap  <Down>  <NOP>
inoremap <Left>  <NOP>
noremap  <Left>  <NOP>
inoremap <Right> <NOP>
noremap  <Right> <NOP>

" Q for 'Q'uit, 'Ex' mode has received zero use.
nnoremap <silent> Q ZZ

" Start a new Undo group before undoing changes in INSERT mode.
" Undos can be re-done using 'u' in NORMAL mode.
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Start a new Undo group before pasting in INSERT mode.
inoremap <C-R> <C-G>u<C-R>

" Quick tab creation and navigation.
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tm :tabmove
nnoremap <leader>te :tabedit 

nnoremap <silent> <C-J> gt
nnoremap <silent> <C-K> gT

" Reformat a paragraph in NORMAL mode.
nnoremap <leader>q gqip
" Restore last visual selection in VISUAL mode.
nnoremap <leader>v V`]

" Erase trailing whitespace keyboard binding.
nnoremap <silent> <leader>W :%s/\s\+$//<CR>:let @/=''<CR>
" Turn off active highlighting keyboard binding.
nnoremap <silent> <leader><Space> :noh<CR>:sign unplace *<CR>

" Toggle spell-checking keyboard binding.
noremap <silent> <F1> :set nospell! nospell?<CR>
" Toggle paste-mode keyboard binding.
nnoremap <silent> <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
" Toggle case sensitive/insensitive.
nnoremap <silent> <F3> :set ignorecase! ignorecase?<CR>
" Toggle display of placeholder characters for tabs and newlines.
nnoremap <silent> <F4> :set list! list?<CR>

" Adjust the tab/shift width keyboard bindings.
nnoremap <leader>w2 :setlocal tabstop=2<CR>:setlocal shiftwidth=2<CR>
nnoremap <leader>w4 :setlocal tabstop=4<CR>:setlocal shiftwidth=4<CR>
nnoremap <leader>w8 :setlocal tabstop=8<CR>:setlocal shiftwidth=8<CR>

nnoremap <leader>w<Tab>   :setlocal noexpandtab<CR>
nnoremap <leader>w<Space> :setlocal expandtab<CR>

" Evaluate block as expression
vnoremap <C-R> "ac<C-R>=<C-R>a<CR><Esc>vbo

" Make Control-direction switch between windows (like C-W h, etc.)
nnoremap <silent> gk :wincmd k<CR>
nnoremap <silent> gj :wincmd j<CR>
nnoremap <silent> gh :wincmd h<CR>
nnoremap <silent> gl :wincmd l<CR>

" Snippets keyboard bindings.
" Unix timestamp.
inoremap <leader>iu <C-R>=substitute(system('date +%s'), '\n', '', 'g')<CR>

" Copy entire buffer to X clipboard.
nnoremap <leader>= mmggVG"+y`m

" Align commands.
nnoremap <leader>a= :Tabularize /=<CR>
vnoremap <leader>a= m[om]:Tabularize /=<CR>`]V`[

nnoremap <leader>a> :Tabularize /=><CR>
vnoremap <leader>a> m[om]:Tabularize /=><CR>`]V`[

nnoremap <leader>a: :Tabularize /:\zs/l0l1<CR>
vnoremap <leader>a: m[om]:Tabularize /:\zs/l0l1<CR>`]V`[

" Open tag under cursor in a new tab.
nnoremap <leader>] <C-w><C-]><C-w>T

" Write using `sudo` in COMMAND mode if the file is read-only.
cnoremap w!! w !sudo tee % >/dev/null

" XML formatting through `xmllint`.
cnoreabbrev xmlformat %!xmllint --format --encode UTF-8 -

if has("gui_running")
  set guifont=Inconsolata\ for\ Powerline\ Medium\ 14
else
  " Mode-dependent cursor for gnome-terminal.
  if &term =~ "xterm\\|xterm-256color\\|rxvt-unicode-256color"
    :silent !echo -ne "\033]12;white\007"
    let &t_SI = "\033]12;steelblue\007"
    let &t_EI = "\033]12;white\007"
    if has('autocmd')
      autocmd VimLeave * :!echo -ne "\033]12;white\007"
    endif
  endif
endif

" Preferred fold method is marker, e.g., manual.
set foldmethod=marker

" View settings to preserve for buffers.
set viewdir=$HOME/.vim/view
set viewoptions=cursor,folds,slash,unix

" Cyrillic configuration, tired of layout switching, no?
set langmap+=чявертъуиопшщасдфгхйклзьцжбнмЧЯВЕРТЪУИОПШЩАСДФГХЙКЛЗѝЦЖБНМ;`qwertyuiop[]asdfghjklzxcvbnm~QWERTYUIOP{}ASDFGHJKLZXCVBNM,ю\\,Ю\|,

nnoremap <silent> Я ZZ

inoremap йй <Esc>
inoremap кк <Esc>

" Enable file type detection.
filetype plugin indent on

if has('autocmd')
  " Auto-save and load views for existing files. See 'viewoptions'.
  augroup session
    au!
    autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' |           mkview | endif
    autocmd BufRead      * if expand('%') != '' && &buftype !~ 'nofile' | silent! loadview | endif
  augroup END

  " Turn on auto-complete for supported file types.
  autocmd FileType python     set omnifunc=pythoncomplete#Complete
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
  autocmd FileType c          set omnifunc=ccomplete#Complete

  " Turn off beep sounds.
  autocmd VimEnter * set vb t_vb=

  " Highlight trailing whitespace in red.
  highlight                  ExtraWhitespace ctermbg=red guibg=red
  autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

  " Recognise additional types.
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,*.rake,config.ru} set ft=ruby
  au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown
  au BufRead,BufNewFile {COMMIT_EDITMSG} set ft=gitcommit

  " Sass variables.
  au BufRead,BufNewFile {*.sass,*.scss} setlocal iskeyword+=$,-
endif

" Vundle, the plug-in manager for Vim.
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Make broken SSL happy again
let $GIT_SSL_NO_VERIFY='true'

" ---------------------------------------------------------------------------

Bundle 'StanAngeloff/vim-zend55'

" ---------------------------------------------------------------------------

Bundle 'ciaranm/detectindent'
" When the correct value for 'expandtab' cannot be determined, it will revert to the default value below.
let g:detectindent_preferred_expandtab=1
if has('autocmd')
  " Attempt to detect indentation for the buffer.
  autocmd BufReadPost * :DetectIndent
endif

" ---------------------------------------------------------------------------

Bundle 'godlygeek/csapprox'

" ---------------------------------------------------------------------------

Bundle 'godlygeek/tabular'


" ---------------------------------------------------------------------------

Bundle 'juvenn/mustache.vim'

" ---------------------------------------------------------------------------

Bundle 'kchmck/vim-coffee-script'

" ---------------------------------------------------------------------------

Bundle 'leshill/vim-json'

" ---------------------------------------------------------------------------

Bundle 'majutsushi/tagbar'
let g:tagbar_autoclose=1
let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:tagbar_autoshowtag=1
" Toggle tag list window.
nnoremap <silent> <F11> :TagbarToggle<CR>

" ---------------------------------------------------------------------------

Bundle 'SirVer/ultisnips'
let g:UltiSnipsSnippetDirectories=['snippets']

" ---------------------------------------------------------------------------

Bundle 'othree/html5.vim'

" ---------------------------------------------------------------------------

Bundle 'pangloss/vim-javascript'

" ---------------------------------------------------------------------------

Bundle 'samsonw/vim-task'
" Toggle task status on current line.
inoremap <silent> <leader>m <ESC>:call Toggle_task_status()<CR>a
nnoremap <silent> <leader>m      :call Toggle_task_status()<CR>

" ---------------------------------------------------------------------------

Bundle 'scrooloose/nerdcommenter'

" ---------------------------------------------------------------------------

Bundle 'scrooloose/nerdtree'
let NERDTreeChDirMode=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeIgnore=['\~$', '\.pyc$', '^.sass-cache$']
let NERDTreeMapJumpNextSibling=''
let NERDTreeMapJumpPrevSibling=''
let NERDTreeShowHidden=1

nnoremap <silent> <F12> :NERDTreeToggle<CR>:NERDTreeMirror<CR>

" ---------------------------------------------------------------------------

Bundle 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
" Check for syntax errors.
nnoremap <silent> <F9> :w<CR>:sign unplace *<CR>:SyntasticCheck<CR>

" ---------------------------------------------------------------------------

Bundle 'sjl/gundo.vim'
" Toggle Gundo undo tree.
nnoremap <silent> <F6> :GundoToggle<CR>

" ---------------------------------------------------------------------------

Bundle 'tpope/vim-fugitive'

" ---------------------------------------------------------------------------

Bundle 'tpope/vim-git'

" ---------------------------------------------------------------------------

Bundle 'tpope/vim-haml'

" ---------------------------------------------------------------------------

Bundle 'tpope/vim-markdown'

" ---------------------------------------------------------------------------

Bundle 'tpope/vim-repeat'

" ---------------------------------------------------------------------------

Bundle 'tpope/vim-surround'

" ---------------------------------------------------------------------------

Bundle 'tpope/vim-unimpaired'

" ---------------------------------------------------------------------------

Bundle 'ervandew/supertab'
let g:SuperTabDefaultCompletionType='<C-P>'
let g:SuperTabMappingForward='<C-K>'
let g:SuperTabMappingBackward='<C-J>'
let g:SuperTabLongestHighlight=1

" ---------------------------------------------------------------------------

Bundle 'easytags.vim'
let g:easytags_on_cursorhold=0  " Wastes too much CPU
let g:easytags_dynamic_files=2  " Always use local .tags file
let g:easytags_file='~/.vim/tags'
let g:easytags_include_members=1
let g:easytags_resolve_links=1

" ---------------------------------------------------------------------------

Bundle 'IndexedSearch'

" ---------------------------------------------------------------------------

Bundle 'StanAngeloff/php.vim'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'phpfolding.vim'
Bundle '2072/PHP-Indenting-for-VIm'
" For PHP code, enable fancy options and better syntax sync.
let php_htmlInStrings=1

" ---------------------------------------------------------------------------

Bundle 'session.vim--Odding'
let g:session_autosave=0
let g:session_autoload=0
let g:session_directory='~/.vim/sessions'
noremap <leader>ss :SaveSession user<CR>
noremap <leader>sr :OpenSession user<CR>

" ---------------------------------------------------------------------------

" to open an URL / directory under the cursor.
Bundle 'shell.vim--Odding'
" Disable <F11> mappings.
let g:shell_mappings_enabled=0

" ---------------------------------------------------------------------------

Bundle 'kien/ctrlp.vim'
let g:ctrlp_map=''
let g:ctrlp_cmd='CtrlPCurWD'
let g:ctrlp_match_window_reversed=0
let g:ctrlp_max_height=20
let g:ctrlp_highlight_match=[1, 'Search']
let g:ctrlp_max_files=64000
let g:ctrlp_max_depth=24

nnoremap <silent> <leader>o :<C-U>CtrlPCurWD<CR>
nnoremap <silent> <leader>b :<C-U>CtrlPBufTag<CR>

" ---------------------------------------------------------------------------

Bundle 'thinca/vim-visualstar'

" ---------------------------------------------------------------------------

Bundle 'StanAngeloff/ManPageView'
let g:manpageview_pgm_php="$HOME/bin/pman"

" ---------------------------------------------------------------------------

Bundle 'tpope/vim-speeddating'

" ---------------------------------------------------------------------------

Bundle 'tpope/vim-abolish'

" ---------------------------------------------------------------------------

Bundle 'Lokaltog/vim-powerline'
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'zend55'

" ---------------------------------------------------------------------------

Bundle 'nono/vim-handlebars'

" ---------------------------------------------------------------------------

Bundle 'groenewege/vim-less'

" ---------------------------------------------------------------------------

Bundle 'hail2u/vim-css3-syntax'

" ---------------------------------------------------------------------------

Bundle 'tpope/vim-eunuch'

" ---------------------------------------------------------------------------

Bundle 'benmills/vimux'
nnoremap <silent> <F5>      :w<CR>:VimuxRunLastCommand<CR>
inoremap <silent> <F5> <Esc>:w<CR>:VimuxRunLastCommand<CR>a

" ---------------------------------------------------------------------------

Bundle 'jesseschalken/list-text-object'

" ---------------------------------------------------------------------------

Bundle 'kana/vim-textobj-user'
Bundle 'lucapette/vim-textobj-underscore'

" ---------------------------------------------------------------------------

Bundle 'kurkale6ka/vim-swap'
