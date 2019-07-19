" Author: Collin U. Rapp
"
" Vim config file intended for use with Vim 8 (b/c package loading is gr8)
"
" Some ideas taken from the basic.vim file at 
" https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
"
" Some ideas and tips taken from this post:
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/


"""
" Basic settings
"""

" Important and useful
filetype plugin indent on

" Show file info in the statusline
set laststatus=2        " Sacrifice a screen line to always show the statusline
set statusline+=%t      " Show only the filename
" set statuslines+=%F   " Show the full filepath

" Misc
set modelines=0
set ttyfast
set hidden
set showmode
set backspace=indent,eol,start
" set showcmd
" set cursorline

" Set to auto read when a file is changed externally
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
" seems to be overwritten for some langs, like C[++], probably by plugins
set formatoptions=tcrq

" Because it makes sense
set encoding=utf-8

" Searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch


"""
" Plugin settings
"""

" Syntastic settings

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

" NERD settings

" Alias NERD commands
cnoreabbrev nerdtt NERDTreeToggle

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
" let g:NERDDefaultAlignt = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1


"""
" Language-specific settings
"""

" Java
autocmd Filetype java setlocal textwidth=100

" Markup, etc.
autocmd Filetype html,xml,xsd,json setlocal ts=2 sts=2 sw=2

" Web dev
autocmd Filetype typescript,vue setlocal ts=2 sts=2 sw=2
" autocmd Filetype javascript,typescript,php,vue setlocal ts=2 sts=2 sw=2


"""
" Functions and Commands
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

" Taken from http://vim.wikia.com/wiki/Super_retab
" command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
" command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction

command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)


"""
" Key mappings
"""

" Remap leader key
let mapleader = "'"

" Map Ctrl-n to toggle line numbers in normal mode
nnoremap <C-n> :call NumberToggle()<cr>

" Map Ctrl-h to toggle color column in normal & insert modes
nnoremap <C-h> :call ColorColumnToggle()<cr>
inoremap <C-h> <C-O>:call ColorColumnToggle()<cr>

" Split window
" TODO find better character combos for these
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l


"""
" Colors and appearance
"""

if !exists("g:syntax_on")
    syntax enable
endif

" Night makes right?
set background=dark

if has("win32")
    " Because cmd.exe is lame
    colorscheme koehler
endif

" Has to be last to overwrite chosen scheme
hi ColorColumn ctermbg=lightgrey


"""
" Initial function calls
"""

call NumberToggle()
"call ColorColumnToggle()
