call NERDTreeAddKeyMap({
      \ 'key': 'a',
      \ 'callback': 'NERDTreeReveal',
      \ 'quickhelpText': 'reveal the node for the file in previous window'
      \ })

function! NERDTreeReveal()
  wincmd p
  execute 'silent! NERDTreeFind'
endfunction
