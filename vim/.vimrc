let g:pathogen_disabled = []
if filereadable(expand('~/.before.vimrc'))
  source ~/.before.vimrc
endif

" Misc plugin settings
execute pathogen#infect()
let g:ale_echo_msg_format = '[%linter%] %s'
let g:neoformat_only_msg_on_error = 1

"
" File/buffer settings
"
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
" Line Numbering for current line, relative for others
set relativenumber
set number
" Wrap before 100 chars
set textwidth=99
" My typing is terrible, and it's hard to see your own typos
set spell

"
" Command history settings
"
" Show zsh style autocomplete for : commands
set wildmenu
set wildmode=list:longest

"
" Search Options
"
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
" Autoindentation from files in ~/.vim/indent
filetype plugin indent on
" Fold toggling with spacebar
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
" Open quickfix after grep or git grep
autocmd QuickFixCmdPost *grep* cwindow

" Leader Commands
" Change default leader key from \ to ,
let mapleader = ","
" Toggle line numbering and paste mode, and open all folds
nnoremap <leader>p :set relativenumber!<cr>:set number!<cr>:set foldcolumn=0<cr>:set paste!<cr>
" System copy/paste over ssh. See https://sunaku.github.io/tmux-yank-osc52.html.
vnoremap <leader>c :!xclip -f -sel clip<cr>
vnoremap <leader>x :!xclip -i -sel clip<cr>
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
" TODO: Add something for fzf searching buffers
nnoremap <leader>z :FZF<cr>
" Formatting
nnoremap <leader>f :Neoformat<cr>
autocmd BufWritePre *.go Neoformat
autocmd BufWritePre *.py Neoformat
" Git
nnoremap <leader>gd :Gdiffsplit<cr>
nnoremap <leader>gh :GBrowse master%<cr>
" TODO: Find a way to create a visual mapping that searches for the visual selection
nnoremap <leader>gg :Glgrep! <c-r><c-w><cr>
" These commands have an optional range, so are remapped in visual and normal mode
nnoremap <leader>gb :G blame<cr>
vnoremap <leader>gb :G blame<cr>
nnoremap <leader>gl :GlLog!<cr>
vnoremap <leader>gl :GlLog!<cr>
" NERDTree
nnoremap <leader>n :NERDTree<cr>
" Copilot
nnoremap <leader>pd :Copilot disable<cr>
nnoremap <leader>pe :Copilot enable<cr>

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
