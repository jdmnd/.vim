set nocompatible
filetype off

" set runtime path to include vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" plugins managed by vundle
call vundle#begin()
Plugin 'gmarik/Vundle.vim' " (required for vundle)
Plugin 'godlygeek/tabular'
Plugin 'bling/vim-airline'
Plugin 'yurifury/hexHighlight'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
call vundle#end()

filetype plugin indent on

" --- General Settings ---

set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch
set nospell
set nowrap                      " Don't wrap long lines
set showmode                    " Display the current mode
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set autoindent                  " Keep the indentation when creating a new line

set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set list


" Strip trailing whitespace
autocmd FileType asm,c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> | call StripTrailingWhitespace()
function! StripTrailingWhitespace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" enable mouse interaction through terminal
set mouse=a

" enable syntax menu functions
" source /usr/share/vim/vim74/synmenu.vim

" --- Mappings ---

let mapleader = ','

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Hide search highlighting with ,/
nmap <silent> <leader>/ :nohlsearch<CR>

" Map H and L to move between tabs. Conflicts with ability to move to
" bottom/top of screen
map <S-H> gT
map <S-L> gt

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Remap * to highlight the word under the cursor without moving to next result
nnoremap * m`*``


" --- Colour Scheme ---
colorscheme liquidcarbon
set background=dark
syntax on

" --- Status Bar ---
set laststatus=2
set statusline=%<%f\                     " Filename
set statusline+=%w%h%m%r                 " Options
set statusline+=%{fugitive#statusline()} " Git Hotness
set statusline+=\ [%{&ff}/%Y]            " Filetype
set statusline+=\ [%{getcwd()}]          " Current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

" --- No tabs!! ---
set shiftwidth=2     " Use indents of 2 spaces
set tabstop=2        " An indentation every 2 columns
set softtabstop=2    " Let backspace delete indent
set smarttab         " make tab insert indents instead of tabs at the beginning of a line
set expandtab        " always uses spaces instead of tab characters

" --- Syntax Highlighting ---
let asmsyntax='armasm'
let filetype_inc='armasm'

" Exit insert mode from the home row
inoremap kj <Esc>
vnoremap kj <Esc>
" shorten the timeout for sequential shortcuts in insert mode
set timeoutlen=500


" --- Setting up directories ---
set backup                  " Backups are nice ...
if has('persistent_undo')
  set undofile                " So is persistent undo ...
  set undolevels=1000         " Maximum number of changes that can be undone
  set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

" Add exclusions to mkview and loadview
" eg: *.*, svn-commit.tmp
let g:skipview_files = [
      \ '\[example pattern\]'
      \ ]

" Initialize directories
function! InitializeDirectories()
  let parent = $HOME
  let prefix = 'vim'
  let dir_list = {
        \ 'backup': 'backupdir',
        \ 'views': 'viewdir',
        \ 'swap': 'directory' }

  if has('persistent_undo')
    let dir_list['undo'] = 'undodir'
  endif
  let common_dir = parent . '/.' . prefix

  for [dirname, settingname] in items(dir_list)
    let directory = common_dir . dirname . '/'
    if exists("*mkdir")
      if !isdirectory(directory)
        call mkdir(directory)
      endif
    endif
    if !isdirectory(directory)
      echo "Warning: Unable to create backup directory: " . directory
      echo "Try: mkdir -p " . directory
    else
      let directory = substitute(directory, " ", "\\\\ ", "g")
      exec "set " . settingname . "=" . directory
    endif
  endfor
endfunction
call InitializeDirectories()

" --- Plugin Settings ---

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Airline
"
"Fancy arrow symbols, requires a patched font
"let g:airline_powerline_fonts = 1

" Show PASTE if in paste mode
let g:airline_detect_paste=1

" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1

