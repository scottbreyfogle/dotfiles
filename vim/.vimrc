" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let g:pathogen_disabled = []
if filereadable(expand('~/.before.vimrc'))
  source ~/.before.vimrc
endif

" Misc plugin settings
execute pathogen#infect()
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:flake8_show_in_gutter = 1

"
" File/buffer settings
"
" Switching buffers keeps other files open so you don't have to save & lose
" history when switching
set hidden
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif
" Move backup/swap/undo files to a global location (rather than local per file)
let &backupdir=expand('~/.vim_files//')
let &directory=expand('~/.vim_files//')
let &undodir=expand('~/.vim_files//')

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
set colorcolumn=99
" Keep some lines above and below the cursor
set scrolloff=2
" Match angle brackets
set matchpairs+=<:>

"
" Misc display settings
"
" Enable mouse
set mouse=a
" Line Numbering for current line, relative for others
set relativenumber
set number
" Wrap before 100 chars
set textwidth=99
" Always show status bar
set laststatus=2
" My typing is terrible, and it's hard to see your own typos
set spell

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
" Disable ycm preview window
let g:ycm_autoclose_preview_window_after_insertion=1
" Populate locations for access by hotkeys
let g:ycm_always_populate_location_list = 1
" Enable the list of buffers
let g:airline#extensions#bufferline#enabled = 1
" Open quickfix after grep or git grep
autocmd QuickFixCmdPost *grep* cwindow

"
" Remap commands
"
" Tab for matching braces
noremap <tab> %
" Capital y should work like capital d
nnoremap Y y$

" Leader Commands
" Change default leader key from \ to ,
let mapleader = ","
" Toggle line numbering and paste mode, and open all folds
nnoremap <leader>p :set relativenumber!<cr>:set number!<cr>:set foldcolumn=0<cr>:set paste!<cr>
" System copy/paste over ssh. See https://sunaku.github.io/tmux-yank-osc52.html.
if has('gui_running') || has('nvim') && exists('$DISPLAY')
  xnoremap <leader>c :!xclip -f -sel clip<cr>
else
  " copy to attached terminal using a custom ~/bin/yank script:
  xnoremap <Leader>c y:call system('yank > /dev/tty', @0)<cr>
endif
xnoremap <leader>x :!xclip -i -sel clip<cr>
nnoremap <leader>v :r!xclip -o -sel clip<cr>
" Clear search highlighting
nnoremap <leader><space> :nohlsearch<cr>
" Sort block
nnoremap <leader>sb vip:sort<cr>
" Edit vimrc
nnoremap <leader>rc :edit ~/.vimrc<cr>
" Reload vimrc
nnoremap <leader>r :source ~/.vimrc<cr>:echo 'vimrc reloaded'<cr>
" YCM tools
nnoremap <leader>gt :YcmCompleter GoTo<cr>
nnoremap <leader>yc :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>fi :YcmCompleter FixIt<cr>
" FZF
nnoremap <leader>z :FZF<cr>
" Formatting
nnoremap <leader>f :Neoformat<cr>
autocmd BufWritePre * Neoformat
" Git
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gh :Gbrowse<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gg :Ggrep 
" NERDTree
nnoremap <leader>n :NERDTree<cr>

"
" Tab settings
"
" Use Spaces instead of tabs
set expandtab
" Tabs displayed as 4 spaces (for languages where the default expandtab setting is overridden)
set tabstop=4
" Tab key inserts 4 spaces
set softtabstop=4
" << and >> shift 4 spaces
set shiftwidth=4

"
" Misc Settings
"
" Add keywords for more accurate w and b movement
set iskeyword-=(
set iskeyword-=)
set iskeyword-=.
" Join comment blocks correctly and with gq
set formatoptions+=cjq

" At work, or not:
if filereadable(expand('~/.after.vimrc'))
  source ~/.after.vimrc
endif