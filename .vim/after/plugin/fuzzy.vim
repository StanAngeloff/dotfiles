function! fuzzy#get_word()
  let line = getline('.')
  let column = col('.')
  let end_column = column
  " Read back to the first non-whitespace character.
  while end_column >= 0 && (line[end_column] == '' || line[end_column] =~ '\s')
    let end_column = end_column - 1
  endwhile
  let start_column = end_column
  " Read back to the first non-word character.
  while start_column >= 0 && line[start_column] =~ '\w'
    let start_column = start_column - 1
  endwhile
  let start_column = start_column + 1
  if start_column <= end_column && end_column <= column
    return [line[start_column : end_column], start_column, end_column]
  endif
  return ['', -1, -1]
endfunction

function! fuzzy#CompleteFuzzy(findstart, base)
  if a:findstart
    let [word, start_column, end_column] = fuzzy#get_word()
    if len(word)
      return start_column
    endif
    return col('.')
  endif

  " XXX: Not implemented.

  return []
endfunction

set completefunc=fuzzy#CompleteFuzzy
