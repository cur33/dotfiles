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

Plugin 'leafgarland/typescript-vim'			" Typescript file format


" All of your Plugins must be added before the following line
call vundle#end()		" required
filetype plugin indent on	" required

autocmd BufNewFile,BufRead *.py |
	\set textwidth=79 |
	\set expandtab |
	\set autoindent |
	\set fileformat=unix |
	\set encoding=utf-8 |
	\let python_highlight_all=1

autocmd Filetype py setlocal encoding=utf-8 fileformat=unix textwidth=79 expandtab autoindent python_highlight_all=1

autocmd Filetype html,javascript,php,typescript,json setlocal ts=2 sts=2 sw=2

autocmd Filetype c,cpp,h,java setlocal ts=4 sts=4 sw=4

"autocmd BufNewfile,BufRead *.c, *.cpp, *.h, *.java |
	"\set cindent

"au BufNewFile,BufRead *.c, *.cpp, *.h, *.py, *.pyw match BadWhitespace /\s\+$/

" set relative line numbers and ability to switch between abs and rel line numbers
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

set background=dark
syntax on
