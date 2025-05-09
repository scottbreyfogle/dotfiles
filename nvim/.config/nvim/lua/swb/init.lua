local lazypath = vim.fn.stdpath 'data' .. '/lazy'
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ','
require("lazy").setup("swb/plugins",
    {
        root = vim.fn.stdpath 'data' .. '/lazy_packages',
        change_detection = { enabled = false },
    }
)
require("swb/keymaps")
require("swb/settings")
