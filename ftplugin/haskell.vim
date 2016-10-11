" Type of expression under cursor
"nmap <silent> <leader>ht :w<CR>:GhcModType<CR>
" Insert type of expression under cursor
"nmap <silent> <leader>hT :w<CR>:GhcModTypeInsert<CR>
" GHC errors and warnings
"nmap <silent> <leader>hc :SyntasticCheck hdevtools<CR>

nmap <silent> <leader>tw :GhcModTypeInsert<CR>
nmap <silent> <leader>ts :GhcModSplitFunCase<CR>
nmap <silent> <leader>tq :GhcModType<CR>
nmap <silent> <leader>te :GhcModTypeClear<CR>

" Disable "defined but not used" warnings
"let g:syntastic_haskell_hdevtools_args = '-g -fno-warn-unused-binds'

" Tell hdevtools how to source modules from cabal sandbox
function! s:CabalCargs(args)
   let l:output = system('cabal-cargs ' . a:args)
   if v:shell_error != 0
      let l:lines = split(l:output, '\n')
      echohl ErrorMsg
      echomsg 'args: ' . a:args
      for l:line in l:lines
         echomsg l:line
      endfor
      echohl None
      return ''
   endif
   return l:output
endfunction

function! s:HdevtoolsOptions()
    return s:CabalCargs('--format=hdevtools --sourcefile=' . shellescape(expand('%')))
endfunction

if filereadable(expand('%'))
  let g:hdevtools_options = s:HdevtoolsOptions()
endif


" Leader also disables ghcmod highlights
nmap <silent> <leader>/ :nohlsearch<CR>:SyntasticReset<cr>:GhcModTypeClear<cr>

" Resolves ghcmod base directory
au FileType haskell let g:ghcmod_use_basedir = getcwd()

" Haskell Linter
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['haskell'] }
nmap <silent> <leader>hl :SyntasticCheck hlint<CR>

" Hoogle the word under the cursor
nnoremap <silent> <leader>hh :Hoogle<CR>

" Hoogle and prompt for input
nnoremap <leader>hH :Hoogle 

" Hoogle for detailed documentation (e.g. "Functor")
nnoremap <silent> <leader>hi :HoogleInfo<CR>

" Hoogle for detailed documentation and prompt for input
nnoremap <leader>hI :HoogleInfo 

" Hoogle, close the Hoogle window
nnoremap <silent> <leader>hz :HoogleClose<CR>

" Use same color behind concealed unicode characters
hi clear Conceal

" Pretty unicode haskell symbols
"let g:haskell_conceal_wide = 1
"let g:haskell_conceal_enumerations = 1
"let hscoptions="𝐒𝐓𝐄𝐌xRtB𝔻"

" Haskell Interrogation {{{

set completeopt+=longest

" Use buffer words as default tab completion
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

" But provide (neco-ghc) omnicompletion
if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

let g:haskellmode_completion_ghc = 1
setlocal omnifunc=necoghc#omnifunc

" Show types in completion suggestions
let g:necoghc_enable_detailed_browse = 1

" Haddock directory
let g:haddock_docdir="/usr/local/share/doc/ghc/html/"

" vim-haskell indentation settings
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1

" Tabularize
let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>
