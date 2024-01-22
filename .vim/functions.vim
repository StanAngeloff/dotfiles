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

" Choose '^' or '0' depending on the cursor position.
function! CleverJumpFirst()
  let l:before = getline('.')[:col('.') - 1]
  if l:before =~ '^\s\+\S$'
    return '0'
  endif
  return '^'
endfunction

" Erase trailing whitespace function and keyboard binding.
function! StripTrailingWhitespace()
  let l:previousPosition = getpos('.')
  let l:previousSearch = @/
  %s/\s\+$//e
  let @/ = l:previousSearch
  call setpos('.', l:previousPosition)
endfunction

" Show the stack of syntax highlighting classes affecting whatever is under the cursor.
function! SynStack()
  execute "normal! :TSHighlightCapturesUnderCursor\<CR>"
endfunc

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
endfunction

function! BestComplete()
  if pumvisible()
    return "\<C-N>"
  endif

  " If the character immediately before the column is not a whitespace, trigger completion.
  let l:before = getline('.')[:col('.') - 2]
  if col('.') > 1 && l:before =~ '\S$'
    call feedkeys("\<C-G>u\<C-X>\<C-O>", 'm')
    return ''
  endif

  return "\<Tab>"
endfunction

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
