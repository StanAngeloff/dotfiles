set keywordprg=pman

" Vim, Y U SO BOLD?
set matchpairs-=<:>

" Expand C-style comments to multi-line comments.
inoremap <buffer> // /**<CR>/<Esc>O

nnoremap <C-]> :PhpSearch <C-R>=expand("<cword>")<CR><CR>
