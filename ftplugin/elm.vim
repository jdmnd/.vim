let g:elm_format_autosave = 1

let g:elm_jump_to_error = 0
let g:elm_make_output_file = "elm.js"
let g:elm_make_show_warnings = 0
let g:elm_syntastic_show_warnings = 0
let g:elm_browser_command = ""
let g:elm_detailed_complete = 0
let g:elm_format_fail_silently = 0
let g:elm_setup_keybindings = 1

let g:ale_fixers = ["elm-format"]
let g:ale_fix_on_save = 1

nnoremap <silent><leader>m :ElmMake<CR>

set shiftwidth=4
