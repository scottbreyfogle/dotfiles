utils = require('swb/utils')

-- Custom live_grep function to search in git root
local function live_grep_git_root()
    local git_root = utils.find_git_root()
    if git_root then
        require('telescope.builtin').live_grep {
            search_dirs = { git_root },
        }
    end
end

local function create_keymaps()
    local builtin = require('telescope.builtin')
    local function telescope_live_grep_open_files()
        require('telescope.builtin').live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
        }
    end
    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>b', builtin.current_buffer_fuzzy_find,
        { desc = 'Fuzzily search in current [b]uffer' })
    -- TODO: Searches for the visual selection?
    vim.keymap.set('n', '<leader>so', telescope_live_grep_open_files, { desc = '[S]earch in [O]pen Files' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sf', builtin.git_files, { desc = '[S]earch Git [F]iles' })
    vim.keymap.set('n', '<leader>sa', builtin.find_files, { desc = '[S]earch [A]ll Files' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sc', builtin.resume, { desc = '[S]earch [C]ontinue' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

    vim.keymap.set('c', '<c-R>', builtin.command_history, { desc = 'Search history' })
    vim.keymap.set('c', '<c-T>', builtin.find_files, { desc = 'Find files in cmd' })
end

-- Fuzzy Finder (files, lsp, etc)
return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    config = function()
        require('telescope').setup({
            defaults = {

            }
        })
        pcall(require('telescope').load_extension, 'fzf')
        vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
        create_keymaps()
    end,
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    },
}
