" Make Vim behave in a more useful way (the default) than the vi-compatible manner.
set nocompatible
scriptencoding utf-8 " Help Vim use the correct character encoding for this script.

" Pathogen, manage your runtimepath.
filetype off
call pathogen#helptags()
call pathogen#incubate()

" Enable 256-colour terminal if no GUI.
if !has("gui_running")
  set t_Co=256
end
" Switch syntax on and select a theme.
syntax on
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
set shiftround                 " Round indent to multiple of 'shiftwidth'. Applies to > and < commands.
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

set spell " Turn on spell checking by default
set spellfile=$HOME/.vim/spell/en.utf-8.add
set spelllang=en

set scrolloff=120  " Scroll when lots of lines from edge of screen. Bigger numbers work better with ':help rnu'.
set rnu            " Show the line number relative to the line with the cursor in front of each line.

set lazyredraw     " Do not redraw while running macros (much faster).
set ttyfast        " Enable fast-terminal.

if exists('&regexpengine')
  set regexpengine=1 " Use the old engine which seems faster in most cases.
endif

set wildmenu                   " Show possible matches when <Tab> is pressed.
set wildmode=list:longest,full " Include possible matches from these groups.
set novisualbell               " Disable annoying sounds and use visual feedback instead.
set noerrorbells               " Disable more annoying noise.
set laststatus=2               " Always display a status line.
set formatoptions=qrn1lo       " Format comments, numbered-lists, one-letter words.
set shortmess=aoOtTAI          " Keep UI notices to a minimum.
set nojoinspaces               " Don't be clever when joining lines.

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

" Use our customised `grep` script for powerful searches.
set grepprg=$HOME/bin/search\ -n\ --color=never\ $*
set grepformat=%f:%l:%m

command! -nargs=+ Search execute 'silent grep! <args>' | botright copen 8 | nnoremap <buffer> <CR> ^:wincmd F<CR>:wincmd T<CR>

" Use a custom leader character.
let mapleader="\\"

" Keyboard bindings.
nnoremap <silent> j gj
nnoremap <silent> k gk

" Make Y consistent with C and D. See ':help Y'.
nnoremap Y y$

" OMG! This is sooo much better.
nnoremap <Space> :
nnoremap <Return> :w<CR>

vnoremap <Space> :
vnoremap <Return> :<C-U>w<CR>gv

" God mode.
noremap  <Up>    <NOP>
inoremap <Up>    <NOP>
noremap  <Down>  <NOP>
inoremap <Down>  <NOP>
noremap  <Left>  <NOP>
inoremap <Left>  <NOP>
noremap  <Right> <NOP>
inoremap <Right> <NOP>

noremap  : <NOP>
vnoremap : <NOP>

" Disallow repeatedly performing the same single-motion command, e.g., {jjj,kkk,hhhh,lll}, etc.
let g:MovementPreviousKey = 'none'
let g:MovementPreviousTime = reltime()
let g:MovementPreviousRepeat = 0
let g:MovementPauseDuration = &timeoutlen

function! MovementKey(key)
  let l:allow = 0
  " If the previous key is different, allow immediately.
  if g:MovementPreviousKey != a:key
    " Reset the counter of how many times the previous key was repeated.
    let g:MovementPreviousRepeat = 0
    let l:allow = 1
  else
    " If we have not repeated the motion multiple times, allow immediately.
    let g:MovementPreviousRepeat = g:MovementPreviousRepeat + 1
    if g:MovementPreviousRepeat < 2
      let l:allow = 1
    else
      " Allow only if more than the specified interval in milliseconds has passed since the last motion.
      let l:ellapsed = str2float(reltimestr(reltime(g:MovementPreviousTime))) * 1000
      let l:allow = (l:ellapsed >= g:MovementPauseDuration)
      " If the specified interval has passed, reset the counter as well.
      if l:allow
        let g:MovementPreviousRepeat = 0
      endif
    endif
  endif
  " Record the motion and the time when it was performed.
  let g:MovementPreviousKey = a:key
  let g:MovementPreviousTime = reltime()
  if !l:allow
    " Negative reinforcement.
    echohl WarningMsg | echo "WARN: Motion '" . a:key . "' already executed " . g:MovementPreviousRepeat . " time(s) within the last " . g:MovementPauseDuration . 'ms.' | echohl None
  endif
  return a:key
