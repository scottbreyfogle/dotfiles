" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let g:pathogen_disabled = []
" At work, or not:
if filereadable(expand('~/.google/before.vimrc'))
  " Google-only
  source ~/.google/before.vimrc
else
  if filereadable(expand('~/.personal/before.vimrc'))
    source ~/.personal/before.vimrc
  endif
endif

" Misc plugin settings
execute pathogen#infect()
let g:syntastic_mode_map = {'mode': 'passive'}
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

"
" File/buffer settings
"
" Change dir to that of current file
set autochdir
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
set colorcolumn=80
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
" Wrap after 80 chars
set textwidth=80
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
" Eclim gui options
set guioptions-=m
set guioptions-=T
" Disable ycm preview window
let g:ycm_autoclose_preview_window_after_insertion=1
" Populate locations for access by hotkeys
let g:ycm_always_populate_location_list = 1
" Enable the list of buffers
let g:airline#extensions#bufferline#enabled = 1

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
nnoremap <leader>s :SyntasticCheck<cr>
" Eclim commands
nnoremap <leader>el :LocateFile<cr>
nnoremap <leader>ei :JavaImportOrganize<cr>
nnoremap <leader>ef :JavaCorrect<cr>
" YCM tools
nnoremap <leader>g :YcmCompleter GoTo<cr>
nnoremap <leader>yc :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>fi :YcmCompleter FixIt<cr>
" FZF
nnoremap <leader>z :FZF 

"
" Tab settings
"
" Use Spaces instaed of tabs
set expandtab
" Tabs displayed as 2 spaces (for go, other tabbed stuff)
set tabstop=2
" Tab key inserts 2 spaces
set softtabstop=2
" << and >> shift 2 spaces
set shiftwidth=2

"
" Misc Settings
"
" Add keywords for more accurate w and b movement
set iskeyword-=(
set iskeyword-=)
set iskeyword-=.
" Join comment blocks correctly and with gq
set formatoptions+=cjq
" Eclim connection to ycm
let g:EclimCompletionMethod = 'omnifunc'

" At work, or not:
if filereadable(expand('~/.google/after.vimrc'))
  " Google-only
  source ~/.google/after.vimrc
else
  if filereadable(expand('~/.personal/after.vimrc'))
    source ~/.personal/after.vimrc
  endif
endif
