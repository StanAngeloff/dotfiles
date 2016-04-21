" Make Vim behave in a more useful way (the default) than the vi-compatible manner.
set nocompatible
scriptencoding utf-8 " Help Vim use the correct character encoding for this script.

filetype off

" Source machine-specific local configuration.
let s:localrc=$HOME . '/.vimrc_' . hostname()
if filereadable(s:localrc)
  execute 'source ' . s:localrc
endif
unlet s:localrc

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
set infercase  " Adjust case of match/inserted text depending on context.

set showtabline=2

set backspace=indent,eol,start " Backspace wraps at start- and end-of-line.
set tabstop=4                  " Default number of spaces per tab character.
set softtabstop=4              " Tab size during editing operation.
set shiftwidth=4               " Default tab size.
set shiftround                 " Round indent to multiple of 'shiftwidth'. Applies to > and < commands.
set expandtab                  " Expand tab into spaces.
set wrap                       " OK, let's try and wrap long lines for a change?
set autoindent                 " Auto-indent new lines.

set timeoutlen=325             " Time to wait after ESC (default causes an annoying delay).
set ttimeoutlen=10

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

if ! has('nvim') " Neovim? See https://github.com/neovim/neovim/issues/2253
  set lazyredraw   " Do not redraw while running macros (much faster).
endif
set ttyfast        " Enable fast-terminal.
if exists('&ttyscroll') " Neovim?
  set ttyscroll=10 " Prefer full redraws for smaller scroll regions.
endif

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

set listchars=tab:→\ ,eol:¬,extends:❯,precedes:❮  " Display a placeholder character for tabs and newlines.
set showbreak=↪

set matchpairs+=<:> " Balance HTML tags.

" Customise the fill characters.
set fillchars+=vert:│,fold:┄

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

set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
  set mousehide " Hide mouse after chars typed
endif

" Syntax highlight shell scripts as per POSIX, not the original Bourne shell which very few use.
let g:is_posix = 1

" When editing SQL files, don't add default mappings for sqlcomplete. These mess up <C-C>
let g:omni_sql_no_default_maps = 1

" Use our customised `grep` script for powerful searches.
set grepprg=pt\ --hidden\ --nogroup\ --nocolor\ --column\ --smart-case\ -e
set grepformat=%f:%l:%c:%m

command! -nargs=+ -complete=file -bar Search if len([<f-args>]) |
      \ execute 'silent! lgrep! ' . <q-args> |
      \ botright lopen 8 | set nowrap |
      \ redraw! |
      \ endif

" Add useful mappings in quick-fix buffers (:copen, :lopen, etc.)
if has('autocmd')
  autocmd FileType qf nnoremap <buffer> <C-T> ^<C-W>gF |
        \ nnoremap <buffer> t ^<C-W>gF |
        \ nnoremap <buffer> <silent> q :cclose<CR>:lclose<CR>
endif

" Use a custom leader character.
let mapleader = ','

" Keep the legacy leader around for a while.
nmap \ <leader>
vmap \ <leader>

" Keyboard bindings.
nnoremap <silent> j gj
nnoremap <silent> k gk

vnoremap <silent> j gj
vnoremap <silent> k gk

" Make Y consistent with C and D. See ':help Y'.
nnoremap Y y$

" Copy to & paste from the system clipboard.
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

" OMG! This is sooo much better.
" nnoremap <Space> :
nnoremap <Return> :w<CR>

" vnoremap <Space> :
vnoremap <Return> :<C-U>w<CR>gv

" Don't jump on search.
nnoremap * *<C-O>
nnoremap # #<C-O>

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

" I don't mistype <C-[> very often these days... but used to when trying to get out on INSERT mode and save the buffer.
" imap [<CR> <Esc><Return>

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
vnoremap $ g_

" Alias H and L to more useful commands, easier to type than their counterparts.
nnoremap H g^
vnoremap H g^

nnoremap L g$
vnoremap L g$

" Q for 'Q'uit, 'Ex' mode has received zero use.
nnoremap <silent> Q :windo normal ZZ<CR>
vnoremap <silent> Q <Esc>:windo normal ZZ<CR>

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

  silent exe "normal \"" . g:PasteReplaceRegister . "P"

  let &selection = previous_selection

endfunction

nnoremap <silent> cp :let g:PasteReplaceRegister=v:register<CR>:setlocal opfunc=PasteReplace<CR>g@

" Erase trailing whitespace function and keyboard binding.
function! StripTrailingWhitespace()
  let l:previousPosition = getpos('.')
  let l:previousSearch = @/
  %s/\s\+$//e
  let @/ = l:previousSearch
  call setpos('.', l:previousPosition)
