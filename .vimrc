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
if $TERM =~ '256color|kitty'
  " Disable Background Color Erase (BCE) so that color schemes render properly when inside 256-color tmux and GNU screen.
  " See also http://sunaku.github.io/vim-256color-bce.html
  let &t_ut=''
endif
if !has("gui_running")
  set t_Co=256
end

" Switch syntax on and select a theme.
syntax on

set synmaxcol=20480
syntax sync minlines=2048

set termguicolors

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" See https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-shape-in-the-terminal
"
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

au VimLeave * set guicursor=a:block-blinkon0

" Use UTF-8 and Unix line-endings for new files.
set encoding=utf-8
set fileformats=unix,mac,dos

set history=1024
set undolevels=2048

set maxmempattern=10240

set hidden     " Don't dispose buffers, hide them.
set ruler      " Show the cursor position all the time.
set showcmd    " Display incomplete commands.
set showmode   " Display Vim mode, e.g., INSERT, REPLACE, etc.
set incsearch  " Do incremental searching.
set ignorecase " Lowercase matches all.
set smartcase  " Uppercase matches uppercase only.
set noinfercase " Adjust case of match/inserted text depending on context.
set nostartofline " Don't move the cursor to the first non-blank character of a line.

set showtabline=2

set inccommand=nosplit

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

" set clipboard+=unnamed         " Yank to clipboard.

" 'i' is avoided as it can be extremely slow on large trees.
set complete-=i
" Only complete the common part and display a menu if more than one choice.
set completeopt=longest,menuone

set modeline
set modelines=5    " Default numbers of lines to read for modeline instructions.

set spell " Turn on spell checking by default
set spellfile=$HOME/.vim/spell/en.utf-8.add,$HOME/.vim/spell/bg.utf-8.add
set spelllang=en,bg

set scrolloff=120  " Scroll when lots of lines from edge of screen. Bigger numbers work better with ':help rnu'.
set rnu            " Show the line number relative to the line with the cursor in front of each line.

" This I really DO NOT LIKE being forced to use.
set updatetime=100

set lazyredraw     " Do not redraw while running macros (much faster).
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
set signcolumn=auto:2          " Allow up to two signs per line.

set nolist
set listchars=tab:→\ ,eol:¬,extends:❯,precedes:❮,trail:␣  " Display a placeholder character for tabs and newlines.
set showbreak=↪

set display+=uhex

set matchpairs+=<:> " Balance HTML tags.
set showmatch
set matchtime=1

" Customise the fill characters.
set fillchars+=vert:│,fold:┄

set backup   " Keep backups of files in case we mess up.
set backupcopy=yes
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

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Use a custom leader character.
let mapleader = ','

" Keep the legacy leader around for a while.
nmap \ <leader>
vmap \ <leader>

