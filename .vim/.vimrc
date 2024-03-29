" Author: Collin U. Rapp
" Vim config file intended for use with Vim 8 (b/c built-in package loading is gr8)
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

" Spacing & indentation
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
" set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch

" Enable Vim to jump to the last position when reopening a file
" Alternatively, disable this and use the normal mode command '" when opening a
" file
" Taken from https://stackoverflow.com/a/774599/9201637
" if has("autocmd")
  " au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    " \| exe "normal! g`\"" | endif
" endif


"""
" Plugin settings
"""

" Vim-polyglot settings


" Vue
" If only HTML, JavaScript, and CSS are used, no preprocessors are needed, and
" failing to specify that can slow down the vim-vue plugin
let g:vue_pre_processors = []

" Sometimes the html5 plugin used by polyglot has issues that vanilla vim
" doesn't; toggle this as needed
" let g:polyglot_disabled = ['html5']


" Haskell
" let g:haskell_indent_disable = 1
" let g:haskell_indent_if = 3
" let g:haskell_indent_case = 2
" let g:haskell_indent_let = 4
" let g:haskell_indent_where = 6
" let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 0
" let g:haskell_indent_do = 3
" let g:haskell_indent_in = 1
" let g:haskell_indent_guard = 2
" let g:haskell_indent_case_alternative = 1
" let g:cabal_indent_section = 2


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
" let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
" let g:NERDDefaultAlignt = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" This allows for use of NERDCommenter in .vue files
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction


"""
" Language-specific settings
"""


" Crystal
autocmd Filetype crystal setlocal ts=2 sts=2 sw=2


" Java
autocmd Filetype java setlocal textwidth=100


" Markup & Data File Formats
autocmd Filetype html,handlebars,xml,xsd,json,eruby setlocal ts=2 sts=2 sw=2
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"


" Ruby
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2


" Web dev
" Get PHP indenting to work better
" Taken from: https://stackoverflow.com/questions/459478/correct-indentation-of-html-and-php-using-vim
autocmd Filetype php setlocal filetype=html syn=php
autocmd Filetype javascript,typescript,php,vue setlocal ts=2 sts=2 sw=2


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
    colorscheme koehler   " Because cmd.exe is lame
endif

" Has to be last to overwrite chosen scheme
hi ColorColumn ctermbg=lightgrey


"""
" Initial function calls
"""

call NumberToggle()
" call ColorColumnToggle() " Don't call by default anymore

