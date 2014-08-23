call NERDTreeAddMenuItem({
      \ 'text': '(t)rash the current node',
      \ 'shortcut': 't',
      \ 'callback': 'NERDTreeTrashNode'
      \ })

function! NERDTreeTrashNode()
  let currentNode = g:NERDTreeFileNode.GetSelected()

  echo "Trash the current node\n" .
        \ "==========================================================\n".
        \ "Are you sure you wish to send the node to the rubbish bin:\n" .
        \ "" . currentNode.path.str() . ' (yN):'
  let choice = nr2char(getchar())
  let confirmed = choice ==# 'y'

  if confirmed
    try
      call Trash(currentNode.path.str())
      call currentNode.parent.removeChild(currentNode)
      call NERDTreeRender()
      redraw
    catch /^Trash/
      echohl warningmsg
      redraw
      echomsg 'NERDTree: could not trash node'
      echohl normal
    endtry
  else
    redraw
    echomsg 'NERDTree: trash aborted'
  endif

endfunction
