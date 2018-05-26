" Vim, Y U SO BOLD?
"set matchpairs-=<:>

" Y U MESSING MY KEYWORD?
set iskeyword-=-

function! PhpBestExpandComment()
    " If the current line is empty and the one above doesn't end in character which can be a continuation,
    " assume we are starting a new docblock.
    if getline('.') =~ '^\s*$' && getline(line('.') - 1) !~ '[,(]$'
        return "\<C-G>u/**\<CR>\<CR>/\<Esc>k==A\<Space>"
    endif

    return "\<C-R>=UltiSnips#Anon('/* $${1:var} = */ $0')\<CR>"
endfunction

" Expand C-style comments to multi-line comments.
inoremap <buffer> <expr> // PhpBestExpandComment()
