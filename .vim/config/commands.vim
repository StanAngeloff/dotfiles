command! -bar -bang Trash call Trash(fnamemodify(bufname(<q-args>), ':p'))

" See https://vimrcfu.com/snippet/143
"
command! Ltabs call OpenAllFromLocationList()
command! Qtabs call OpenAllFromQuickfix()
