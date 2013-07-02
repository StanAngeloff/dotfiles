set keywordprg=pman

" Handle brackets in a sane way.
inoreabbrev <buffer> {{ {<CR>}<ESC>O
inoreabbrev <buffer> [] [] = 

" Handle docblocks in the same manner.
inoreabbrev <buffer> /** /**<CR>/<ESC>ka

" Fix matchpairs for PHP (for matchit.vim plugin).
if exists('loaded_matchit')
  let b:match_skip = 's:comment\|string'
  let b:match_words = 
    \ '\<switch\>:\<case\>:\<default\>,' .
    \ '\<if\>:\<elseif\>:\<else\>,' .
    \ '\<do\>:\<while\>,' .
    \ '\<\(switch\|while\|foreach\|for\|if\)\>:\<end\1\>,' .
    \ '\$:\->\zs,' .
    \ '(:),{:},[:],' .
    \ '<\(?php\)\@!:>'
endif
