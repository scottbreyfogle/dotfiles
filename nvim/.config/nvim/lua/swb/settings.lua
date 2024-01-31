--
-- Cursor display settings
--
-- Cursor grid
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.colorcolumn = "99"
-- Keep some lines above and below the cursor
vim.opt.scrolloff = 5
-- Match angle brackets
vim.opt.matchpairs = vim.opt.matchpairs + { '<:>' }

--
-- Misc display settings
--
-- Line Numbering for current line, relative for others
vim.opt.number = true
vim.opt.relativenumber = true
-- " Wrap before 100 chars
vim.opt.textwidth = 99
-- Display characters for trailing spaces and tabs
vim.o.listchars = "tab:▸ ,trail:⋅,nbsp:+"
vim.o.list = true
-- Fold with treesitter
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- Don't fold at all when the file is opened
vim.o.nofoldenable = true

--
-- Command history settings
--
-- Show zsh style autocomplete for : commands
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"

--
-- Search Options
--
-- Intelligent case sensitivity (all lowercase is insensitive, any
-- capitalization make search case sensitive)
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- " Default global substitution on lines
vim.opt.gdefault = true
