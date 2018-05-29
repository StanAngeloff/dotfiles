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

" Lazy hands
iabbrev 2param @param
iabbrev 2return @return
iabbrev 2throws @throws
iabbrev 4this $this

" Snippets keyboard bindings.
" Unix timestamp.
inoremap <leader>time <C-R>=substitute(system('date +%s'), '\n', '', 'g')<CR>

" XML formatting through `xmllint`.
cnoreabbrev xmlformat %!xmllint --format --encode UTF-8 -

autocmd FileType ledger iabbrev <expr> today strftime('%Y/%m/%d')

" Automagically insert the correct character without holding down <Shift>
function PhpMagicFingers()
  inoremap <expr> . ('-' == getline('.')[col('.') - 2] ? '>' : '.')
endfunction

augroup phpMagicFingers
  autocmd!
  autocmd FileType php call PhpMagicFingers()
augroup END
