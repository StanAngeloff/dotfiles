"nnoremap <C-C> <Esc>:echohl WarningMsg \| echom '⚠️ Hey, avoid using <Ctrl-C> as this causes NeoVim to interrupt any running Lua code.' \| echohl None<CR>
"inoremap <C-C> <Esc>:echohl WarningMsg \| echom '⚠️ Hey, avoid using <Ctrl-C> as this causes NeoVim to interrupt any running Lua code.' \| echohl None<CR>

nnoremap <C-C> <Esc><Esc>
inoremap <C-C> <Esc><Esc>
vnoremap <C-C> <Esc><Esc>

" Use a custom leader character.
let mapleader = ','

nnoremap <leader>S :call RgProject(0)<CR>
vnoremap <leader>S :call RgProject(1)<CR>

" Add useful mappings in quick-fix buffers (:copen, :lopen, etc.)
autocmd FileType qf nnoremap <buffer> <C-T> ^<C-W>gF
      \ | nnoremap <buffer> t ^<C-W>gF
      \ | nnoremap <buffer> <silent> q :cclose<CR>:lclose<CR>

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
vnoremap <Return> :<C-U>w<CR>gv

" When using <C-{N,P}>, always select the {first,last} item in the pop-up menu.
inoremap <expr> <C-N> pumvisible() ? '<C-N>' : '<C-N><C-R>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <C-P> pumvisible() ? '<C-P>' : '<C-P><C-R>=pumvisible() ? "\<lt>Up>" : ""<CR>'

" When a special key is typed, if the pop-up menu is visible, complete the selected item first.
for s:key in ['(', ')', '[', ']', '{', '}', "'", '"', ',', '.', ':', ';', '-', '\', '<Space>']
  execute 'imap <expr> ' . s:key . " pumvisible() ? '<C-Y>" . (s:key == "'" ? "''" : s:key)  . "' : '" . (s:key == "'" ? "''" : s:key) . "'"
endfor

" Use omni-completion (if available) then keyword completion, if the former fails.
inoremap <expr> <C-X><C-O> '<C-R>=exists("+omnifunc") && &omnifunc != "" ? "\<C-X>\<C-O>" : ""<CR><C-R>=pumvisible() ? "" : "\<lt>Esc>a\<lt>C-N>"<CR><C-R>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" If the pop-up menu is visible, close it without inserting a new line.
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<C-G>u\<CR>"

"" God mode.
"noremap  <Up>    <NOP>
"inoremap <Up>    <NOP>
"noremap  <Down>  <NOP>
"inoremap <Down>  <NOP>
"noremap  <Left>  <NOP>
"inoremap <Left>  <NOP>
"noremap  <Right> <NOP>
"inoremap <Right> <NOP>

nnoremap <expr> 0 CleverJumpFirst()
vnoremap <expr> 0 CleverJumpFirst()

" Make $ behave consistently in visual mode.
vnoremap $ g_

"" Alias H and L to more useful commands, easier to type than their counterparts.
"nnoremap H g^
"vnoremap H g^

"nnoremap L g$
"vnoremap L g$

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

nnoremap <silent> <leader>W :call StripTrailingWhitespace()<CR>

" Turn off active highlighting, reset signs and plug-ins.
nnoremap <silent> <leader><Space> :noh<CR>:sign unplace *<CR>:call clearmatches()<CR>:GitGutter<CR>

" Toggle spell-checking keyboard binding.
noremap <silent> <F1> :setlocal nospell! nospell?<CR>
" Toggle paste-mode keyboard binding.
nnoremap <silent> <F2> :setlocal invpaste paste?<CR>
set pastetoggle=<F2>
" Toggle long line wrap.
nnoremap <silent> <F3> :setlocal wrap! wrap?<CR>
" Toggle display of placeholder characters for tabs and newlines.
nnoremap <silent> <F4> :setlocal list! list?<CR>

nnoremap <F7> :call SynStack()<CR>

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

nnoremap <silent> Я ZZ

inoremap <silent> <Tab> <C-R>=BestComplete()<CR>

inoremap <expr> <C-J> pumvisible() ? '<C-N>' : (get(g:, 'PhpBestExpandCommentInsertLeaveOccurrence', 0) == 1 ? '<Esc>i' : '<C-O>o')
inoremap <expr> <C-K> pumvisible() ? '<C-P>' : '<C-O>O'
