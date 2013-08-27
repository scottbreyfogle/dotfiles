" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50   " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set showcmd      " display incomplete commands
set incsearch    " do incremental searching

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif

" Folding
autocmd FileType python setlocal foldmethod=indent
autocmd FileType python setlocal foldnestmax=2
autocmd FileType c setlocal foldmethod=syntax
autocmd FileType c setlocal foldnestmax=1
autocmd FileType go setlocal foldmethod=syntax
autocmd FileType go setlocal foldnestmax=1
set foldlevelstart=20
nnoremap <space> za
vnoremap <space> zf

" Line Numbering with F2 toggle
set number
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" More syntax 
autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

" Tab settings
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd FileType go setlocal noexpandtab 
autocmd FileType html setlocal tabstop=2
autocmd FileType html setlocal softtabstop=2
autocmd FileType html setlocal shiftwidth=2
autocmd FileType scala setlocal tabstop=2
autocmd FileType scala setlocal softtabstop=2
autocmd FileType scala setlocal shiftwidth=2

" Auto exit to command mode on permutations of j and k
:imap jk <Esc>
:imap jj <Esc>
:imap kk <Esc>
:imap kj <Esc>

" Add keywords for more accurate w and b movement
set iskeyword-=(
set iskeyword-=)
set iskeyword-=.

" Colorscheme
" set background=light
" colorscheme solarized
