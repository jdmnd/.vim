
" --- use 4 spaces for shortbite styleguide ---
set shiftwidth=4        " Use indents of 2 spaces
set tabstop=4           " An indentation every 2 columns
set softtabstop=4       " Let backspace delete indent
set smarttab            " make tab insert indents instead of tabs at the
                        "   beginning of a line
set expandtab           " always uses spaces instead of tab characters

set colorcolumn=80      " 80 character limit hilight


let g:ale_cpp_gcc_options='-std=c++14 -Wall -I../include -Iinclude'
