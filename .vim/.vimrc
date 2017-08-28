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

"these are needed because of Ember
set backupdir=C:\Users\Collin\vimfiles\backup\\
set directory=C:\Users\Collin\vimfiles\swap\\
set undodir=C:\Users\Collin\vimfiles\undo\\

set ts=4
set sts=4
set sw=4
set autoindent

"""
" File specific settings
"""

autocmd Filetype html,javascript,php,typescript,vue setlocal ts=2 sts=2 sw=2

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

