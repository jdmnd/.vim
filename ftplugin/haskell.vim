setlocal omnifunc=necoghc#omnifunc

" Type of expression under cursor
nmap <silent> <leader>ht :w<CR>:GhcModType<CR>
" Insert type of expression under cursor
nmap <silent> <leader>hT :w<CR>:GhcModTypeInsert<CR>
" GHC errors and warnings
nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>

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
let g:SuperTabDefaultCompletionType = '<c-x><c-p>'

" But provide (neco-ghc) omnicompletion
if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

" Show types in completion suggestions
let g:necoghc_enable_detailed_browse = 1
