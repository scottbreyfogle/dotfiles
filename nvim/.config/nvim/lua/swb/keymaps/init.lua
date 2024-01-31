local utils = require("swb/utils")

-- TODO: Make settings and if/else for this
if utils.is_mac() then
    vim.keymap.set('v', '<leader>c', '"+y', { desc = 'Copy to system clipboard' });
    vim.keymap.set('v', '<leader>x', '"+x', { desc = 'Cut to system clipboard' });
    vim.keymap.set('n', '<leader>v', '"+p', { desc = 'Paste from system clipboard' });
else
    -- System copy/paste over ssh. See https://sunaku.github.io/tmux-yank-osc52.html.
    vim.keymap.set('v', '<leader>c', ':!xclip -f -sel clip<cr>', { desc = 'Copy using xclip' });
    vim.keymap.set('v', '<leader>x', ':!xclip -i -sel clip<cr>', { desc = 'Cut using xclip' });
    vim.keymap.set('n', '<leader>v', ':r!xclip -o -sel clip<cr>', { desc = 'Paste from xclip' });
end

vim.keymap.set('n', '<space>', 'za', { noremap = true, desc = 'Toggle folds' });
vim.keymap.set('n', '<leader><space>', vim.cmd.nohlsearch, { desc = 'Clear highlighting' });
vim.keymap.set('n', '<leader>sb', "vip<cmd>sort<cr>", { desc = 'Sort current block' });
vim.keymap.set('n', '<leader>f', vim.cmd.Format, { desc = 'Run formatting' });
vim.keymap.set('n', '<leader>gd', vim.cmd.Gdiffsplit, { desc = 'Diff file with version at head (fugitive)' });
vim.keymap.set('n', '<leader>gh', function()
    vim.cmd('GBrowse master%')
end, { desc = 'Open file in github in a browser' });
-- These commands have an optional range, so are remapped in visual and normal mode
-- TODO: consider converting more to lua?
vim.keymap.set({ 'n', 'v' }, '<leader>gb', ":G blame<cr>", { desc = 'Open blame for the selected range' });
vim.keymap.set({ 'n', 'v' }, '<leader>gl', ":GlLog!<cr>", { desc = 'Open git log for the selected range' });

-- Keep cursor in the middle when navigating/searching
-- I'm not convinced I like this. Leaving it commented for now.
-- vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = '' });
-- vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = '' });
-- vim.keymap.set('n', 'n', 'nzz')
-- vim.keymap.set('n', 'N', 'Nzz')

-- On trial period
vim.keymap.set('x', 'p', '"_dP', { desc = 'Paste over (visual mode only)' })
vim.keymap.set('n', '<leader>me', '<cmd>!chmod +x %<cr>', { desc = 'Make current file executable' })
