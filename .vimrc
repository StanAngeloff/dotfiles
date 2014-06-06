" Make Vim behave in a more useful way (the default) than the vi-compatible manner.
set nocompatible
scriptencoding utf-8 " Help Vim use the correct character encoding for this script.

" Pathogen, manage your runtimepath.
filetype off
call pathogen#helptags()
call pathogen#infect()

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
set noinfercase  " DO NOT adjust case of match/inserted text depending on context.

set showtabline=2

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
" Only complete the common part and display a menu if more than one choice.
set completeopt=longest,menu

set modeline
set modelines=5    " Default numbers of lines to read for modeline instructions.

set spell " Turn on spell checking by default
set spellfile=$HOME/.vim/spell/en.utf-8.add,$HOME/.vim/spell/bg.utf-8.add
set spelllang=en,bg

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

set virtualedit=block          " Visual mode with bounds outside the actual text.

set guioptions=                " No GUI.
set hlsearch                   " Highlight the last used search pattern.
set cursorline!                " Highlight line under cursor.

set textwidth=120              " Gutter position.
set colorcolumn=+0             " Use an offset from &textwidth.

set listchars=tab:→\ ,eol:§    " Display a placeholder character for tabs and newlines.

set matchpairs+=<:> " Balance HTML tags.

set backup   " Keep backups of files in case we mess up.
set backupdir=$HOME/.vim/backup

set undofile " Keep undo files for cross-session edits.
set undodir=$HOME/.vim/undo

