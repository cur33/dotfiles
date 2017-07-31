" Updated for Vim 8.0

filetype plugin indent on	" required

" autocmd BufNewFile,BufRead *.py |
	" \set textwidth=79 |
	" \set expandtab |
	" \set autoindent |
	" \set fileformat=unix |
	" \set encoding=utf-8 |
	" \let python_highlight_all=1

"autocmd Filetype python setlocal encoding=utf-8 fileformat=unix textwidth=79 expandtab autoindent python_highlight_all=1

"autocmd Filetype python |
	"\set encoding=utf-8 |
	"\set expandtab |
	"\set autoindent |
	"\set fileformat=unix |
	"\set textwidth=79 |
	"\set ts=4 |
	"\set sts=4 |
	"\set sw=4

"these are needed because of Ember
set backupdir=C:\Users\Collin\vimfiles\backup\\
set directory=C:\Users\Collin\vimfiles\swap\\
set undodir=C:\Users\Collin\vimfiles\undo\\

set ts=4
set sts=4
set sw=4
set autoindent

autocmd Filetype python setlocal ts=4 sts=4 sw=4 encoding=utf-8 fileformat=unix textwidth=79 expandtab autoindent 

autocmd Filetype html,javascript,php,typescript,vue setlocal ts=2 sts=2 sw=2

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
