" vim-airline grey theme (incomplete).

let s:file = ['#000000', '#000000', 0, 0, '']

" NORMAL
let s:N1 = ['#000000', '#000000', 252, 244, '']
let s:N2 = ['#000000', '#000000', 252, 240, '']
let s:N3 = ['#000000', '#000000', 247, 236, '']

let g:airline#themes#grey#normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3, s:file)

" INSERT
let s:I1 = s:N1
let s:I2 = s:N2
let s:I3 = s:N3

let g:airline#themes#grey#insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3, s:file)

" VISUAL
let s:V1 = s:N1
let s:V2 = s:N2
let s:V3 = s:N3

let g:airline#themes#grey#visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3, s:file)

" Inactive and REPLACE

let g:airline#themes#grey#inactive = copy(airline#themes#grey#insert)
let g:airline#themes#grey#replace = copy(airline#themes#grey#insert)
