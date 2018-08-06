" Author: Collin U. Rapp
"
" Vim config file intended for use with Vim 8
"
" Some ideas taken from the basic.vim file at 
" https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim


"""
" Basic settings
"""

" Required
filetype plugin indent on

" Set to auto read when a file is changed from the outside
" set autoread

" Turn on wildmenu for command autocomplete
" set wildmenu
" and:
" set wildmode=longest:full,full
" or
" set wildmode=longest:list,full

" Use 4 spaces as tabs for most situations
set ts=4
set sts=4
set sw=4
set autoindent
set expandtab

" Wrap lines at 80 characters by default
set textwidth=80

" t=auto-wrap, c=in comments, r=on return, q=format comments
" note: may want l and o in the future
" seems to be overwritten for some langs, like C[++]
set formatoptions=tcrq

" Because it makes sense
set encoding=utf-8


"""
" Plugin settings
"""

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

" Checkers
let g:syntastic_python_checkers = ['pylint', 'pycodestyle']

" Alias syntastic commands
cnoreabbrev syncheck SyntasticCheck
cnoreabbrev synreset SyntasticReset
cnoreabbrev syntoggle SyntasticToggleMode
cnoreabbrev synfo SyntasticInfo


"""
" Language-specific settings
"""

" Java
autocmd Filetype java setlocal textwidth=100

" Web dev
autocmd Filetype html,javascript,typescript,php,vue setlocal ts=2 sts=2 sw=2


"""
" Functions
"""

" Toggles between 4 combos of number and relativenumber, in order of use
function! NumberToggle()
    if (&relativenumber != 1)
        set number!
    endif
    set relativenumber!
endfunc

" Toggles line width column
function! ColorColumnToggle()
    if (&colorcolumn == "")
        set colorcolumn=+1
    else
        set colorcolumn=""
    endif
endfunc


"""
" Key mappings
"""

" Map Ctrl-n to toggle line numbers in normal mode
nnoremap <C-n> :call NumberToggle()<cr>

" Map Ctrl-h to toggle color column in normal & insert modes
nnoremap <C-h> :call ColorColumnToggle()<cr>
inoremap <C-h> <C-O>:call ColorColumnToggle()<cr>


"""
" Colors and appearance
"""

if !exists("g:syntax_on")
    syntax enable
endif

set background=dark
hi ColorColumn ctermbg=lightgrey

if has("win32")
    colorscheme koehler " Because cmd.exe is lame
endif


"""
" Initial calls
"""

call NumberToggle()
call ColorColumnToggle()
