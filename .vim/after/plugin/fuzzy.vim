let g:fuzzy_complete_patterns = [
      \ { 'title': 'private $\1;',
      \   'patterns': ['p\s\+\$\(\h\w*\)\(\s\+\(\h\w*\)\)\?\;\?'],
      \   'fn': 'fuzzy#complete_php_private_property' },
      \ { 'title': 'if (isset ($\1)) { ... }',
      \   'patterns': ['if\s\+isset\(\(\s\+$\h\+\)\+\)'],
      \   'fn': 'fuzzy#complete_php_if_isset' }
      \ ]

let g:fuzzy_candidates = []
let g:fuzzy_arguments = []

function! fuzzy#complete_php_private_property(name, _, type, ...) " {{{
  let code = []
  if len(a:type)
    call extend(code, ['/**', ' * @var ' . a:type, ' */'])
  endif
  call extend(code, ['private $' . a:name . ';'])
  return code
endfunction " }}}

function! fuzzy#complete_php_if_isset(names, ...) " {{{
  let variables = split(substitute(a:names, '^\s\+\|\s\+$', '', 'g'), '\s\+')
  return ['if (isset (' . join(variables, ') && isset (') . ')) {', "\t$0", '}']
endfunction " }}}

function! fuzzy#get_word() " {{{
  let line = getline('.')
  let column = col('.')

  let end_column = column
  " Read back to the first non-whitespace character.
  while end_column >= 0 && (line[end_column] == '' || line[end_column] =~ '\s')
    let end_column = end_column - 1
  endwhile

  " Walk to the beginning of the line and attempt to match any of the regular expressions
  " associated with a completion.
  let start_column = end_column
  let pattern_column = -1
  while start_column >= 0
    if pattern_column > -1 | break | endif
    for complete_options in g:fuzzy_complete_patterns
      if pattern_column > -1 | break | endif
      for pattern in complete_options['patterns']
        if pattern_column > -1 | break | endif
        let pattern_column = match(line[0 : end_column], '^' . pattern . '\s*$', start_column)
        " If we have a match, make sure it is preceded by a whitespace character.
        if pattern_column > 0 && line[pattern_column - 1] =~ '\S'
          let pattern_column = -1
        endif
      endfor
    endfor
    let start_column = start_column - 1
  endwhile

  if pattern_column > -1 && pattern_column <= end_column
    return [line[pattern_column : end_column], pattern_column, end_column]
  endif

  " If we failed to match a regular expression, assume we are performing fuzzy completion.
  let start_column = end_column
  " Read back to the first non-word character.
  while start_column >= 0 && line[start_column] =~ '\w'
    let start_column = start_column - 1
  endwhile

  let start_column = start_column + 1
  if start_column <= end_column
    return [line[start_column : end_column], start_column, end_column]
  endif

  return ['', -1, -1]
endfunction " }}}

function! fuzzy#complete_done() " {{{
  " If we have no candidates, a different completion has finished.
  if ! len(g:fuzzy_candidates) || ! exists('g:fuzzy_previous_position')
    return
  endif

  let line = getline('.')
  let column = col('.')
  let complete_index = 0

  let inserted = line[max([0, g:fuzzy_previous_position - 1]) : column]
  for candidate in g:fuzzy_candidates
    if inserted == candidate
      let before = ''
      if g:fuzzy_previous_position > 1
        let before = line[0 : g:fuzzy_previous_position - 2]
      endif
      let complete_options = g:fuzzy_arguments[complete_index]
      let complete_lines = call(complete_options['fn'], complete_options['arguments'])

      let position = getpos('.')
      let move_lines = -1
      let move_column = -1

      call setline('.', before . complete_lines[0] . line[column : ])

      if len(complete_lines) > 1
        let indent = matchstr(line, '^\s\+')
        let indented_lines = []

        for append_line in complete_lines[1 : ]
          if &expandtab
            let append_line = substitute(append_line, '^\(\t\)\+', '\=repeat(" ", &tabstop * len(submatch(0)))', '')
          endif

          let append_line = indent . append_line

          let match_column = match(append_line, '\$0')
          if match_column > -1
            let move_lines = 1 + len(indented_lines)
            let move_column = match_column + 1
            let append_line = (match_column > 1 ? append_line[0 : match_column - 1] : '') . substitute(append_line[match_column + 2 : ], '\s\+$', '', '')
          else
            let append_line = substitute(append_line, '\s\+$', '', '')
          endif

          call add(indented_lines, append_line)
        endfor
        call append('.', indented_lines)

        if move_lines == -1 && move_column == -1
          let move_lines = len(indented_lines)
          let move_column = 1 + len(indented_lines[len(indented_lines) - 1])
        endif
      else
        let move_lines = 0
        let move_column = 1 + len(before . complete_lines[0])
      endif

      call setpos('.', [position[0], position[1] + move_lines, move_column, 0])

      break
    endif
    let complete_index = complete_index + 1
  endfor

  " Reset candidates so we don't complete again unless 'completefunc' is used.
  let g:fuzzy_candidates = []

  unlet g:fuzzy_previous_position
endfunction " }}}

function! fuzzy#CompleteFuzzy(findstart, base) " {{{
  if a:findstart
    let [word, start_column, end_column] = fuzzy#get_word()
    if len(word)
      return start_column
    endif
    return col('.')
  endif

  let g:fuzzy_previous_position = col('.')

  let g:fuzzy_candidates = []
  let g:fuzzy_arguments = []

  for complete_options in g:fuzzy_complete_patterns
    for pattern in complete_options['patterns']
      let pattern_matches = matchlist(a:base, pattern)
      if len(pattern_matches)
        call add(g:fuzzy_candidates, substitute(complete_options['title'], '\\\([0-9]\)\+', '\=pattern_matches[submatch(1)]', 'g'))
        call add(g:fuzzy_arguments, { 'fn': complete_options['fn'], 'arguments': pattern_matches[1 : ] })
      endif
    endfor
  endfor

  return g:fuzzy_candidates
endfunction " }}}

augroup fuzzy " {{{
  autocmd!
  autocmd CompleteDone * call fuzzy#complete_done()
augroup END " }}}

set completefunc=fuzzy#CompleteFuzzy
