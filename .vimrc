" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50   " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set showcmd      " display incomplete commands
set incsearch    " do incremental searching
let t_Co=256     " More colors

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

" BEGIN MY CHANGES

" Colorscheme
set background=dark
let g:solarized_termtrans=1 " Fixes weird blocky issues with solarized vim in solarized consoles
colorscheme solarized

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

" Line Numbering
set number

" Toggle line numbering (for copying) and paste mode on F2
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>:set paste!<CR>

" More syntax
autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

" Tab settings
set expandtab      " Use Spaces instaed of tabs
set tabstop=4      " Tabs displayed as 4 spaces (for go, other tabbed stuff)
set softtabstop=4  " Tab key inserts 4 spaces
set shiftwidth=4   " << and >> shift 4 spaces
autocmd FileType go setlocal noexpandtab      # Go Tabs
autocmd FileType html setlocal softtabstop=2
autocmd FileType html setlocal shiftwidth=2
autocmd FileType scala setlocal softtabstop=2
autocmd FileType scala setlocal shiftwidth=2

" End of line whitepace highlighting
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Highlight out of place tabs or spaces
highlight BadTabs ctermbg=red guibg=red
highlight BadSpaces ctermbg=red guibg=red
match BadTabs /\t/
match BadSpaces //
autocmd FileType go match BadTabs //
autocmd FileType go match BadSpaces /^\t*\zs \+/

" Auto exit to command mode on permutations of j and k
:imap jk <Esc>
:imap jj <Esc>
:imap kk <Esc>
:imap kj <Esc>

" Bastardization from too much emacs mode bash
:map <C-a> <Home>
:map <C-e> <End>
:imap <C-a> <Home>
:imap <C-e> <End>

" Add keywords for more accurate w and b movement
set iskeyword-=(
set iskeyword-=)
set iskeyword-=.

" Airline
:set laststatus=2

" Pathogen
execute pathogen#infect()
execute pathogen#helptags()
