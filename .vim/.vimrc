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

" Turn on ruler
"set ruler

" Make backspace behave more normally
set backspace=eol,start,indent

" Make searching more "modern"
" set incsearch hlsearch

"""
" Colors and Fonts
"""

if (!exists("g:syntax_on"))
	syntax enable
endif

set background=dark
set encoding=utf8

"""
" Text, Tab, and Indent
"""

" Expand all tabs to spaces
" set expandtab

" Use sw for tabs at beginning of line, ts and sts for all tabs elsewhere
" set smarttab

" Set all tabs/indentation to 4 columns by default
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

"""
" File specific settings
"""

" Web dev files should default to 2-columns tabs
autocmd Filetype html,xml,xsd,javascript,php,typescript setlocal ts=2 sts=2 sw=2

"autocmd Filetype python setlocal ts=4 sts=4 sw=4 encoding=utf-8 fileformat=unix textwidth=79 expandtab autoindent python_highlight_all=1

"autocmd Filetype c,cpp,h,java setlocal ts=4 sts=4 sw=4 cindent

"""
" Functions
"""

" Set relative line numbers and ability to switch between abs and rel line numbers
set rnu
function! NumberToggle()
	if(&relativenumber == 1)
		set number
	else
		set relativenumber
	endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>
"au FocusLost * :set number
"au FocusGained * :set relativenumber
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber

