return {
    'zbirenbaum/copilot.lua',
    -- To integrate with cmp (also add copilot as a source in cmp.lua)
    -- 'zbirenbaum/copilot-cmp',
    dependencies = {
        'kamalsacranie/nvim-mapper',
    },
    -- After cmp
    priority = 210,
    config = function()
        require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = false,
                debounce = 200,
            },
            server_opts_overrides = {
                settings = {
                    advanced = {
                        listCount = 5,
                    }
                },
            }
        })

        local suggest = require("copilot.suggestion")
        local map_keymap = require("nvim-mapper").map_keymap
        local copilot_enabled = false
        local cmp_enabled = true

        -- Toggle between cmp autocomplete and copilot. Cmp starts enabled.
        local function toggle_copilot_and_cmp()
            if copilot_enabled then
                suggest.toggle_auto_trigger()
                vim.cmd.EnableCmp()
                cmp_enabled = true
                copilot_enabled = false
            else
                suggest.toggle_auto_trigger()
                vim.cmd.DisableCmp()
                cmp_enabled = false
                copilot_enabled = true
            end
        end
        vim.keymap.set('n', '<leader>pt', toggle_copilot_and_cmp, { desc = 'Co[p]ilot [T]oggle' });

        -- Control space enables copilot for this insert mode only. As above, disable standard
        -- completion to avoid conflicts.
        vim.keymap.set('i', '<c-Space>', function()
            vim.cmd.DisableCmp()
            cmp_enabled = false
            suggest.next()
        end, { desc = 'Manual Copilot Trigger' });
        vim.api.nvim_create_autocmd('InsertLeave', {
            callback = function()
                if not copilot_enabled and not cmp_enabled then
                    vim.cmd.EnableCmp()
                    cmp_enabled = true
                end
            end,
        });

        map_keymap('i', '<Down>', function(fallback)
            if suggest.is_visible() then
                suggest.next()
            else
                fallback()
            end
        end, { desc = 'Copilot Trigger' });
        map_keymap('i', '<Up>', function(fallback)
            if suggest.is_visible() then
                suggest.prev()
            else
                fallback()
            end
        end, { desc = 'Copilot next suggestion' });
        map_keymap('i', '<tab>', function(fallback)
            if suggest.is_visible() then
                suggest.accept()
            else
                fallback()
            end
        end, { desc = 'Copilot last suggestion' });
    end
}