endfunction

for s:SingleMovementMode in ['n', 'v']
  for s:SingleMovementKey in ['j', 'k', 'h', 'l', '-', '+', '<BS>', 'w', 'e', 'W', 'E', 'b', 'B']
    exe s:SingleMovementMode . 'noremap <expr> ' . s:SingleMovementKey . " MovementKey('" . s:SingleMovementKey . "')"
  endfor
endfor

" Find the closest occurence of a given character.
function! FindClosest()
  let l:inputCode = getchar()
  " If we received a numeric sequence, we have a character code.
  if l:inputCode !~ '^\d\+$'
    return '\<NOP>'
  endif
  " Convert code to a single character using the current buffer encoding.
  let l:character = nr2char(l:inputCode)
  " Look for the pattern on the current line, both behind and in front of the cursor position.
  let l:command = ''
  let l:position = getpos('.')
  let l:pattern = '\V' . escape(l:character, '\/')
  let [l:discard, l:previousColumn] = searchpos(l:pattern, 'bnW', l:position[1])
  let [l:discard, l:nextColumn] = searchpos(l:pattern, 'nW', l:position[1])
  " Determine which is the closest match, if any.
  if l:previousColumn
    if l:nextColumn
      if abs(l:position[2] - l:previousColumn) > abs(l:position[2] - l:nextColumn)
        let l:command = 'F'
      else
        let l:command = 'f'
      endif
    else
      let l:command = 'F'
    endif
  elseif l:nextColumn
    let l:command = 'f'
  endif
  " We wish to keep ';' and ',' mappings consistent, update cursor as needed.
  if l:command ==# 'F'
    let l:command = (l:position[2] - l:previousColumn) . 'hf'
  endif
  if len(l:command)
    return (l:command . l:character)
  endif
  return '\<NOP>'
endfunction

nnoremap <expr> <leader>f FindClosest()

" Choose '^' or '0' depending on the cursor position.
function! CleverJumpFirst()
  let l:before = getline('.')[:col('.') - 1]
  if l:before =~ '^\s\+\S$'
    return '0'
  endif
  return '^'
endfunction

nnoremap <expr> 0 CleverJumpFirst()
vnoremap <expr> 0 CleverJumpFirst()

" Make $ behave consistently in visual mode.
vnoremap $ $h

" Q for 'Q'uit, 'Ex' mode has received zero use.
nnoremap <silent> Q ZZ
vnoremap <silent> Q <Esc>ZZ

" Start a new Undo group before undoing changes in INSERT mode.
" Undos can be re-done using 'u' in NORMAL mode.
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Start a new Undo group before pasting in INSERT mode.
inoremap <C-R> <C-G>u<C-R>
" Quick tab creation and navigation.
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tm :tabmove
nnoremap <expr> <leader>te ':tabedit '

" Tab navigation
set showtabline=0

let g:ShowTabLineIsShowing=0
let g:ShowTabLineDuration=1250
let g:ShowTabLineUpdateTime = &ut

function! ShowTabLine()
  set showtabline=2

  if !g:ShowTabLineIsShowing
    let g:ShowTabLineIsShowing=1

    " Change the update time so our 'CursorHold' code fires after the required time.
    if &ut > g:ShowTabLineDuration | let g:ShowTabLineUpdateTime = &ut | let &ut = g:ShowTabLineDuration | endif

    " Hide the tabline after the time has passed.
    augroup HideTabLine
      autocmd CursorHold *
            \ exe 'set ut=' . g:ShowTabLineUpdateTime |
            \ set showtabline=0 | let g:ShowTabLineIsShowing=0 |
            \ augroup HideTabLine | execute "autocmd!" | augroup END | augroup! HideTabLine
    augroup END
  endif
endfunction

if has('autocmd')
  au TabEnter * call ShowTabLine()
endif

nnoremap <silent> <C-J> gt
nnoremap <silent> <C-K> gT
nnoremap <silent> <C-G> :call ShowTabLine()<CR><C-G>

" Quick window navigation.
nnoremap <silent> <S-Tab> <C-W><C-W>

