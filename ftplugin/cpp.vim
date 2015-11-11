
" --- use 4 spaces for shortbite styleguide ---
set shiftwidth=4        " Use indents of 2 spaces
set tabstop=4           " An indentation every 2 columns
set softtabstop=4       " Let backspace delete indent
set smarttab            " make tab insert indents instead of tabs at the
                        "   beginning of a line
set expandtab           " always uses spaces instead of tab characters

set colorcolumn=80      " 80 character limit hilight
set foldmethod=syntax   " autofolding

" don't show tab/whitespace issues, atleast not until the shortbite directory
" is fixed
set nolist

" If you want clang-check to use compilation databases (perhaps generated by
" CMake or Build EAR) rather than pass compilation flags explicitly, set
" g:syntastic_cpp_clang_check_post_args to an empty string:
let g:syntastic_cpp_clang_check_post_args = ""

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_include_dirs = ['../include','include']
let g:syntastic_cpp_check_header = 1