function! RgProject(visual)
  if a:visual == 1
    try
      let z_save = @z
      normal! gv"zy
      let l:query = escape(escape(substitute(@z, '^\s\+\|\s\+$', '', 'g'), '\'), '^$ ()[]{}?*+\')
    finally
      let @z = z_save
    endtry
  else
    call inputsave()
    let l:query = escape(input('Rg: ', '', 'tag_listfiles'), ' \')
    call inputrestore()
  endif

  if len(l:query)
    execute "normal! :Rg " . l:query . "\<CR>"
  endif
endfunction

nnoremap <leader>S :call RgProject(0)<CR>
vnoremap <leader>S :call RgProject(1)<CR>

" Add useful mappings in quick-fix buffers (:copen, :lopen, etc.)
if has('autocmd')
  autocmd FileType qf nnoremap <buffer> <C-T> ^<C-W>gF |
        \ nnoremap <buffer> t ^<C-W>gF |
        \ nnoremap <buffer> <silent> q :cclose<CR>:lclose<CR>
endif

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

" Frantic <C-S> are now hectic <Return>s
nnoremap <Return> :w<CR>

" vnoremap <Space> :
vnoremap <Return> :<C-U>w<CR>gv

" Don't jump on search.
nnoremap * mZ*`Z
nnoremap # mZ#`Z

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
nnoremap <silent> <leader><Space> :noh<CR>:sign unplace *<CR>:call clearmatches()<CR>

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

" Copy entire buffer to X clipboard.
nnoremap <leader>= mZggVG"+yg`Z

" Sorting like a pro!
nnoremap <silent> <leader>sip mZvip:sort u<CR>g`Z:echo (line("'>") - line("'<") + 1) . ' line(s) sorted'<CR>
nnoremap <silent> <leader>si{ mZvi{:sort u<CR>g`Z:echo (line("'>") - line("'<") + 1) . ' line(s) sorted'<CR>
nnoremap <silent> <leader>si[ mZvi[:sort u<CR>g`Z:echo (line("'>") - line("'<") + 1) . ' line(s) sorted'<CR>

vnoremap <leader>s :sort u<CR>gv

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

  " Turn off beep sounds.
  autocmd VimEnter * set vb t_vb=

  " Recognise additional types.
  au BufRead,BufNewFile {Gemfile,Guardfile,Rakefile,*.rake,config.ru} set ft=ruby
  au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown
  au BufRead,BufNewFile {COMMIT_EDITMSG} set ft=gitcommit
  au BufRead,BufNewFile {.babelrc,.watchmanconfig} set ft=json
  au BufRead,BufNewFile {.flowconfig} set ft=dosini

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

  " If we are expanding an inline comment, leave insert mode to trigger navigation.
  if get(g:, 'PhpBestExpandCommentInsertLeaveOccurrence', 0) == 1
    return "\<Esc>i"
  endif

  " If the character immediately before the column is not a whitespace, trigger completion.
  let l:before = getline('.')[:col('.') - 2]
  if col('.') > 1 && l:before =~ '\S$'
    call feedkeys("\<C-G>u\<C-X>\<C-O>", 'm')
    return ''
  endif

  return "\<Tab>"
endfunction

inoremap <silent> <Tab> <C-R>=BestComplete()<CR>

inoremap <expr> <C-J> pumvisible() ? '<C-N>' :
            \ (get(g:, 'PhpBestExpandCommentInsertLeaveOccurrence', 0) == 1 ? '<Esc>i' : '<C-O>o')
inoremap <expr> <C-K> pumvisible() ? '<C-P>' : '<C-O>O'

" }}}

" See https://vimrcfu.com/snippet/143
"
command! Ltabs call OpenAllFromLocationList()
command! Qtabs call OpenAllFromQuickfix()

function! OpenAllFromLocationList()
    call s:OpenAllFromList(getloclist(0))
endfunction

function! OpenAllFromQuickfix()
    call s:OpenAllFromList(getqflist())
endfunction

function! s:OpenAllFromList(fromList)
    let files = {}
    for entry in a:fromList
        let filename = bufname(entry.bufnr)
        let files[filename] = 1
    endfor

    if len(files) < 1
        return
    endif

    for file in keys(files)
        silent exe 'tabedit ' . file
    endfor

    silent exe 'tabprevious' . len(files)
endfunction

" vim-plug: Minimalist Vim Plugin Manager.
call plug#begin('~/.vim/plugged')

" Make broken SSL happy again
let $GIT_SSL_NO_VERIFY='true'

" ---------------------------------------------------------------------------

Plug 'editorconfig/editorconfig-vim'

" ---------------------------------------------------------------------------

Plug 'StanAngeloff/vim-zend55'

" FZF {{{1 ------------------------------------------------------------------

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

let g:fzf_layout = { 'down': 20 }
let g:fzf_buffers_jump = 1
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_action = {
            \ 'enter': 'tabedit',
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit'
            \ }

function! RgShellEscape(...)
  return join(map(deepcopy(a:000), 'shellescape(v:val)'), ' ')
endfunction

command! -bang -nargs=* Rg call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --color=always ' . RgShellEscape(<f-args>),
      \ 1,
      \ <bang>0 ? fzf#vim#with_preview({ 'options': '--color=dark' }, 'bottom:20', '?') : fzf#vim#with_preview({ 'options': '--color=dark' }, 'right:50%:hidden', '?'),
      \ <bang>0
      \ )

function! FzfCacheFile()
  return '/tmp/.fzf_cache__@' . substitute(fnamemodify(getcwd(), ':p:gs?/?@?'), '^@\|@$', '', 'g')
endfunction

command! -bang -nargs=? -complete=dir FzfFiles call fzf#vim#files(<q-args>, <bang>0)

let g:fzf_cache_file_cmd="\"/tmp/.fzf_cache__`pwd | tr / @`\""
let $FZF_DEFAULT_COMMAND='[ -f ' . g:fzf_cache_file_cmd . ' ] && cat ' . g:fzf_cache_file_cmd . ' || ' . $FZF_DEFAULT_COMMAND . ' | tee ' . g:fzf_cache_file_cmd

autocmd VimLeave * call delete(FzfCacheFile())

autocmd! FileType fzf
autocmd  FileType fzf setlocal laststatus=0 nosmd noru nornu
      \ | tnoremap <silent> <F5> <C-\><C-n>:call delete(FzfCacheFile())<CR>:call feedkeys("a\<lt>Esc>", 'm')<CR>
      \ | tnoremap <silent> <F4> <M-a><C-\><C-n>:call feedkeys("a\<lt>C-T>", 'm')<CR>
      \ | autocmd BufLeave <buffer> set laststatus=2 smd ru rnu

nnoremap <silent>        <leader>o  :<C-U>FzfFiles<CR>
nnoremap <silent> <expr> <leader>0 ':<C-U>FzfFiles<CR>' . expand('<cword>')

function! FzfFilesFromVisual()
  try
    let z_save = @z
    normal! gv"zy
    let l:query = substitute(tolower(substitute(substitute(@z, '^\s\+\|\s\+$', '', 'g'), '^[,;]\+\|[,;]\+$', '', 'g')), '\\', '/', 'g')
  finally
    let @z = z_save
  endtry

  execute "normal! :\<C-U>FzfFiles\<CR>"
  call feedkeys(l:query, 'm')
endfunction

vnoremap <silent> <leader>o :call FzfFilesFromVisual()<CR>
vnoremap <silent> <leader>0 :call FzfFilesFromVisual()<CR>

" }}}1 ----------------------------------------------------------------------

Plug 'tpope/vim-sleuth'

let g:sleuth_automatic = 1

" ---------------------------------------------------------------------------

Plug 'juvenn/mustache.vim', { 'for': ['mustache', 'handlebars', 'hbs', 'hogan', 'hulk', 'hjs'] }

" ---------------------------------------------------------------------------

Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim'

let g:user_emmet_mode='iv'
let g:user_emmet_install_global=0

let g:user_emmet_leader_key=','

autocmd FileType html,blade,liquid EmmetInstall

" ---------------------------------------------------------------------------

Plug 'posva/vim-vue'

" ---------------------------------------------------------------------------

Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'

Plug 'rajasegar/vim-astro', { 'branch': 'main' }

function! JavaScriptSyntaxOverride()
  hi! link jsxTag htmlTag
  hi! link jsxTagName htmlTagName
  hi! link jsxString htmlString
  " hi! link jsxNameSpace Function
  hi! link jsxComment htmlComment
  hi! link jsxAttrib htmlArg
  " hi! link jsxEscapeJs jsxEscapeJs
  hi! link jsxCloseTag htmlEndTag
  hi! link jsxCloseString htmlEndTag

  syntax region jsxComment start=+//+ end=/$/ contains=jsCommentTodo,@Spell contained containedin=jsxRegion,jsxTag extend keepend

  hi! link jsxComment jsComment
endfunction

augroup javascriptSyntaxOverride
  autocmd!
  autocmd FileType javascript call JavaScriptSyntaxOverride()
augroup END

" ---------------------------------------------------------------------------

Plug 'preservim/nerdtree'

let NERDTreeChDirMode=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeWinSize=48
let NERDTreeIgnore=['\~$', '\.pyc$', '^\.sass-cache$', '^node_modules$', '^\.bundle$', '^\.vagrant$']
let NERDTreeMapJumpNextSibling=''
let NERDTreeMapJumpPrevSibling=''
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
" Free up '?' for reverse search.
let NERDTreeMapHelp = 'H'
" Don't ask if buffers should be deleted on rename.
let NERDTreeAutoDeleteBuffer=1

let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'

" Be safe!
let NERDTreeRemoveDirCmd='trash '

" Fast Fingers
" Quickly open up NERDTree nodes after completing a search.
let g:FastFingersSpeed = 100
let g:FastFingersUpdateTime = &ut
let g:FastFingersNERDTreeClosed = '^\s*►.*\/$'

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

function! HighlightSearchTerms()
  let l:pairs = split(@/, '\\|\||')

  highlight! Highlight1 guibg=#ff527b guifg=#ffffff
  highlight! Highlight2 guibg=#6bb805 guifg=#ffffff
  highlight! Highlight3 guibg=#00c1ff guifg=#ffffff

  call clearmatches()
  let l:index = 1
  for l:pair in l:pairs
    call matchadd('Highlight' . l:index, '\c' . l:pair, 10, 100 + l:index)
    let l:index = l:index + 1
  endfor
endfunction

nnoremap <Leader>s :call HighlightSearchTerms()<CR>

" XML folding via syntax
" See http://www.jroller.com/lmchung/entry/xml_folding_with_vim
let g:xml_syntax_folding=1
autocmd FileType xml setlocal foldmethod=syntax

autocmd FileType nerdtree setlocal nolist

" ---------------------------------------------------------------------------

Plug 'Xuyuanp/nerdtree-git-plugin'

let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ 'Modified'  :'*',
      \ 'Staged'    :'+',
      \ 'Untracked' :'?',
      \ 'Renamed'   :'R',
      \ 'Unmerged'  :'!',
      \ 'Deleted'   :'-',
      \ 'Dirty'     :'*',
      \
      \ 'Ignored'   :'I',
      \ 'Clean'     :'C',
      \ 'Unknown'   :'U'
      \ }

" ---------------------------------------------------------------------------

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

nnoremap <silent> <F6> :UndotreeToggle<CR>
let g:undotree_SplitWidth=45
let g:undotree_SetFocusWhenToggle=1

" ---------------------------------------------------------------------------

Plug 'tpope/vim-characterize'

" ---------------------------------------------------------------------------

Plug 'tpope/vim-fugitive'

nnoremap <leader>ha :silent! Git add %<CR>

" ---------------------------------------------------------------------------

Plug 'tpope/vim-git'

" ---------------------------------------------------------------------------

Plug 'tpope/vim-haml', { 'for': ['haml', 'hamlbars', 'hamlc', 'sass', 'scss'] }

" ---------------------------------------------------------------------------

Plug 'tpope/vim-liquid', { 'for': ['liquid'] }

" ---------------------------------------------------------------------------

Plug 'plasticboy/vim-markdown'

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1

" let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']

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

let php_html_load=0
let php_html_in_heredoc=0
let php_html_in_nowdoc=0

let php_sql_query=0
let php_sql_heredoc=0
let php_sql_nowdoc=0

let PHP_noArrowMatching=1

function! PhpSyntaxOverride()
  hi phpUseNamespaceSeparator guifg=#808080 guibg=NONE gui=NONE
  hi phpClassNamespaceSeparator guifg=#808080 guibg=NONE gui=NONE
  hi phpNullValue guifg=#00a4ef guibg=NONE gui=NONE
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

autocmd FileType php
      \ nnoremap <silent> <expr> gz ":silent exec \"!xdg-open 'http://php.net/en/" . expand('<cword>') . "'\"<CR>"

" ---------------------------------------------------------------------------

Plug 'thinca/vim-visualstar'

" ---------------------------------------------------------------------------

Plug 'tpope/vim-abolish'

" ---------------------------------------------------------------------------

" NOTE: Commit https://github.com/vim-airline/vim-airline/commit/c8c0e7d9ff05e1fb4d2076b583bca2abd8dddd2e breaks the `licius' theme badly!
"
Plug 'vim-airline/vim-airline'        " , { 'commit': '38c9f9ca3d1960d38d4d283cf62863ba9be8a6b7' }
Plug 'vim-airline/vim-airline-themes' " , { 'commit': '03a4c491dfa53e9d2619de8759eccd073367b0fd' }

"let g:airline_theme='lucius'
let g:airline_theme='minimalist'
let g:airline_symbols_ascii=1

"let g:airline_left_sep = "\ue0b0"
"let g:airline_left_alt_sep = "\ue0b1"
"let g:airline_right_sep = "\ue0b2"
"let g:airline_right_alt_sep = "\ue0b3"

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

Plug 'preservim/vimux'

" {{{ tmux

if ! exists('g:tmuxTarget')
  let g:tmuxTarget='.2'
endif
if ! exists('g:tmuxCommand')
  let g:tmuxCommand='!!'
endif

" Send the following key combinations on <F5> after writing the buffer to disk:
"
"     q - quit any running programs, such as `less`
"     <C-C> - terminate any foreground processes, such as watchers
"     <C-U> - clear the command-line prompt
"     <C-L> - clear the screen
"     …command
"     <Enter> - execute the command
"
nnoremap <silent> <F5> :w<CR>:call system('tmux send-keys -t ' . shellescape(g:tmuxTarget) . ' "q"')<CR>:sleep 100m<CR>:call system('tmux send-keys -t ' . shellescape(g:tmuxTarget) . ' "^C"')<CR>:sleep 100m<CR>:call system('tmux send-keys -Rt ' . shellescape(g:tmuxTarget) . ' "^U" "^L" ' . shellescape(g:tmuxCommand) . ' "Enter"')<CR>
imap <silent> <F5> <Esc><F5>a

" }}}

" ---------------------------------------------------------------------------

Plug 'neomake/neomake'

let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '!', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

hi def link NeomakeErrorSign ErrorMsg
hi def link NeomakeWarningSign WarningMsg

" ---------------------------------------------------------------------------

Plug 'elzr/vim-json'
Plug 'GutenYe/json5.vim', { 'for': ['json5'] }

" Set this variable as vim-json barfs if it's not defined.
let g:vim_json_warnings=1
let g:vim_json_syntax_conceal=0

autocmd BufRead,BufNewFile {totem.config.json} set ft=json5

autocmd FileType json,totem.config.json setlocal foldmethod=syntax

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

Plug 'airblade/vim-gitgutter' " , { 'commit': 'dab840b15310f1b2bfb44d1db6150d7c38f9e27b' }

let g:gitgutter_max_signs = 9999
let g:gitgutter_map_keys = 0

nmap <leader>hp <Plug>(GitGutterPreviewHunk)
nmap <leader>hs <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)

nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)

omap ic <Plug>(GitGutterTextObjectInnerPending)
omap ac <Plug>(GitGutterTextObjectOuterPending)
xmap ic <Plug>(GitGutterTextObjectInnerVisual)
xmap ac <Plug>(GitGutterTextObjectOuterVisual)

" NOTE: The options below apply to an older version of git-gutter.
"
" let g:gitgutter_realtime = 0
" let g:gitgutter_eager = 0

hi def link GitGutterAdd DiffAdd
hi def link GitGutterChange DiffChange
hi def link GitGutterDelete DiffDelete
hi def link GitGutterChangeDelete DiffChange

" ---------------------------------------------------------------------------

Plug 'tommcdo/vim-fugitive-blame-ext'

" ---------------------------------------------------------------------------

Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" ---------------------------------------------------------------------------

Plug 'tpope/vim-cucumber', { 'for': ['feature', 'story'] }

" ---------------------------------------------------------------------------

Plug 'tpope/vim-commentary'

" ---------------------------------------------------------------------------

Plug 'jwalton512/vim-blade'

" ---------------------------------------------------------------------------

Plug 'christianrondeau/vim-base64'

" ---------------------------------------------------------------------------

Plug 'tommcdo/vim-exchange'

" ---------------------------------------------------------------------------

Plug 'rhysd/committia.vim'

let g:committia_open_only_vim_starting = 1

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    setlocal spell

    " If no commit message, start with INSERT mode.
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    end

    " Scroll the diff window from INSERT mode.
    imap <buffer><C-F> <Plug>(committia-scroll-diff-down-page)
    imap <buffer><C-B> <Plug>(committia-scroll-diff-up-page)
endfunction

" ---------------------------------------------------------------------------

Plug 'leafgarland/typescript-vim'

" ---------------------------------------------------------------------------

Plug 'wellle/targets.vim'

" ---------------------------------------------------------------------------

Plug 'chrisbra/unicode.vim'

" modify selected text using combining diacritics
command! -range -nargs=0 UnicodeOverline        call s:UnicodeCombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 UnicodeUnderline       call s:UnicodeCombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 UnicodeDoubleUnderline call s:UnicodeCombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 UnicodeStrikethrough   call s:UnicodeCombineSelection(<line1>, <line2>, '0336')

function! s:UnicodeCombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

vnoremap __ :UnicodeUnderline<CR>
vnoremap -- :UnicodeStrikethrough<CR>

" ---------------------------------------------------------------------------

Plug 'chr4/nginx.vim'

" ---------------------------------------------------------------------------

Plug 'stefandtw/quickfix-reflector.vim'

" ---------------------------------------------------------------------------

Plug 'Absolight/vim-bind'

" ---------------------------------------------------------------------------

Plug 'aperezdc/vim-template'

let g:templates_directory = $HOME . '/.vim/templates'

" ---------------------------------------------------------------------------

Plug 'will133/vim-dirdiff'

" ---------------------------------------------------------------------------

Plug 'hashivim/vim-terraform'

" ---------------------------------------------------------------------------

Plug 'machakann/vim-swap'

" ---------------------------------------------------------------------------

Plug 'ap/vim-css-color'

" ---------------------------------------------------------------------------

Plug 'jparise/vim-graphql'

" ---------------------------------------------------------------------------

Plug 'cespare/vim-toml'

Plug 'neovim/nvim-lspconfig'

" ---------------------------------------------------------------------------

if ! &termguicolors
    Plug 'godlygeek/csapprox'
endif

" ---------------------------------------------------------------------------

call plug#end()

colorscheme vim-zend55

" See https://github.com/kovidgoyal/kitty/issues/108#issuecomment-320492772
"
if (has('gui_running') || has('nvim')) && $TERM =~ 'kitty'
  hi Normal guifg=#ffffff guibg=#000000
endif

if has('autocmd')

  " Highlight trailing whitespace in red after the colour scheme has loaded.
  autocmd Syntax *
        \   syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
        \ | highlight ExtraWhitespace ctermbg=red guibg=red
        \ | syn match NonBreakingSpace /\%xA0\+/ containedin=ALL
        \ | highlight NonBreakingSpace ctermbg=cyan guibg=#6666aa

endif

lua <<EOF
local nvim_lsp = require('lspconfig')

nvim_lsp.tsserver.setup{}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

" Cheatsheet
"
" List of commands that I tend to forget, but need to learn:
"
" gi    Insert text in the same position as where Insert mode
"       was stopped last time in the current buffer.
"       This uses the |'^| mark. [..]
"
