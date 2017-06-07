call NERDTreeAddKeyMap({
      \ 'key': 'S',
      \ 'callback': 'NERDTreeSearchInCurrentNode',
      \ 'quickhelpText': 'search for a string (recursively) in the current node'
      \ })

function! NERDTreeSearchInCurrentNode()
  let n = g:NERDTreeFileNode.GetSelected()
  if n != {}
    let query = input('Search: ', '', 'tag_listfiles')
    if len(query)
      let @/=query
      let path = fnamemodify(n.path.str(), ':.')
      execute "normal! :NERDTreeClose\<CR>:Search " . escape(query, '<(?!$`''"#% )>|\') . ' ' . escape(path, '"'' \') . "\<CR>"
    endif
  endif
endfunction
