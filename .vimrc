" Make Vim behave in a more useful way (the default) than the vi-compatible manner.
set nocompatible
scriptencoding utf-8 " Help Vim use the correct character encoding for this script.

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
set infercase  " Adjust case of match depending on the typed text.

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
set shortmess=aoOtTAI          " Keep UI notices to a minimum.

set guioptions=                " No GUI.
set showtabline=2              " The line with tab page labels will be displayed always.
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

set tags=.tags,./.tags,~/.vim/tags " Tags can be stored against a project, next to a file or globally.

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
nnoremap <silent> j gj
nnoremap <silent> k gk

" Make Y consistent with C and D. See ':help Y'.
nnoremap Y y$

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
" Restore last implicit selection (e.g., on paste) in VISUAL mode.
nnoremap <leader>v `[V`]o

" Erase trailing whitespace function and keyboard binding.
function! s:strip_trailing_whitespace()
  let previous_line = line('.')
  let previous_column = col('.')
  let previous_search = @/
  %s/\s\+$//e
  let @/ = previous_search
  call cursor(previous_line, previous_column)
endfunction

nnoremap <silent> <leader>W :call <SID>strip_trailing_whitespace()<CR>

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
nnoremap <leader>= mZggVG"+y`Z

" Open tag under cursor in a new tab.
nnoremap <leader>] <C-w><C-]><C-w>T

" Sort inside a paragraph.
nnoremap <silent> <leader>sip mZvip:sort<CR>`Z:echo (line("'>") - line("'<") + 1) . ' line(s) sorted'<CR>

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
  au BufRead,BufNewFile {Gemfile,Guardfile,Rakefile,Vagrantfile,*.rake,config.ru} set ft=ruby
  au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown
  au BufRead,BufNewFile {COMMIT_EDITMSG} set ft=gitcommit
endif

" Vundle, the plug-in manager for Vim.
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Make broken SSL happy again
let $GIT_SSL_NO_VERIFY='true'

" ---------------------------------------------------------------------------

Bundle 'gmarik/vundle'

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

" Align commands.
nnoremap <leader>a= :Tabularize /=<CR>
vnoremap <leader>a= m[om]:Tabularize /=<CR>`]V`[

nnoremap <leader>a> :Tabularize /=><CR>
vnoremap <leader>a> m[om]:Tabularize /=><CR>`]V`[

nnoremap <leader>a: :Tabularize /:\zs/l0l1<CR>
vnoremap <leader>a: m[om]:Tabularize /:\zs/l0l1<CR>`]V`[

" ---------------------------------------------------------------------------

Bundle 'juvenn/mustache.vim'

" ---------------------------------------------------------------------------

Bundle 'kchmck/vim-coffee-script'

" ---------------------------------------------------------------------------

Bundle 'leshill/vim-json'

" ---------------------------------------------------------------------------

Bundle 'SirVer/ultisnips'
let g:UltiSnipsSnippetDirectories=['snippets']

" Don't let UltiSnips handle the <C-J> and <C-K> keys.
let g:UltiSnipsJumpForwardTrigger='<NOP>'
let g:UltiSnipsJumpBackwardTrigger='<NOP>'

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
let NERDTreeQuitOnOpen=1

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
let g:SuperTabDefaultCompletionType='<C-X><C-N>'
let g:SuperTabMappingForward='<nul>'
let g:SuperTabMappingBackward='<s-nul>'
let g:SuperTabLongestEnhanced=1
let g:SuperTabLongestHighlight=1

if has('autocmd')
  autocmd FileType *
        \ call SuperTabChain(&omnifunc, '<C-X><C-N>') |
        \ call SuperTabSetDefaultCompletionType('<C-X><C-U>') |
endif

" Use <C-{J,K}> for navigating the popup menu, if visible. Otherwise, delegate to UltiSnips.
inoremap <expr> <C-J> pumvisible() ? "\<C-N>" : '<C-R>=UltiSnips_JumpForwards()<CR>'
inoremap <expr> <C-K> pumvisible() ? "\<C-P>" : '<C-R>=UltiSnips_JumpBackwards()<CR>'

snoremap <C-J> <Esc>:call UltiSnips_JumpForwards()<CR>
snoremap <C-K> <Esc>:call UltiSnips_JumpBackwards()<CR>

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

Bundle 'tpope/vim-speeddating'

" ---------------------------------------------------------------------------

Bundle 'tpope/vim-abolish'

" ---------------------------------------------------------------------------

Bundle 'Lokaltog/vim-powerline'
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'zend55'

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

Bundle 'Shougo/neocomplcache'
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_auto_select=0
let g:neocomplcache_enable_ignore_case=0
let g:neocomplcache_enable_fuzzy_completion=0
let g:neocomplcache_enable_camel_case_completion=1
let g:neocomplcache_enable_underbar_completion=1
let g:neocomplcache_enable_prefetch=1
let g:neocomplcache_disable_auto_complete=1

if ! exists('g:neocomplcache_delimiter_patterns')
  let g:neocomplcache_delimiter_patterns={}
endif
if ! exists('g:neocomplcache_next_keyword_patterns')
  let g:neocomplcache_next_keyword_patterns={}
endif
if ! exists('g:neocomplcache_member_prefix_patterns')
  let g:neocomplcache_member_prefix_patterns={}
endif
if ! exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns={}
endif

" Add support for PHP file type.
let g:neocomplcache_delimiter_patterns['php']=['->', '::', '\']
let g:neocomplcache_next_keyword_patterns['php']='\h\w*>'
let g:neocomplcache_member_prefix_patterns['php']='->\|::'
let g:neocomplcache_omni_patterns['php'] = '[^. \t]->\h\w*\|\h\w*::'

let g:neocomplcache_tags_caching_limit_file_size=32 * 1024 * 1024

let g:neocomplcache_temporary_dir='/tmp/.neocomplcache'

let g:neocomplcache_source_rank = {
  \ 'buffer_complete': 500,
  \ 'omni_complete': 400,
\ }

" ---------------------------------------------------------------------------

Bundle 'AutoTag'

let g:autotagmaxTagsFileSize=32 * 1024 * 1024
let g:autotagTagsFile='.tags'
let g:autotagVerbosityLevel=0
let g:autotagCtagsCmd='silent ctags'

" ---------------------------------------------------------------------------

Bundle 'coderifous/textobj-word-column.vim'

" ---------------------------------------------------------------------------

Bundle 'argtextobj.vim'

" ---------------------------------------------------------------------------

Bundle 'scrooloose/syntastic'

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }

let g:syntastic_warning_symbol='W>'
let g:syntastic_style_warning_symbol='s>'

let g:syntastic_error_symbol='E>'
let g:syntastic_style_error_symbol='S>'

" Check for syntax errors.
nnoremap <silent> <F9>      :w<CR>:SyntasticCheck<CR>
inoremap <silent> <F9> <ESC>:w<CR>:SyntasticCheck<CR>a
