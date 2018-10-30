set expandtab
set tabstop=2
set shiftwidth=2
set textwidth=99
set colorcolumn=100
set cino=:0 " 

setlocal foldmethod=syntax
setlocal foldlevel=99

let g:ale_fixers = ["eslint"]
let g:ale_fix_on_save = 1
