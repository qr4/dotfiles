" Plugin configuration
" Gundo
nnoremap <F5> :GundoToggle<CR>
inoremap <F5> <ESC> :GundoToggle<CR>

" abolish
abbr :S :Subvert
" crs (snake_case), crm (MixedCase), crc (camelCase)

" NerdCommenter
nmap <M-c> <plug>NERDCommenterToggle
vmap <M-c> <plug>NERDCommenterToggle

" alternate
map <C-a> :A<CR>
imap <C-a> :A<CR>
vmap <C-a> :A<CR>

map <C-y> :AV<CR>
imap <C-y> :AV<CR>
vmap <C-y> :AV<CR>

let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../../src,sfr:../include,sfr../inc,reg:/include/src/g/,reg:/inc/src/g/,reg:/src/include/g/,reg:/src/inc/g/,reg:/source/include/g/'

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsListSnippets="<c-s-tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" CtrlP (similar to FuzzyFinder)
map <Leader>ff :CtrlP<CR>
map <Leader>fb :CtrlPBuffer<CR>

" NERDTree
nnoremap <F3> :NERDTreeToggle<CR>

" Tagbar
nnoremap <F4> :TagbarToggle<CR>

" YCM
let g:ycm_allow_changing_updatetime=1
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_confirm_extra_conf = 0
let g:ycm_filepath_completion_use_working_dir = 0
" YCM configs for automatic config generation
let g:ycm_path_root_code_folder = "/home/kurayami/code/src"

" Syntastic
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_check_on_open = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_enable_signs = 1

" EasyMotion
let g:EasyMotion_leader_key = "\\\\"
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade Comment

" airline
let g:airline_powerline_fonts= 1
let g:airline_theme="simple"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_detect_paste = 1

" Flatcolor
let g:flatcolor_cursorlinebold = 1
let g:flatcolor_termcolors = 1

" DoxygenToolkit
let g:DoxygenToolkit_authorName="Vitali Henne"
