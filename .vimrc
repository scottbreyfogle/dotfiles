" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Pathogen
execute pathogen#infect()

" Airline?
set guifont="Ubuntu Mono derivative Powerline"
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

"
" Cursor display settings
"
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Show the cursor position all the time
set ruler
" Cursor grid
set cursorline
set cursorcolumn
" Keep some lines above and below the cursor
set scrolloff=2

"
" Misc display settings
"
" Enable mouse
set mouse=a
" Line Numbering for current line, relative for others
set relativenumber
set number
" Wrap after 78 chars
set textwidth=78
" Always show status bar
set laststatus=2

"
" Command history settings
"
" Keep 50 lines of command line history
set history=50
" Display incomplete commands
set showcmd
" Show zsh style autocomplete for : commands
set wildmenu
set wildmode=list:longest

"
" Search Options
"
" Do incremental searching
set incsearch
" Highlight search terms
set hlsearch
" Intelligent case sensitivity (all lowercase is insensitive, any
" capitalization make search case sensitive)
set ignorecase
set smartcase
" Default global substitution on lines
set gdefault

"
" Display Options
"
" More colors
let t_Co=256
" Syntax highlighting
syntax on
" Autoindentation from files in ~/.vim/indent
filetype plugin indent on
" Folding
set foldlevelstart=20
nnoremap <space> za
vnoremap <space> zf
" Display characters for trailing spaces and tabs
set listchars=tab:▸\ ,trail:⋅
set list
" Colorscheme
set background=dark
let g:solarized_termtrans=1 " Fixes weird blocky issues with solarized vim in solarized consoles
colorscheme solarized

"
" Remap commands
"
" Change default leader key from \ to ,
let mapleader = ","
" Toggle line numbering and paste mode, and open all folds
nnoremap <leader>p :set relativenumber!<cr>:set number!<CR>:set foldcolumn=0<CR>:set paste!<CR>
" Clear search highlighting
nnoremap <leader><space> :nohlsearch<cr>
" Edit vimrc
nnoremap <leader>v :tabedit ~/.vimrc<cr>
" Reload vimrc
nnoremap <leader>r :source ~/.vimrc<CR>:echo 'vimrc reloaded'<CR>
" Hack to save file as sudo
nnoremap <leader>ws :w !sudo cat > %<CR>
nnoremap <leader>e :tabe 
" Tab for missing braces
noremap <tab> %
" Bastardization from too much emacs mode bash
imap <C-a> <Home>
imap <C-e> <End>

"
" Tab settings
"
" Use Spaces instaed of tabs
set expandtab
" Tabs displayed as 4 spaces (for go, other tabbed stuff)
set tabstop=4
" Tab key inserts 4 spaces
set softtabstop=4
" << and >> shift 4 spaces
set shiftwidth=4
" Set smaller indent levels for certain filetypes
autocmd FileType html,scala,coffee,*.ejs setlocal softtabstop=2
autocmd FileType html,scala,coffee,*.ejs setlocal shiftwidth=2

" Add keywords for more accurate w and b movement
set iskeyword-=(
set iskeyword-=)
set iskeyword-=.
