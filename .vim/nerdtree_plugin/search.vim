call NERDTreeAddKeyMap({
      \ 'key': 'S',
      \ 'callback': 'NERDTreeSearchInCurrentNode',
      \ 'quickhelpText': 'search for a string (recursively) in the current node'
      \ })

function! NERDTreeSearchInCurrentNode()
  let n = g:NERDTreeFileNode.GetSelected()
  if n != {}
    let query = input('Search: ', '', 'tag_listfiles')
    let path = fnamemodify(n.path.str(), ':.')
    execute "normal! :Search '" . substitute(query, "'", "''", 'g') . "' '" . path . "'\<CR>"
  endif
endfunction
