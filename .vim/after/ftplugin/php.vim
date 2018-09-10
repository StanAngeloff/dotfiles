" Vim, Y U SO BOLD?
"set matchpairs-=<:>

" Y U MESSING MY KEYWORD?
set iskeyword-=-

function! PhpBestExpandComment()
    " If the current line is empty and the one above doesn't end in character which can be a continuation,
    " assume we are starting a new docblock.
    if getline('.') =~ '^\s*$' && getline(line('.') - 1) !~ '[,(]$'
        if &lz | " lazyredraw
            return "\<C-G>u/**\<CR>\<CR>/\<Esc>k$i\<C-D>\<Space>\<Esc>A\<Space>"
        else
            return "\<C-G>u/**\<CR>\<CR>/\<Esc>k==A\<Space>"
        endif
    endif

    let g:PhpBestExpandCommentInsertLeaveOccurrence = 0

    augroup PhpBestExpandCommentCmd
        autocmd!
        autocmd InsertLeave *
                    \ let g:PhpBestExpandCommentInsertLeaveOccurrence = g:PhpBestExpandCommentInsertLeaveOccurrence + 1 |
                    \ if (g:PhpBestExpandCommentInsertLeaveOccurrence == 2) |
                    \   exe 'normal 7l' |
                    \ endif |
                    \ if (g:PhpBestExpandCommentInsertLeaveOccurrence >= 2) |
                    \   augroup PhpBestExpandCommentCmd | execute "autocmd!" | augroup END | augroup! PhpBestExpandCommentCmd |
                    \ endif
    augroup END

    return "\<C-G>u/* $ = */ \<Esc>6ha"
endfunction

" Expand C-style comments to multi-line comments.
inoremap <buffer> <expr> // PhpBestExpandComment()
