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
vim.opt.termguicolors = true
-- Line Numbering for current line, relative for others
vim.opt.number = true
vim.opt.relativenumber = true
-- Display characters for trailing spaces and tabs
vim.opt.listchars = "tab:▸ ,trail:⋅,nbsp:+"
vim.opt.list = true

--
-- Tab settings
--
-- Use Spaces instead of tabs
vim.opt.expandtab = true
-- Tabs displayed as 4 spaces (for languages where the default expandtab setting is overridden)
vim.opt.tabstop = 4
-- Tab key inserts 4 spaces
vim.opt.softtabstop = 4
-- << and >> shift 4 spaces
vim.opt.shiftwidth = 4

--
-- Search Options
--
-- Intelligent case sensitivity (all lowercase is insensitive, any
-- capitalization make search case sensitive)
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Default global substitution on lines
vim.opt.gdefault = true
