" Shorthands
iabbrev pub public
iabbrev pro protected
iabbrev prot protected
iabbrev pri private
iabbrev priv private
iabbrev prv private
iabbrev fn function
iabbrev fun function

" Common misspellings
iabbrev anohter another
iabbrev antoher another
iabbrev aray array
iabbrev continious continuous
iabbrev eixt exit
iabbrev froeach foreach
iabbrev isntance instance
iabbrev naem name
iabbrev otehrwise otherwise
iabbrev overriden overridden
iabbrev parma param
iabbrev pritn print
iabbrev retrun return
iabbrev reutrn return
iabbrev srting string
iabbrev udnefined undefined
iabbrev vlaue value

" XML formatting through `xmllint`.
cnoreabbrev xmlformat %!xmllint --format --encode UTF-8 -

" Automagically insert the correct character without holding down <Shift>
function! PhpMagicFingers()
  inoremap <expr> . (getline('.')[col('.') - 2] =~ '-\\|='  ? '>' : '.')
endfunction

augroup phpMagicFingers
  autocmd!
  autocmd FileType php call PhpMagicFingers()
augroup END

" See :helpgrep Eatchar
function! Eatchar(pattern)
  let c = nr2char(getchar(0))
  return (c =~ a:pattern) ? '' : c
endfunction

augroup phpAbbreviations
  autocmd!
  autocmd FileType php
        \   :iabbrev <buffer> 2param @param
        \ | :iabbrev <buffer> 2return @return
        \ | :iabbrev <buffer> 2see @see
        \ | :iabbrev <buffer> 2throws @throws
        \ | :iabbrev <buffer> 4this $this
        \ | :iabbrev <buffer> inheritdoc {@inheritdoc}<C-R>=Eatchar('\s')<CR>
        \ | :iabbrev <buffer> die die('XXX: Break in ' . __FILE__ . ', line ' . __LINE__ . '.' . PHP_EOL);
        \ | :iabbrev <buffer> E_ALL error_reporting(E_ALL); ini_set('display_errors', 'On');
        \ | :iabbrev <buffer> throw throw new Exception('', <C-R>=substitute(system('date +%s'), '\n', '', 'g')<CR>);<C-O>14h<C-R>=Eatchar('\s')<CR>
augroup END
