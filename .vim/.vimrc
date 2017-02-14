" the following is for Vundle

set nocompatible	" required
filetype off		" required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'


" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin

Plugin 'vim-scripts/indentpython.vim'		" Python autoindent
"Plugin 'scrooloose/syntastic'			" Python syntax checking
Plugin 'nvie/vim-flake8'			" Python PEP8 checking


" All of your Plugins must be added before the following line
call vundle#end()		" required
filetype plugin indent on	" required

set tabstop=4
set softtabstop=4
set shiftwidth=4

autocmd BufNewFile,BufRead *.py
	\set textwidth=79 |
	\set expandtab |
	\set autoindent |
	\set fileformat=unix |
	\set encoding=utf-8 |
	\let python_highlight_all=1


autocmd BufNewFile,BufRead *.js, *.html, *.css
	\setlocal tabstop=2 |
	\setlocal softtabstop=2 |
	\setlocal shiftwidth=2 

autocmd BufNewfile,BufRead *.c, *.cpp, *.h, *.java |
	\set cindent

"au BufNewFile,BufRead *.c, *.cpp, *.h, *.py, *.pyw match BadWhitespace /\s\+$/

" set line numbers and ability to switch between abs and rel line numbers
set nu
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

set background=dark
syntax on