" Reformat a paragraph in NORMAL mode.
nnoremap <leader>q gqip
" Restore last implicit selection (e.g., on paste) in VISUAL mode.
nnoremap <leader>v g`[Vg`]o

" Erase trailing whitespace function and keyboard binding.
function! StripTrailingWhitespace()
  let l:previousPosition = getpos('.')
  let l:previousSearch = @/
  %s/\s\+$//e
  let @/ = l:previousSearch
  call setpos('.', l:previousPosition)
endfunction

nnoremap <silent> <leader>W :call StripTrailingWhitespace()<CR>

" Turn off active highlighting keyboard binding.
nnoremap <silent> <leader><Space> :noh<CR>:sign unplace *<CR>:SyntasticReset<CR>

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

" Snippets keyboard bindings.
" Unix timestamp.
inoremap <leader>iu <C-R>=substitute(system('date +%s'), '\n', '', 'g')<CR>

" Quickly create a { .. } block.
inoremap {}<CR> {<CR>}<C-O>O

" Copy entire buffer to X clipboard.
nnoremap <leader>= mZggVG"+yg`Z

" Open tag under cursor in a new tab.
nnoremap <leader>] <C-w><C-]><C-w>T

" Sort inside a paragraph.
nnoremap <silent> <leader>sip mZvip:sort<CR>g`Z:echo (line("'>") - line("'<") + 1) . ' line(s) sorted'<CR>

" Write using `sudo` in COMMAND mode if the file is read-only.
cnoremap w!! w !sudo tee % >/dev/null

" XML formatting through `xmllint`.
cnoreabbrev xmlformat %!xmllint --format --encode UTF-8 -

if has("gui_running")
  set guifont=Inconsolata\ for\ Powerline\ Medium\ 14
endif

" Preferred fold method is marker, e.g., manual.
set foldmethod=marker

" View settings to preserve for buffers.
set viewdir=$HOME/.vim/view
set viewoptions=cursor,folds,slash,unix

" Cyrillic configuration, tired of layout switching, no?
set langmap+=чявертъуиопшщасдфгхйклзьцжбнмЧЯВЕРТЪУИОПШЩАСДФГХЙКЛЗѝЦЖБНМ;`qwertyuiop[]asdfghjklzxcvbnm~QWERTYUIOP{}ASDFGHJKLZXCVBNM,ю\\,Ю\|,

nnoremap <silent> Я ZZ

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
  autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
        \ | highlight        ExtraWhitespace ctermbg=red guibg=red

  " Recognise additional types.
  au BufRead,BufNewFile {Gemfile,Guardfile,Rakefile,Vagrantfile,*.rake,config.ru} set ft=ruby
  au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown
  au BufRead,BufNewFile {COMMIT_EDITMSG} set ft=gitcommit

  " If a local .lvimrc file exists in the current working directory, source it on load (unsafe).
  " When the file is changed, update it by sourcing again.
  au VimEnter * let s:LocalConfigurationPaths = ['.lvimrc', 'attic/.lvimrc']
        \ | let s:LocalConfigurationBase = getcwd() . '/'
        \ | for s:LocalConfigurationFile in s:LocalConfigurationPaths
          \ | if filereadable(s:LocalConfigurationBase . s:LocalConfigurationFile)
            \ | echohl WarningMsg | echom 'Loading local configuration from file "' . s:LocalConfigurationFile . '".' | echohl None
            \ | execute 'source' s:LocalConfigurationBase . s:LocalConfigurationFile
            \ | augroup LocalConfigurationUpdate
              \ | execute 'au! BufWritePost' s:LocalConfigurationBase . s:LocalConfigurationFile 'source %'
            \ | augroup END
          \ | endif
        \ | endfor

  " Update spell checking to ignore class names, $variables, @docblock tags and @Annotations.
  autocmd BufRead,BufNewFile * syn match SpellIgnoreInterfaces /\<\(\(Abstract\)\w\+\|\w\+\(Interface\|Controller\|Trait\|Bundle\|Repository\)\)\>/ contains=@NoSpell transparent
        \ | syn match SpellIgnoreVariables /\<\$\w\+\>/ contains=@NoSpell transparent
        \ | syn match SpellIgnoreDocBlocks /@\([A-Z]\w\+\|param\)\>/ contains=@NoSpell transparent
        \ | syn cluster Spell add=SpellIgnoreInterfaces,SpellIgnoreVariables,SpellIgnoreDocBlocks

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
colorscheme vim-zend55

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

