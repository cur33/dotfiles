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
" set wildmenu
" and:
" set wildmode=longest:full,full
" or
" set wildmode=longest:list,full

set ts=4 sts=4 sw=4
set autoindent expandtab


"""
" Language-specific settings
"""

" Python
" possibly also: fileformat=unix textwidth=79 python_highlight_all=1
autocmd Filetype python setlocal encoding=utf-8 textwidth=80

" C-like
autocmd Filetype c,cpp,h,java setlocal ts=4 sts=4 sw=4

" Web dev
autocmd Filetype html,javascript,typescript,php,vue setlocal ts=2 sts=2 sw=2


"""
" Functions
"""

" Toggles between 4 combos of number and relativenumber, in order of use
function! NumberToggle()
    if(&relativenumber != 1)
        set number!
    endif
    set relativenumber!
endfunc

" Set key mapping for function & call on startup
nnoremap <C-n> :call NumberToggle()<cr>
call NumberToggle()


"""
" Colors and appearance
"""

set background=dark
syntax on
