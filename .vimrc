" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Windows compatibility
set runtimepath+=~/.vim

set nocompatible  " makes vim behave in a more useful way (the default) than the vi-compatible manner

" Enable 256-color terminal
set t_Co=256

" Pathogen is a simple library for manipulating comma delimited path options
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Make sure we use UTF-8 and Unix line-endings
set enc=utf-8
set ff=unix

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

if v:progname =~? "gvim"
  set guifont=Consolas:h13:cDEFAULT

  " For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
  let &guioptions = substitute(&guioptions, "t", "", "g")


  " Maximize on start-up
  au GUIEnter * simalt ~x

  " Use .viminfo instead of _viminfo
  set viminfo+=n~/.viminfo
endif

" Mode-dependent cursor in MinTTY
if v:progname =~? "vim"
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

set history=32  " keep ~500 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  colorscheme vividchalk
  set hlsearch
endif

if has("autocmd")
  " Enable file type detection.
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  " When editing a file, always jump to the last known cursor position.
  " autocmd BufReadPost *
  "   \ if line("'\"") > 1 && line("'\"") <= line("$") |
  "   \   exe "normal! g`\"" |
  "   \ endif
  " augroup END

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
else
	set autoindent  " always set autoindenting on
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

set backspace=2
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap

set spell  " Turn on spell check

set nu!  " Enable line numbers

set guioptions-=T  " Hide the top toolbar

set nobackup
set directory=.,$TEMP