Bundle 'juvenn/mustache.vim'

" ---------------------------------------------------------------------------

Bundle 'kchmck/vim-coffee-script'

" ---------------------------------------------------------------------------

Bundle 'SirVer/ultisnips'

let g:UltiSnipsNoPythonWarning=1

let g:UltiSnipsSnippetDirectories=['snippets']

" Don't let UltiSnips handle the <C-J> and <C-K> keys.
let g:UltiSnipsExpandTrigger='<NOP>'
let g:UltiSnipsJumpForwardTrigger='<NOP>'
let g:UltiSnipsJumpBackwardTrigger='<NOP>'

" Try to complete as a snippet, pop-up item or just forward the Tab key.
function! UltiSnipsComplete()
  call UltiSnips_ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-Y>"
    else
      return "\<Tab>"
    endif
  endif
  return ''
endfunction

inoremap <silent> <Tab> <C-R>=UltiSnipsComplete()<CR>

" Use <C-{J,K}> for navigating the popup menu, if visible.
" Otherwise, delegate to UltiSnips. If that fails, jump lines.
let g:UltiSnipsPreviousPosition = [0, 0, 0]

function! UltiSnipsDidJump(navigation_mode)
  let l:position = getpos('.')
  if g:UltiSnipsPreviousPosition[0] == l:position[0]
\ && g:UltiSnipsPreviousPosition[1] == l:position[1]
\ && g:UltiSnipsPreviousPosition[2] == l:position[2]
    return "\<C-O>" . a:navigation_mode
  endif
  return ''
endfunction

function! UltiSnipsJump(jump_mode, ultisnips_mode, navigation_mode)
  if pumvisible()
    return a:jump_mode
  endif
  let g:UltiSnipsPreviousPosition = getpos('.')
  return "\<C-R>=UltiSnips_Jump" . a:ultisnips_mode . "()\<CR>\<C-R>=UltiSnipsDidJump('" . a:navigation_mode . "')\<CR>"
endfunction

inoremap <expr> <C-J> UltiSnipsJump("\<C-N>", 'Forwards', 'gj')
inoremap <expr> <C-K> UltiSnipsJump("\<C-P>", 'Backwards', 'gk')

snoremap <C-J> <Esc>:call UltiSnips_JumpForwards()<CR>
snoremap <C-K> <Esc>:call UltiSnips_JumpBackwards()<CR>

" ---------------------------------------------------------------------------

Bundle 'othree/html5.vim'

" ---------------------------------------------------------------------------

Bundle 'pangloss/vim-javascript'

" ---------------------------------------------------------------------------

Bundle 'scrooloose/nerdcommenter'

" ---------------------------------------------------------------------------

Bundle 'scrooloose/nerdtree'
let NERDTreeChDirMode=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeWinSize=48
let NERDTreeIgnore=['\~$', '\.pyc$', '^.sass-cache$']
let NERDTreeMapJumpNextSibling=''
let NERDTreeMapJumpPrevSibling=''
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
" Free up '?' for reverse search.
let NERDTreeMapHelp = 'H'
" Don't ask if buffers should be deleted on rename.
let NERDTreeAutoDeleteBuffer=1

" Fast Fingers
" Quickly open up NERDTree nodes after completing a search.
let g:FastFingersSpeed = 100
let g:FastFingersUpdateTime = &ut
let g:FastFingersNERDTreeClosed = '^\s*▸.*\/$'

function! FastFingersSearch(mode)

  " Lower the update time so our 'CursorHold' code fires immediately after the search.
  if &ut > g:FastFingersSpeed | let g:FastFingersUpdateTime = &ut | let &ut = g:FastFingersSpeed | endif

  augroup FastFingers
    autocmd CursorHold *
          \ exe 'set ut=' . g:FastFingersUpdateTime |
          \ if getline(".") =~ g:FastFingersNERDTreeClosed | call feedkeys('o', 'm') | endif |
          \ augroup FastFingers | execute "autocmd!" | augroup END | augroup! FastFingers
  augroup END

  return a:mode
endfunction

