return {
    'zbirenbaum/copilot-cmp',
    dependencies = {
        'zbirenbaum/copilot.lua',
    },
    priority = 110,
    config = function()
        require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
            server_opts_overrides = {
                settings = {
                    advanced = {
                        listCount = 5,
                    }
                },
            }
        })
        require("copilot_cmp").setup({})
    end
}
