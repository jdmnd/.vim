set nocompatible
filetype off

" set runtime path to include vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" plugins managed by vundle
call vundle#begin()
Plugin 'gmarik/Vundle.vim' " (required for vundle)
Plugin 'tpope/vim-surround'
Plugin 'jiangmiao/auto-pairs'
Plugin 'godlygeek/tabular'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
" Plugin 'jremmen/vim-ripgrep'
" Plugin 'yssl/QFEnter'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Linting
"Plugin 'scrooloose/syntastic'
Plugin 'w0rp/ale'
" Colors
Plugin 'mhartington/oceanic-next'
"Git
Plugin 'tpope/vim-fugitive'
" orgmode
Plugin 'jceb/vim-orgmode'
Plugin 'vim-scripts/utl.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/calendar-vim'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-repeat'

" Haskell
Plugin 'neovimhaskell/haskell-vim'
" Plugin 'enomsg/vim-haskellConcealPlus'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'eagletmt/neco-ghc'

" Elm
Plugin 'ElmCast/elm-vim'

" Elixir
Plugin 'elixir-editors/vim-elixir'

Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'scrooloose/nerdcommenter'

Plugin 'lukerandall/haskellmode-vim'
Plugin 'Twinside/vim-hoogle'
Plugin 'bitc/vim-hdevtools'
"Plugin 'travitch/hasksyn'
Plugin 'ervandew/supertab'

"Tidal
Plugin 'munshkr/vim-tidal'

"Python
Plugin 'petobens/poet-v'
Plugin 'vim-scripts/indentpython.vim'

"Javascript
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'othree/html5.vim'

"Typescript
Plugin 'leafgarland/typescript-vim'

"C++
Plugin 'rhysd/vim-clang-format'

"Kotlin
Plugin 'udalov/kotlin-vim'

"Rust
Plugin 'rust-lang/rust.vim'

"Completion
Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/vimproc'
"Plugin 'kien/ctrlp.vim'
Plugin 'tikhomirov/vim-glsl'
Plugin 'emnh/taglist.vim'
Plugin 'tmhedberg/matchit'
call vundle#end()

filetype plugin indent on

" --- General Settings ---

set backspace=indent,eol,start
set encoding=utf-8
set ruler
set number
set showcmd
set incsearch
set hlsearch
set nospell
set ignorecase
set smartcase
set hidden                      " Allow modified buffers to be hidden without unloading
set nowrap                      " Don't wrap long lines
set showmode                    " Display the current mode
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set autoindent                  " Keep the indentation when creating a new line
set smartindent                 " Syntax-based indenting
set showmatch                   " Briefly flash matching parens while typing
set wildmenu                    " Show list of matches when using :b or :find

set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set list

"set columns=150
"set lines=50

set path+=**                    " Allow :find to recursively search subpaths

set diffopt+=vertical           " Always open diffs in a vertical split

set complete-=i           " Disable ^N searching included files (slow)


" GUI Settings
set guifont=Source\ Code\ Pro:h15
set guioptions=cgm

" Strip trailing whitespace
autocmd FileType asm,c,cpp,java,elixir,go,php,haskell,javascript,puppet,python,ruby,rust,sql,twig,xml,yml,perl autocmd BufWritePre <buffer> | call StripTrailingWhitespace()
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
let maplocalleader = '\'

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Hide search highlighting with ,/
nmap <silent> <leader>/ :nohlsearch<CR>

