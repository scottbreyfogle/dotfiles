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

" Show zsh style autocomplete for : commands
set wildmenu
set wildmode=list:longest
" Cursor grid
set cursorline
set cursorcolumn
" Folding
set foldlevelstart=20
nnoremap <space> za
vnoremap <space> zf
" Line Numbering for current line, relative for others
set relativenumber
set number
" Always show status bar
:set laststatus=2
" Intelligent case sensitivity (all lowercase is insensitive, any
" capitalization make search case sensitive)
set ignorecase
set smartcase
" Default global substitustion on lines
set gdefault
" Keep some lines above and below the cursor
set scrolloff=2
" Tab for missing braces
noremap <tab> %

" Leader commands
let mapleader = ","
" Toggle line numbering (for copying) and paste mode on F2
nnoremap <leader>p :set number!<CR>:set relativenumber!<cr>:set foldcolumn=0<CR>:set paste!<CR>
nnoremap <leader><space> :nohlsearch<cr>
nnoremap <leader>v :tabedit ~/.vimrc<cr>
nnoremap <leader>r :source ~/.vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>
nnoremap <leader>ws :w !sudo cat > %<CR>

" Tab settings
set expandtab      " Use Spaces instaed of tabs
set tabstop=4      " Tabs displayed as 4 spaces (for go, other tabbed stuff)
set softtabstop=4  " Tab key inserts 4 spaces
set shiftwidth=4   " << and >> shift 4 spaces
autocmd FileType html,scala,coffee,*.ejs setlocal softtabstop=2
autocmd FileType html,scala,coffee,*.ejs setlocal shiftwidth=2

" Bastardization from too much emacs mode bash
:imap <C-a> <Home>
:imap <C-e> <End>

" Add keywords for more accurate w and b movement
set iskeyword-=(
set iskeyword-=)
set iskeyword-=.

" Pathogen
execute pathogen#infect()
execute pathogen#helptags()

" Colorscheme
set background=dark
let g:solarized_termtrans=1 " Fixes weird blocky issues with solarized vim in solarized consoles
colorscheme solarized

" Whitespace awareness
set listchars=tab:▸\ ,trail:⋅
set list

" Ideavim bell stuff
set visualbell
set noerrorbells

" Automatically source .vimrc when it is saved (from vimcasts.org #24)
if has("autocmd")
  autocmd! bufwritepost .vimrc source $MYVIMRC
endif
