" Extract Variable

let g:RefactorLength = 0

function! RefactorExtractVariable()
  augroup refactorComplete
    autocmd InsertLeave * augroup refactorComplete | execute "autocmd!" | augroup END | augroup! refactorComplete |
          \ exe "normal! mZ" | let g:RefactorLength = len(@.) | exe "normal! O\<C-R>. = \<C-R>\";" | exe "normal! `Z" | exe "normal! " . (g:RefactorLength - 1) . "\<Left>"
  augroup END
  return "c"
endfunction

vnoremap <expr> <leader>re RefactorExtractVariable()

" Organise Uses

let g:refactor_organise_uses_namespace=''

function! RefactorOrganiseUsesCanonicalNamespace(namespace)
  let namespace = a:namespace

  let namespace = substitute(namespace, '\\\@<!Bundle\\.*', '', '')
  let namespace = substitute(namespace, '^\(Symfony\\\(Component\|Bridge\)\\[^\\]\+\).*', '\1', '')
  let namespace = substitute(namespace, '^\(Psr\\[^\\]\+\).*', '\1', '')

  return namespace
endfunction

function! RefactorOrganiseUsesScore(declaration)
  " If this is a namespace declaration, push above all else.
  if match(a:declaration, 'namespace') == 0
    return 10000
  endif

  let namespace = split(a:declaration)[1]
  let namespace = RefactorOrganiseUsesCanonicalNamespace(namespace)

  " If the declaration is close to the (bundle?) namespace, push up.
  let base_namespace_parts = split(RefactorOrganiseUsesCanonicalNamespace(g:refactor_organise_uses_namespace), '\')
  let length = len(base_namespace_parts)
  let i = length - 1

  while i >= 0
    if match(namespace, join(base_namespace_parts[0:i], '\\')) == 0
      " The closer we are to the base namespace, the higher the score.
      return i * 1000
    endif
    let i = i - 1
  endwhile

  " Symfony and Doctrine components are important.
  if match(namespace, 'Symfony\\Component\\') == 0
    return 990
  elseif match(namespace, 'Symfony\\Bridge') == 0
    return 980
  elseif match(namespace, 'Symfony\\') == 0
    return 910
  elseif match(namespace, 'Doctrine\\') == 0
    return 800
  endif

  return 0
endfunction

function! RefactorOrganiseUsesCompare(left, right)
  let left_score = RefactorOrganiseUsesScore(a:left)
  let right_score = RefactorOrganiseUsesScore(a:right)
  return (left_score == right_score ? (a:left == a:right ? 0 : (a:left > a:right ? 1 : -1)) : (left_score < right_score ? 1 : -1))
endfunction

function! RefactorOrganiseUses()
  let previous_search = @/
  let previous_yank = @x

  " Create a mark where we can return to.
  normal! mZ
  " Go to the top of the file.
  normal! gg
  " Find the 'namespace' declaration at the top of the file.
  execute "normal! /namespace \<CR>"
  " Jump to the first {class,interface,trait} etc. definition.
  execute "normal! V/^\\(\\(abstract\\|final\\)\\s\\+\\)*\\(class\\|trait\\|interface\\)\\s\\+\<CR>"
  " Jump back to the last {use,namespace} declaration.
  execute "normal! ?^\\(use\\|namespace\\)\\s\\+\<CR>"
  " Erase newline characters.
  execute "normal! :s/\\V\\n//\<CR>"
  " Delete the line to register 'x'.
  normal! 0v$h"xd

  let user_declarations = split(@x, ';')

  for declaration in user_declarations
    if match(declaration, 'namespace') == 0
      let g:refactor_organise_uses_namespace= split(declaration)[1]
      break
    endif
  endfor

  call sort(user_declarations, 'RefactorOrganiseUsesCompare')

  let previous_name = ''
  let organised_declarations = []

  for declaration in user_declarations
    let namespace = split(declaration)[1]
    let canonical_name = RefactorOrganiseUsesCanonicalNamespace(namespace)

    " If the namespace is not known, e.g., 'Monolog', use the first part only.
    if canonical_name == namespace
      let canonical_name = split(canonical_name, '\')[0]
    endif

    if strlen(previous_name) && previous_name != canonical_name
      call add(organised_declarations, '')
    endif

    call add(organised_declarations, declaration . ';')

    if match(declaration, 'namespace') == 0
      call add(organised_declarations, '')
    else
      let previous_name = canonical_name
    endif
  endfor

  " Join the organised declarations and paste above the cursor then jump back to where we started.
  let @x = join(organised_declarations, "\n") . "\n\n"
  normal! V"xp`Z

  " Be a good citizen, restore registers to their previous values.
  let @x = previous_yank
  let @/ = previous_search
endfunction

nnoremap <silent> <leader>ru :call RefactorOrganiseUses()<CR>
