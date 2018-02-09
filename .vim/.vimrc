" Author: Collin U. Rapp
"
" Updated for Vim 8.0
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
set wildmenu

set ts=4
set sts=4
set sw=4
set autoindent
set expandtab

"""
" File specific settings
"""

autocmd Filetype python setlocal ts=4 sts=4 sw=4 encoding=utf-8 textwidth=80 expandtab autoindent

autocmd Filetype html,javascript,php,typescript,vue setlocal ts=2 sts=2 sw=2

"autocmd Filetype python setlocal ts=4 sts=4 sw=4 encoding=utf-8 fileformat=unix textwidth=79 expandtab autoindent python_highlight_all=1

autocmd Filetype c,cpp,h,java setlocal ts=4 sts=4 sw=4

"""
" Functions
"""

" Toggles between 4 combinations of number and relativenumber, in order of use
function! NumberToggle()
    if(&relativenumber != 1)
        set number!
    endif
    set relativenumber!

endfunc
nnoremap <C-n> :call NumberToggle()<cr>
"au FocusLost * :set number
"au FocusGained * :set relativenumber
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber

call NumberToggle() " Start with both number styles enabled
set background=dark
syntax on