set directory=/tmp,. " Store swap files in /tmp if possible.

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/* " Ignore rules for Vim and plug-ins.
set wildignorecase " Case is ignored when completing file names and directories. Does not apply when the shell is used.

set sessionoptions=blank,buffers,curdir,folds,tabpages,slash,unix " Session Handling.

set tags=.tags,./.tags,~/.vim/tags " Tags can be stored against a project, next to a file or globally.

set switchbuf=usetab,newtab

set shell=/bin/bash

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
  set mousehide " Hide mouse after chars typed
endif

" Syntax highlight shell scripts as per POSIX, not the original Bourne shell which very few use.
let g:is_posix = 1

" Use our customised `grep` script for powerful searches.
set grepprg=$HOME/bin/search\ $*
set grepformat=%f:%l:%m

command! -nargs=+ -complete=dir Search if len([<f-args>]) |
      \ execute 'silent grep! ' . <q-args> |
      \ botright copen 8 |
      \ redraw! |
      \ endif

" Add useful mappings in quick-fix buffers (:copen, :lopen, etc.)
if has('autocmd')
  autocmd FileType qf nnoremap <buffer> <C-T> ^:wincmd gF<CR> |
        \ nnoremap <buffer> t ^:wincmd gF<CR> |
        \ nnoremap <buffer> <silent> q :cclose<CR>:lclose<CR>
endif

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

" IDE goodness.

" When using <C-{N,P}>, always select the {first,last} item in the pop-up menu.
inoremap <expr> <C-N> pumvisible() ? '<C-N>' : '<C-N><C-R>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <C-P> pumvisible() ? '<C-P>' : '<C-P><C-R>=pumvisible() ? "\<lt>Up>" : ""<CR>'

" When a special key is typed, if the pop-up menu is visible, complete the selected item first.
for s:CompleteCloseKey in ['(', ')', '[', ']', '{', '}', "'", '"', ',', '.', ':', ';', '-', '\', '<Space>']
  exe 'imap  <expr> ' . s:CompleteCloseKey . " pumvisible() ? '<C-Y>" . (s:CompleteCloseKey == "'" ? "''" : s:CompleteCloseKey)  . "' : '" . (s:CompleteCloseKey == "'" ? "''" : s:CompleteCloseKey) . "'"
endfor

" Alias <C-Space> to <C-N> in GUI/terminal.
if has("gui_running")
  imap <C-Space> <C-X><C-O>
else
  imap <Nul> <C-X><C-O>
endif

" Use omni-completion (if available) then keyword completion, if the former fails.
inoremap <expr> <C-X><C-O> '<C-R>=exists("+omnifunc") && &omnifunc != "" ? "\<C-X>\<C-O>" : ""<CR><C-R>=pumvisible() ? "" : "\<lt>Esc>a\<lt>C-N>"<CR><C-R>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" If the pop-up menu is visible, close it without inserting a new line.
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<C-G>u\<CR>"

" I mistype <C-[> often when trying to get out on INSERT mode and save the buffer, try and be helpful.
imap [<CR> <Esc><Return>

" God mode.
noremap  <Up>    <NOP>
inoremap <Up>    <NOP>
noremap  <Down>  <NOP>
inoremap <Down>  <NOP>
noremap  <Left>  <NOP>
inoremap <Left>  <NOP>
noremap  <Right> <NOP>
inoremap <Right> <NOP>

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

" Start a new Undo group before making changes in INSERT mode.
inoremap <C-W> <C-G>u<C-W>
inoremap <C-R> <C-G>u<C-R>

" Quickly undo a change (i.e., accidental paste of wrong register) in INSERT mode.
" This overrides the default 'kill-line' on <C-U>.
inoremap <C-U> <C-O>u

" Jump words in INSERT mode.
inoremap <C-H> <C-O>B
inoremap <C-L> <C-O>W

" Quick tab creation and navigation.
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tm :tabmove
nnoremap <expr> <leader>te ':tabedit '

" Tab navigation
nnoremap <silent> <C-J> gt
nnoremap <silent> <C-K> gT

" Reformat a paragraph in NORMAL mode.
nnoremap <leader>q gqip
" Restore last implicit selection (e.g., on paste) in VISUAL mode.
nnoremap <leader>v g`[Vg`]o

" Quick bookmarking and jumping.
" When in NORMAL mode, 'mm' can be used to toggle a bookmark.
" Editing can continue on a new line, etc. and then `` can be used to jump back to the original line/column.
" The default behaviour is to jump back to the previous position which is not very intuitive when multiple jumps happen between edits.
nnoremap `` `m

" Paste/Replace
" -------------
"
" Usage: cp{motion}
"
" The contents of the replaced text are placed in the default register '"'.
"
" Example: cpiw  " paste over the current word.
"
function! PasteReplace(type, ...)
  if ! exists('g:PasteReplaceRegister')
    return
  endif

  let previous_selection = &selection
  let &selection = 'inclusive'

  if a:type == 'line'
    silent exe "normal! '[V']"
  elseif a:type == 'block'
    silent exe "normal! `[\<C-V>`]"
  else
    silent exe "normal! `[v`]"
  endif

  silent exe "normal! \"" . g:PasteReplaceRegister . "P"

  let &selection = previous_selection

endfunction

nnoremap <silent> cp :let g:PasteReplaceRegister=v:register<CR>:set opfunc=PasteReplace<CR>g@

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

nnoremap <silent> <leader>w<Tab>   :setlocal noexpandtab<CR>:retab<CR>:echo 'expandtab'<CR>
nnoremap <silent> <leader>w<Space> :setlocal expandtab<CR>:retab<CR>:echo 'noexpandtab'<CR>

" Evaluate block as expression
vnoremap <C-R> "ac<C-R>=<C-R>a<CR><Esc>vbo

" Snippets keyboard bindings.
" Unix timestamp.
inoremap <leader>iu <C-R>=substitute(system('date +%s'), '\n', '', 'g')<CR>

" Copy entire buffer to X clipboard.
nnoremap <leader>= mZggVG"+yg`Z

" Sort inside a paragraph.
nnoremap <silent> <leader>sip mZvip:sort u<CR>g`Z:echo (line("'>") - line("'<") + 1) . ' line(s) sorted'<CR>

" XML formatting through `xmllint`.
cnoreabbrev xmlformat %!xmllint --format --encode UTF-8 -

" Send file to freedesktop.org trashcan, depends on `trash` command.
command! -bar -bang Trash :
      \ let s:file = fnamemodify(bufname(<q-args>), ':p') |
      \ if isdirectory(s:file) |
      \   echoerr 'Failed to trash "' . s:file . '", the path is a directory.' |
      \ elseif filereadable(s:file) |
      \   execute 'bdelete<bang>' |
      \   call system('trash ' . shellescape(s:file)) |
      \   if ! bufloaded(s:file) && v:shell_error |
      \     echoerr 'Failed to trash "' . s:file . '", exit code "' . string(v:shell_error) . '".' |
      \   endif |
      \ else |
      \   echoerr 'Failed to trash "' . s:file . '", the path is not readable.' |
      \ endif |
      \ unlet s:file

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

" {{{ Tab completion

function! BestComplete()

  " If fizzy.vim has results, use 'completefunc' to complete.
  if exists('g:loaded_fizzy')
    let fizzy_position = fizzy#Complete(1, '')
    if fizzy_position != col('.')
      let fizzy_completions = fizzy#Complete(0, getline('.')[fizzy_position : col('.')])
      if len(fizzy_completions)
        if len(fizzy_completions) > 1
          return "\<C-X>\<C-U>\<C-N>"
        else
          return "\<C-X>\<C-U>\<C-N>\<C-Y>"
        endif
      endif
    endif
  endif

  " If UltiSnips is installed, try to expand as snippet.
  " UltiSnips will insert a <Tab> for us if no snippet was available.
  if exists('*UltiSnips#ExpandSnippet')
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
      if pumvisible()
        return "\<C-Y>"
      else
        call UltiSnips#JumpForwards()
        if g:ulti_jump_forwards_res == 0
          return "\<Tab>"
        endif
      endif
    endif
    return ''
  endif

  return "\<Tab>"
endfunction

inoremap <silent> <Tab> <C-R>=BestComplete()<CR>

" }}}

" Vundle, the plug-in manager for Vim.
call vundle#rc()

" Make broken SSL happy again
let $GIT_SSL_NO_VERIFY='true'

" ---------------------------------------------------------------------------

Plugin 'gmarik/vundle'

" ---------------------------------------------------------------------------

Plugin 'StanAngeloff/vim-zend55'
colorscheme vim-zend55

" ---------------------------------------------------------------------------

Plugin 'ciaranm/detectindent'
" When the correct value for 'expandtab' cannot be determined, it will revert to the default value below.
let g:detectindent_preferred_expandtab=1
if has('autocmd')
  " Attempt to detect indentation for the buffer.
  autocmd BufReadPost * :DetectIndent
endif

" ---------------------------------------------------------------------------

Plugin 'godlygeek/csapprox'

" ---------------------------------------------------------------------------

Plugin 'juvenn/mustache.vim'

" ---------------------------------------------------------------------------

Plugin 'SirVer/ultisnips'

let g:UltiSnipsNoPythonWarning=1

let g:UltiSnipsSnippetDirectories=['UltiSnips']

" Don't let UltiSnips handle the <C-J> and <C-K> keys.
let g:UltiSnipsExpandTrigger='<NOP>'
let g:UltiSnipsJumpForwardTrigger='<NOP>'
let g:UltiSnipsJumpBackwardTrigger='<NOP>'

" Use <C-{J,K}> for navigating the popup menu, if visible.
" Otherwise, delegate to UltiSnips. If that fails, jump lines.
let g:UltiSnipsPreviousPosition = [0, 0, 0]

function! UltiSnipsDidJump(navigation_mode)
  let l:position = getpos('.')
  if g:UltiSnipsPreviousPosition[0] == l:position[0]
\ && g:UltiSnipsPreviousPosition[1] == l:position[1]
\ && g:UltiSnipsPreviousPosition[2] == l:position[2]
    return "\<C-G>u\<C-O>" . a:navigation_mode
  endif
  return ''
endfunction

function! UltiSnipsJump(jump_mode, ultisnips_mode, navigation_mode)
  if pumvisible()
    return a:jump_mode
  endif
  let g:UltiSnipsPreviousPosition = getpos('.')
  return "\<C-R>=UltiSnips#Jump" . a:ultisnips_mode . "()\<CR>\<C-R>=UltiSnipsDidJump('" . a:navigation_mode . "')\<CR>"
endfunction

inoremap <expr> <C-J> UltiSnipsJump("\<C-N>", 'Forwards', 'o')
inoremap <expr> <C-K> UltiSnipsJump("\<C-P>", 'Backwards', 'O')

snoremap <C-J> <Esc>:call UltiSnips#JumpForwards()<CR>
snoremap <C-K> <Esc>:call UltiSnips#JumpBackwards()<CR>

" ---------------------------------------------------------------------------

Plugin 'othree/html5.vim'

" ---------------------------------------------------------------------------

Plugin 'pangloss/vim-javascript'

" ---------------------------------------------------------------------------

Plugin 'scrooloose/nerdcommenter'

" ---------------------------------------------------------------------------

Plugin 'scrooloose/nerdtree'
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

  let b:FastFingersPreviousPosition = getpos('.')

  " Lower the update time so our 'CursorHold' code fires immediately after the search.
  if &ut > g:FastFingersSpeed | let g:FastFingersUpdateTime = &ut | let &ut = g:FastFingersSpeed | endif

  augroup FastFingers
    autocmd CursorHold *
          \ exe 'set ut=' . g:FastFingersUpdateTime |
          \ if exists('b:FastFingersPreviousPosition') && join(getpos('.'), ',') != join(b:FastFingersPreviousPosition, ',') |
          \   if getline(".") =~ g:FastFingersNERDTreeClosed |
          \     call feedkeys('o', 'm') |
          \   endif |
          \ endif |
          \ unlet b:FastFingersPreviousPosition |
          \ augroup FastFingers | execute "autocmd!" | augroup END | augroup! FastFingers
  augroup END

  return a:mode
endfunction

nnoremap <expr> / FastFingersSearch('/')
nnoremap <expr> ? FastFingersSearch('?')

" ---------------------------------------------------------------------------

Plugin 'mbbill/undotree'
nnoremap <silent> <F6> :UndotreeToggle<CR>
let g:undotree_SplitWidth=45
let g:undotree_SetFocusWhenToggle=1

" ---------------------------------------------------------------------------

Plugin 'tpope/vim-fugitive'

" ---------------------------------------------------------------------------

Plugin 'tpope/vim-git'

" ---------------------------------------------------------------------------

Plugin 'tpope/vim-haml'

" ---------------------------------------------------------------------------

Plugin 'tpope/vim-markdown'

" ---------------------------------------------------------------------------

Plugin 'tpope/vim-repeat'

" ---------------------------------------------------------------------------

Plugin 'tpope/vim-surround'

" ---------------------------------------------------------------------------

Plugin 'tpope/vim-unimpaired'

" ---------------------------------------------------------------------------

Plugin 'StanAngeloff/php.vim'
Plugin 'rayburgemeestre/phpfolding.vim'
Plugin '2072/PHP-Indenting-for-VIm'

" Don't use the PHP syntax folding.
let g:DisableAutoPHPFolding = 1
" Include the '$' as part of identifiers.
let php_var_selector_is_identifier = 1

" ---------------------------------------------------------------------------

Plugin 'kien/ctrlp.vim'
let g:ctrlp_map=''
let g:ctrlp_cmd='CtrlPCurWD'
let g:ctrlp_match_window_reversed=0
let g:ctrlp_max_height=20
let g:ctrlp_highlight_match=[1, 'Search']
let g:ctrlp_max_files=64000
let g:ctrlp_max_depth=24
let g:ctrlp_cache_dir='/tmp/.ctrlp'

nnoremap <silent> <leader>o :<C-U>CtrlPCurWD<CR>

let g:ctrlp_user_command = {
      \     'types': {
      \         1: ['.git', 'cd %s && git ls-files --exclude-standard --cached --others'],
      \     },
      \ }

" ---------------------------------------------------------------------------

Plugin 'JazzCore/ctrlp-cmatcher'
if filereadable(expand('~/.vim/bundle/ctrlp-cmatcher/autoload/fuzzycomt.so'))
  let g:ctrlp_match_func = { 'match': 'matcher#cmatch' }
  let g:ctrlp_max_files = 0
else
  echohl WarningMsg | echom 'You need to compile the CtrlP C matching extension.' | echohl None
endif

" ---------------------------------------------------------------------------

Plugin 'thinca/vim-visualstar'

" ---------------------------------------------------------------------------

Plugin 'tpope/vim-abolish'

" ---------------------------------------------------------------------------

Plugin 'bling/vim-airline'

let g:airline_theme='grey'

let g:airline_powerline_fonts=1

let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_branch_prefix = '⭠ '
let g:airline_readonly_symbol = '⭤ '
let g:airline_linecolumn_prefix = '⭡'
let g:airline_paste_symbol = 'ρ'

" ---------------------------------------------------------------------------

Plugin 'hail2u/vim-css3-syntax'

" ---------------------------------------------------------------------------

Plugin 'tpope/vim-eunuch'

" ---------------------------------------------------------------------------

Plugin 'benmills/vimux'
nnoremap <silent> <F5>      :w<CR>:VimuxRunLastCommand<CR>
inoremap <silent> <F5> <Esc>:w<CR>:VimuxRunLastCommand<CR>a

" ---------------------------------------------------------------------------

Plugin 'AutoTag'

let g:autotagmaxTagsFileSize=32 * 1024 * 1024
let g:autotagTagsFile='.tags'
let g:autotagVerbosityLevel=0
let g:autotagCtagsCmd='silent ctags'

" ---------------------------------------------------------------------------

Plugin 'scrooloose/syntastic'

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }

let g:syntastic_warning_symbol='W>'
let g:syntastic_style_warning_symbol='s>'

let g:syntastic_error_symbol='E>'
let g:syntastic_style_error_symbol='S>'

" Check for syntax errors.
nnoremap <silent> <F9>      :w<CR>:SyntasticCheck<CR>
inoremap <silent> <F9> <Esc>:w<CR>:SyntasticCheck<CR>a

" ---------------------------------------------------------------------------

Plugin 'elzr/vim-json'

" Set this variable as vim-json barfs if it's not defined.
let g:vim_json_warnings=1

" ---------------------------------------------------------------------------

Plugin 'jistr/vim-nerdtree-tabs'

let g:nerdtree_tabs_open_on_new_tab=0
let g:nerdtree_tabs_focus_on_files=1

function! CloseNERDTreeInTab(i)
  let l:me = tabpagenr()
  let l:previous_ei = &ei
  set ei=all

  exec 'tabnext ' . a:i
  call nerdtree#closeTreeIfOpen()
  exec 'tabnext ' . l:me

  let &ei = l:previous_ei
endfunction

function! ToggleNERDTree()
  let l:me = tabpagenr()
  for i in range(1, tabpagenr('$'))
    if i != l:me
      call CloseNERDTreeInTab(i)
    endif
  endfor

  " If NERDTree is visible and inactive in the current tab, focus.
  if (nerdtree#treeExistsForTab() && nerdtree#getTreeWinNum() != -1) && ! nerdtree#treeExistsForBuf()
    execute 'silent! NERDTreeFocus'
  else
    execute 'silent! NERDTreeMirrorToggle'
  endif
endfunction

nnoremap <silent> <Tab> :call ToggleNERDTree()<CR>

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

" ---------------------------------------------------------------------------

Plugin 'mhinz/vim-signify'

let g:signify_vcs_list = ['git', 'hg']

let g:signify_sign_change = '*'

" ---------------------------------------------------------------------------

Plugin 'tommcdo/vim-exchange'

" ---------------------------------------------------------------------------

Plugin 'tommcdo/vim-fugitive-blame-ext'

" ---------------------------------------------------------------------------

Plugin 'StanAngeloff/fizzy.vim'

" ---------------------------------------------------------------------------

Plugin 'eclim', { 'pinned': 1 }

" eclim options.
let g:EclimPhpSearchSingleResult = 'lopen'

let g:EclimFileTypeValidate = 0

let g:EclimShowQuickfixSigns = 0
let g:EclimShowLoclistSigns = 0

let g:EclimCssIndentDisabled = 0
let g:EclimDtdIndentDisabled = 0
let g:EclimHtmlIndentDisabled = 0
let g:EclimHtmldjangoIndentDisabled = 0
let g:EclimHtmljinjaIndentDisabled = 0
let g:EclimJavascriptIndentDisabled = 0
let g:EclimPhpIndentDisabled = 0
let g:EclimXmlIndentDisabled = 0

let EclimShowCurrentError = 0

let g:EclimCompletionMethod = 'omnifunc'