nnoremap <expr> / FastFingersSearch('/')
nnoremap <expr> ? FastFingersSearch('?')

" Reveal the current file in NERDTree.
autocmd VimEnter * call NERDTreeAddKeyMap({
      \ 'key': 'a',
      \ 'scope': 'all',
      \ 'callback': 'NERDTreeReveal',
      \ 'quickhelpText': 'reveal the file from previous window' })

function! NERDTreeReveal()
  wincmd p
  execute 'silent! NERDTreeFind'
endfunction

" ---------------------------------------------------------------------------

Bundle 'mbbill/undotree'
nnoremap <silent> <F6> :UndotreeToggle<CR>
let g:undotree_SplitWidth=45
let g:undotree_SetFocusWhenToggle=1

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

Bundle 'StanAngeloff/php.vim'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'phpfolding.vim'
Bundle '2072/PHP-Indenting-for-VIm'

" For PHP code, enable fancy options and better syntax sync.
let php_htmlInStrings=1
" Don't use the PHP syntax folding.
let g:DisableAutoPHPFolding = 1

" ---------------------------------------------------------------------------

Bundle 'kien/ctrlp.vim'
let g:ctrlp_map=''
let g:ctrlp_cmd='CtrlPCurWD'
let g:ctrlp_match_window_reversed=0
let g:ctrlp_max_height=20
let g:ctrlp_highlight_match=[1, 'Search']
let g:ctrlp_max_files=64000
let g:ctrlp_max_depth=24
let g:ctrlp_cache_dir='/tmp/.ctrlp'
let g:ctrlp_custom_ignore = {
  \ 'dir': '[\/]\(\.\(git\|hg\|svn\|sass-cache\)\|components\|node_modules\|vendor\)$',
  \ }

nnoremap <silent> <leader>o :<C-U>CtrlPCurWD<CR>
nnoremap <silent> <leader>b :<C-U>CtrlPBufTag<CR>

" ---------------------------------------------------------------------------

Bundle 'thinca/vim-visualstar'

" ---------------------------------------------------------------------------

Bundle 'tpope/vim-abolish'

" ---------------------------------------------------------------------------

Bundle 'bling/vim-airline'

let g:airline_theme='grey'

let g:airline_powerline_fonts=1

let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_branch_prefix = '⭠ '
let g:airline_readonly_symbol = '⭤ '
let g:airline_linecolumn_prefix = '⭡'
let g:airline_paste_symbol = '❯ ρ'

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

Bundle 'AutoTag'

let g:autotagmaxTagsFileSize=32 * 1024 * 1024
let g:autotagTagsFile='.tags'
let g:autotagVerbosityLevel=0
let g:autotagCtagsCmd='silent ctags'

" ---------------------------------------------------------------------------

Bundle 'scrooloose/syntastic'

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }

let g:syntastic_warning_symbol='W>'
let g:syntastic_style_warning_symbol='s>'

let g:syntastic_error_symbol='E>'
let g:syntastic_style_error_symbol='S>'

" Check for syntax errors.
nnoremap <silent> <F9>      :w<CR>:SyntasticCheck<CR>
inoremap <silent> <F9> <Esc>:w<CR>:SyntasticCheck<CR>a

" ---------------------------------------------------------------------------

Bundle 'elzr/vim-json'

" ---------------------------------------------------------------------------

Bundle 'jnwhiteh/vim-golang'

" ---------------------------------------------------------------------------

Bundle 'jistr/vim-nerdtree-tabs'

let g:nerdtree_tabs_open_on_new_tab=0
let g:nerdtree_tabs_focus_on_files=1

nnoremap <silent><expr> <Tab> exists('b:NERDTreeType') ? ':NERDTreeMirrorToggle<CR>' : ':NERDTreeFocus<CR>'

" Make sure a NERDTree instance is mirrored for all tabs.
" This is needed as if the buffer with the only NERDTree instance is closed,
" the state is reset for the next mirror.
if has('autocmd')

  " Silently open and immediately close a NERDTree.
  au TabEnter * if !exists('t:hasNERDTree')
          \ | let t:hasNERDTree=1
          \ | execute 'silent! NERDTreeMirrorOpen'
          \ | execute 'silent! NERDTreeMirrorToggle'
        \ | endif

endif