endfunction

nnoremap <silent> <leader>W :call StripTrailingWhitespace()<CR>

" Turn off active highlighting, reset signs and plug-ins.
nnoremap <silent> <leader><Space> :noh<CR>:sign unplace *<CR>:SyntasticReset<CR>

" Toggle spell-checking keyboard binding.
noremap <silent> <F1> :setlocal nospell! nospell?<CR>
" Toggle paste-mode keyboard binding.
nnoremap <silent> <F2> :setlocal invpaste paste?<CR>
set pastetoggle=<F2>
" Toggle long line wrap.
nnoremap <silent> <F3> :setlocal wrap! wrap?<CR>
" Toggle display of placeholder characters for tabs and newlines.
nnoremap <silent> <F4> :setlocal list! list?<CR>

" Synstack {{{

" Show the stack of syntax highlighting classes affecting whatever is under the cursor.
function! SynStack()
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
endfunc

nnoremap <F7> :call SynStack()<CR>

" }}}

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
inoremap <leader>time <C-R>=substitute(system('date +%s'), '\n', '', 'g')<CR>

" Copy entire buffer to X clipboard.
nnoremap <leader>= mZggVG"+yg`Z

" Sort inside a paragraph.
nnoremap <silent> <leader>sip mZvip:sort u<CR>g`Z:echo (line("'>") - line("'<") + 1) . ' line(s) sorted'<CR>

" XML formatting through `xmllint`.
cnoreabbrev xmlformat %!xmllint --format --encode UTF-8 -

" Send file to freedesktop.org trashcan, depends on `trash` command.
function! Trash(path)
  call system('trash ' . shellescape(a:path))
  if v:shell_error != 0
    if isdirectory(a:path)
      throw "Trash.PathDeletionError: Could not trash directory: '" . a:path . "'."
    elseif filereadable(a:path)
      throw "Trash.FileDeletionError: Could not trash file '" . a:path . "'."
    else
      throw "Trash.UnknownDeletionError: Could not trash path '" . a:path . "', the path is not readable."
    endif
  endif
  let bufnum = bufnr('^' . a:path . '$')
  if buflisted(bufnum)
    execute 'bwipeout! ' . bufnum
  endif
endfunction!

command! -bar -bang Trash call Trash(fnamemodify(bufname(<q-args>), ':p'))

" {{{ Zeal documentation search

" Why QT_QPA_PLATFORMTHEME? See https://github.com/jkozera/zeal/issues/172#issuecomment-57289916
nnoremap gz :call system('QT_QPA_PLATFORMTHEME=gnome zeal --query ' . shellescape(expand('<cword>')) . ' &')<CR>

" }}}

if has("gui_running")
  set guifont=Inconsolata\ for\ Powerline\ 14
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

  " Recognise additional types.
  au BufRead,BufNewFile {Gemfile,Guardfile,Rakefile,*.rake,config.ru} set ft=ruby
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

  " Open help windows on the right in a vertical split, credits @EvanPurkhiser.
  autocmd FileType help nnoremap <buffer> <silent> q :bwipeout<CR> |
        \ wincmd L

endif

" {{{ Tab completion

function! BestComplete()

  if pumvisible()
    return "\<C-N>"
  endif

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
        if g:ulti_jump_forwards_res != 0
          return ''
        endif
      endif
    else
      return ''
    endif
  endif

  " If the character immediately before the column is not a whitespace, trigger completion.
  let l:before = getline('.')[:col('.') - 1]
  if l:before =~ '\S$'
    call feedkeys("\<C-G>u\<C-X>\<C-O>", 'm')
    return ''
  endif

  return "\<Tab>"
endfunction

inoremap <silent> <Tab> <C-R>=BestComplete()<CR>

" }}}

" vim-plug: Minimalist Vim Plugin Manager.
call plug#begin('~/.vim/plugged')

" Make broken SSL happy again
let $GIT_SSL_NO_VERIFY='true'

" ---------------------------------------------------------------------------

Plug 'StanAngeloff/vim-zend55'

" ---------------------------------------------------------------------------

Plug 'tpope/vim-sleuth'

" ---------------------------------------------------------------------------

Plug 'godlygeek/csapprox'

" Don't override 'italic' with 'underline', urxvt handles it just fine.
let g:CSApprox_attr_map = { 'sp' : 'fg' }

" Clear the background of the Normal and NonText groups,
" forcing the terminal's default background color to be used instead,
" including any pseudo-transparency done by that terminal emulator.
let g:CSApprox_Zend55_hook_post = [
      \ 'hi Normal  ctermbg=NONE ctermfg=NONE',
      \ 'hi NonText ctermbg=NONE ctermfg=238 " blank lines get a darker foreground.',
      \ ]

" ---------------------------------------------------------------------------

Plug 'juvenn/mustache.vim', { 'for': ['mustache', 'handlebars', 'hbs', 'hogan', 'hulk', 'hjs'] }

" ---------------------------------------------------------------------------

Plug 'SirVer/ultisnips'

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

Plug 'othree/html5.vim'

" ---------------------------------------------------------------------------

Plug 'pangloss/vim-javascript'

" ---------------------------------------------------------------------------

Plug 'scrooloose/nerdcommenter'

" ---------------------------------------------------------------------------

Plug 'scrooloose/nerdtree', { 'commit': 'ee4d42cf' }

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

" Be safe!
let NERDTreeRemoveDirCmd='trash '

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
          \ if exists('b:FastFingersPreviousPosition') |
          \   if join(getpos('.'), ',') != join(b:FastFingersPreviousPosition, ',') |
          \     if getline(".") =~ g:FastFingersNERDTreeClosed |
          \       call feedkeys('o', 'm') |
          \     endif |
          \   endif |
          \   unlet b:FastFingersPreviousPosition |
          \ endif |
          \ augroup FastFingers | execute "autocmd!" | augroup END | augroup! FastFingers
  augroup END

  return a:mode
endfunction

nnoremap <expr> / FastFingersSearch('mm/')
nnoremap <expr> ? FastFingersSearch('mm?')

" XML folding via syntax
" See http://www.jroller.com/lmchung/entry/xml_folding_with_vim
let g:xml_syntax_folding=1
autocmd FileType xml setlocal foldmethod=syntax

" ---------------------------------------------------------------------------

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
nnoremap <silent> <F6> :UndotreeToggle<CR>
let g:undotree_SplitWidth=45
let g:undotree_SetFocusWhenToggle=1

" ---------------------------------------------------------------------------

Plug 'tpope/vim-fugitive'

nnoremap <leader>ha :silent! Git add %<CR>:redraw!<CR>

" ---------------------------------------------------------------------------

Plug 'tpope/vim-git'

" ---------------------------------------------------------------------------

Plug 'tpope/vim-haml', { 'for': ['haml', 'hamlbars', 'hamlc', 'sass', 'scss'] }

" ---------------------------------------------------------------------------

Plug 'tpope/vim-markdown', { 'for': ['markdown', 'md', 'mdown', 'mkd', 'mkdn'] }

" ---------------------------------------------------------------------------

Plug 'tpope/vim-repeat'

" ---------------------------------------------------------------------------

Plug 'tpope/vim-surround'

" ---------------------------------------------------------------------------

Plug 'tpope/vim-unimpaired'

" ---------------------------------------------------------------------------

Plug 'StanAngeloff/php.vim'
Plug 'rayburgemeestre/phpfolding.vim'
Plug '2072/PHP-Indenting-for-VIm'

" Don't use the PHP syntax folding.
let g:DisableAutoPHPFolding = 1
" Include the '$' as part of identifiers.
let php_var_selector_is_identifier = 1
" Indent 'case:' and 'default:' statements in switch() blocks:
let g:PHP_vintage_case_default_indent = 1

" ---------------------------------------------------------------------------

Plug 'kien/ctrlp.vim', { 'on': 'CtrlPCurWD' }
let g:ctrlp_map=''
let g:ctrlp_cmd='CtrlPCurWD'
let g:ctrlp_match_window_reversed=0
let g:ctrlp_max_height=20
let g:ctrlp_highlight_match=[1, 'Search']
let g:ctrlp_max_files=64000
let g:ctrlp_max_depth=24
let g:ctrlp_cache_dir='/tmp/.ctrlp'

nnoremap <silent> <leader>o :let g:ctrlp_default_input = ''<CR>:<C-U>CtrlPCurWD<CR>
vnoremap <silent> <leader>o :<C-U>let g:ctrlp_default_input = @*<CR>:<C-U>CtrlPCurWD<CR><C-\>v
nnoremap <silent> <leader>0 :let g:ctrlp_default_input = expand('<cword>')<CR>:<C-U>CtrlPCurWD<CR>

let g:ctrlp_user_command = {
      \     'types': {
      \         1: ['.git', 'cd %s && git ls-files --exclude-standard --cached --others'],
      \     },
      \ }

" ---------------------------------------------------------------------------

Plug 'nixprime/cpsm', { 'do': './install.sh' }

if filereadable(expand('~/.vim/plugged/cpsm/autoload/cpsm_py.so'))
  let g:ctrlp_match_func = { 'match': 'cpsm#CtrlPMatch' }
  let g:ctrlp_max_files = 0
else
  echohl WarningMsg | echom 'You need to compile the CtrlP matching extension.' | echohl None
endif

" ---------------------------------------------------------------------------

Plug 'thinca/vim-visualstar'

" ---------------------------------------------------------------------------

Plug 'tpope/vim-abolish'

" ---------------------------------------------------------------------------

Plug 'bling/vim-airline'

let g:airline_theme='grey'

let g:airline_left_sep = "\ue0b0"
let g:airline_left_alt_sep = "\ue0b1"
let g:airline_right_sep = "\ue0b2"
let g:airline_right_alt_sep = "\ue0b3"

let g:airline_symbols = {
      \ 'branch': "\ue0a0",
      \ 'linenr': "\ue0a1",
      \ 'readonly': "\ue0a2",
      \ 'paste': 'ρ'
      \ }

" Suppress deprecation warning about themes.
let g:loaded_airline_themes = 0

" ---------------------------------------------------------------------------

Plug 'hail2u/vim-css3-syntax'

" ---------------------------------------------------------------------------

Plug 'tpope/vim-eunuch'

" ---------------------------------------------------------------------------

Plug 'benmills/vimux'
nnoremap <silent> <F5>      :w<CR>:VimuxRunLastCommand<CR>
inoremap <silent> <F5> <Esc>:w<CR>:VimuxRunLastCommand<CR>a

" ---------------------------------------------------------------------------

Plug 'AutoTag'

let g:autotagmaxTagsFileSize=32 * 1024 * 1024
let g:autotagTagsFile='.tags'
let g:autotagVerbosityLevel=0
let g:autotagCtagsCmd='silent ctags'

" ---------------------------------------------------------------------------

Plug 'scrooloose/syntastic'

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }

let g:syntastic_warning_symbol='W>'
let g:syntastic_style_warning_symbol='s>'

let g:syntastic_error_symbol='E>'
let g:syntastic_style_error_symbol='S>'

" Check for syntax errors.
nnoremap <silent> <F9>      :w<CR>:SyntasticCheck<CR>
inoremap <silent> <F9> <Esc>:w<CR>:SyntasticCheck<CR>a

" ---------------------------------------------------------------------------

Plug 'elzr/vim-json'

" Set this variable as vim-json barfs if it's not defined.
let g:vim_json_warnings=1
let g:vim_json_syntax_conceal=0

autocmd FileType json setlocal foldmethod=syntax

" ---------------------------------------------------------------------------

Plug 'jistr/vim-nerdtree-tabs'

let g:nerdtree_tabs_open_on_new_tab=0
let g:nerdtree_tabs_focus_on_files=1

function! CloseNERDTreeInTab(i)
  let l:me = tabpagenr()
  let l:previous_ei = &ei
  set ei=all

  exec 'tabnext ' . a:i
  if g:NERDTree.IsOpen()
    call g:NERDTree.Close()
  endif
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
  if (g:NERDTree.ExistsForTab() && g:NERDTree.GetWinNum() != -1) && ! g:NERDTree.ExistsForBuf()
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

Plug 'airblade/vim-gitgutter'

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_max_signs = 9999

hi def link GitGutterAdd DiffAdd
hi def link GitGutterChange DiffChange
hi def link GitGutterDelete DiffDelete
hi def link GitGutterChangeDelete DiffChange

" ---------------------------------------------------------------------------

Plug 'tommcdo/vim-fugitive-blame-ext'

" ---------------------------------------------------------------------------

Plug 'StanAngeloff/fizzy.vim'

" ---------------------------------------------------------------------------

Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" ---------------------------------------------------------------------------

Plug 'tpope/vim-cucumber', { 'for': ['feature', 'story'] }

" ---------------------------------------------------------------------------

Plug 'chase/vim-ansible-yaml'

" ---------------------------------------------------------------------------

Plug 'kchmck/vim-coffee-script'

" ---------------------------------------------------------------------------

Plug 'hashivim/vim-hashicorp-tools'

" ---------------------------------------------------------------------------

Plug 'jwalton512/vim-blade'

" ---------------------------------------------------------------------------

call plug#end()

colorscheme vim-zend55

if has('autocmd')

  " Highlight trailing whitespace in red after the colour scheme has loaded.
  autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
        \ | highlight        ExtraWhitespace ctermbg=red guibg=red

endif

" Cheatsheet
"
" List of commands that I tend to forget, but need to learn:
"
" gi    Insert text in the same position as where Insert mode
"       was stopped last time in the current buffer.
"       This uses the |'^| mark. [..]
"
