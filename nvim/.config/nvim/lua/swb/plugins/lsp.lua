-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('<leader>sr', function()
        require('telescope.builtin').lsp_references({
            include_declaration = false,
            show_line = false,
        })
    end, '[S]earch [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
        vim.lsp.buf.format({
            filter = function(client)
                local blacklist = { "tsserver", "pyright" }
                for _, val in pairs(blacklist) do
                    if client.name == val then return false end
                end
                return true
            end
        })
    end, { desc = 'Format current buffer with LSP' })
end

local function config()
    -- Setup neovim lua configuration
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local lspconfig = require('lspconfig')

    lspconfig.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            Lua = {
                workspace = {
                    checkThirdParty = false
                },
                runtime = {
                    version = 'LuaJIT',
                },
                library = {
                    vim.env.VIMRUNTIME
                },
                telemetry = { enable = false },
            },
        },
    }
    lspconfig.clangd.setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
    -- TODO: Dynamically switch betwen pdm, docker, and vanilla langservers.
    lspconfig.pyright.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "pdm", "run", "pyright-langserver", "--stdio" },
    }
    lspconfig.gopls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
    lspconfig.tsserver.setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end


return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    priority = 100,
    config = config,
    dependencies = {
        -- Useful status updates for LSP
        { 'j-hui/fidget.nvim', opts = {} },
        'folke/neodev.nvim',
    },
}
