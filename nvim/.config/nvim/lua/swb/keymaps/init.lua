local utils = require("swb/utils")

-- TODO: Make settings and if/else for this
if utils.is_mac() then
    -- Mac system copy/paste.
    vim.keymap.set('v', '<leader>c', '"+y')
    vim.keymap.set('v', '<leader>x', '"+x')
    vim.keymap.set('n', '<leader>v', '"+p')
else
    -- System copy/paste over ssh. See https://sunaku.github.io/tmux-yank-osc52.html.
    vim.keymap.set('v', '<leader>c', ':!xclip -f -sel clip<cr>')
    vim.keymap.set('v', '<leader>x', ':!xclip -i -sel clip<cr>')
    vim.keymap.set('n', '<leader>v', ':r!xclip -o -sel clip<cr>')
end

-- Fold toggling with spacebar
vim.o.foldlevelstart = 20
vim.keymap.set('n', '<space>', 'za', { noremap = true })
vim.keymap.set('v', '<space>', 'za', { noremap = true })

-- Clear search highlighting
vim.keymap.set('n', '<leader><space>', vim.cmd.nohlsearch)
-- ' Sort block
-- nnoremap <leader>sb vip:sort<cr>
vim.keymap.set('n', '<leader><space>', vim.cmd.nohlsearch)

-- Formatting
vim.keymap.set('n', '<leader>f', vim.cmd.Format)

-- ' Git
-- nnoremap <leader>gd :Gdiffsplit<cr>
-- nnoremap <leader>gh :GBrowse master%<cr>
-- ' TODO: Find a way to create a visual mapping that searches for the visual selection
-- nnoremap <leader>gg :Glgrep! <c-r><c-w><cr>
-- ' These commands have an optional range, so are remapped in visual and normal mode
-- nnoremap <leader>gb :G blame<cr>
-- vnoremap <leader>gb :G blame<cr>
-- nnoremap <leader>gl :GlLog!<cr>
-- vnoremap <leader>gl :GlLog!<cr>
-- ' NERDTree
-- nnoremap <leader>n :NERDTree<cr>
-- ' Copilot
-- nnoremap <leader>pd :Copilot disable<cr>
-- nnoremap <leader>pe :Copilot enable<cr>
--

-- Keep cursor in the middle when navigating
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Keep cursor in the middle when searching
-- vim.keymap.set('n', 'n', 'nzz')
-- vim.keymap.set('n', 'N', 'Nzz')

-- TODO: What binding for paste over?
-- vim.keymap.set('x', '', '"_dP')
-- TODO: Quickfix list?
-- TODO: Find binding? Make current file executable
-- vim.keymap.set('n', '', '<cmd>!chmod +x %<cr>')