" Map H and L to move between buffers. Conflicts with ability to move to
" bottom/top of screen, so first remap those to gh, gl.
nnoremap gh <S-H>
nnoremap gl <S-L>
nnoremap <S-H> :bprev<CR>
nnoremap <S-L> :bnext<CR>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Remap * to highlight the word under the cursor without moving to next result
nnoremap * mxHmz`x*`zzt`x

" Nerd tree file browser
noremap <C-O> :NERDTreeToggle<CR>
noremap <C-H> :NERDTree 

" move between splits with alt
nnoremap ∆ <C-W><C-J>
nnoremap ˚ <C-W><C-K>
nnoremap ¬ <C-W><C-L>
nnoremap ˙ <C-W><C-H>

" iterate error list with alt
nnoremap ∫ :cprev <CR>
nnoremap µ :cnext <CR>

" return cursor to first window (often NERDTree)
nnoremap <leader><C-O> 1<C-W>w

" folding
nnoremap <space> za

" call make with leader+m
nnoremap <leader>m :make<CR>

" jumplist forward/backward
nnoremap <C-K> <C-O>
nnoremap <C-J> <C-I>

" write without losing position on line
nnoremap <silent> <leader>w :silent call WriteSaveCursor()<CR>
function! WriteSaveCursor()
  let save_cursor = getpos(".")
  write
  call setpos('.', save_cursor)
endfunction

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

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
"inoremap kj <ESC>
" shorten the timeout for sequential shortcuts in insert mode
set timeoutlen=500

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" --- Setting up directories ---
set backup                  " Backups are nice ...
if has('persistent_undo')
  set undofile                " So is persistent undo ...
  set undolevels=1000         " Maximum number of changes that can be undone
  set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

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

" Ale
let g:ale_linters = {
\   'typescript': ['eslint', 'tsserver'],
\   'typescriptreact': ['eslint', 'tsserver'],
\   'javascript': ['eslint'],
\   'rust': ['cargo', 'analyzer'],
\   'python': ['mypy', 'pylint'],
\   'zig': ['zls']
\}

let g:ale_fixers = {
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'javascript': ['prettier'],
\   'scss': ['prettier'],
\   'rust': ['rustfmt'],
\   'go': ['gofmt', 'goimports'],
\   'python': ['isort', 'black']
\}

let g:ale_fix_on_save = 1
let g:ale_rust_rustfmt_options = '--edition 2021'

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" map <silent> <Leader>e :Errors<CR>
" map <Leader>s :SyntasticToggleMode<CR>

" Tabularize align columns around a character
  map <leader>t :Tab<CR>
" Airline

  "Fancy arrow symbols, requires a patched font
  "let g:airline_powerline_fonts = 0

  " Show PASTE if in paste mode
  "let g:airline_detect_paste = 1

  " Show airline for tabs too
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_tabs = 0

" ghc-mod
  let g:haddock_docdir = "~/Library/Haskell/share/doc/x86_64-osx-ghc-7.10.2/"
  let g:haddock_browser = "/Applications/Google Chrome.app"
  " enable filetype detection, plus loading of filetype plugins
  filetype plugin on


" speed-dating
  autocmd VimEnter * SpeedDatingFormat! %v
  autocmd VimEnter * SpeedDatingFormat! %^v

" gundo
  nnoremap <F5> :GundoToggle<CR>
  let g:gundo_return_on_revert = 0

" fugitive
  nnoremap <leader>gw :Gwrite<CR>
  nnoremap <leader>gr :Gread<CR>
  nnoremap <leader>gc :Git commit<CR>
  nnoremap <leader>gs :Git status<CR>
  nnoremap <leader>gp :Git pull<CR>
  nnoremap <leader>gP :Git push<CR>


  nmap <leader>sp :call <SID>SynStack()<CR>
  function! <SID>SynStack()
    if !exists("*synstack")
      return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endfunc

" CtrlP
let g:ctrlp_custom_ignore = 'node_modules'

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1
nnoremap <leader>] :YcmCompleter GoToType<CR>
nnoremap <C-]> :YcmCompleter GoToType<CR>
nnoremap <leader>[ :YcmCompleter GoToReferences<CR>
nnoremap <leader>; :YcmCompleter GoTo<CR>
nnoremap <leader>d :YcmCompleter GetDoc<CR>
nmap <D-CR> <plug>(YCMHover)
nnoremap <leader>c :pclose<CR>

" Navigation in jumplist
nnoremap <leader>o <C-O>
nnoremap <leader>i <C-I>

" vim-ripgrep
nnoremap <leader>a :RG<CR>
"nnoremap <leader>a :Rg ''<left>
"vnoremap <leader>a y:Rg -i '<C-r>"'<CR>
"nnoremap <leader>* yiw:Rg '\b<C-r>"\b'<CR>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --hidden -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)



" Poetry
let g:poetv_auto_activate = 1
let g:poetv_executables = ['poetry']

" FZF
let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
nnoremap <C-P> :Files<CR>
