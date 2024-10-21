-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    vim.lsp.set_log_level("debug")

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
    -- Incomplete attempt to search for references to the enclosing function
    -- nmap('<leader>sre', function()
    --     ts_utils = require('nvim-treesitter.ts_utils')
    --     local current_node = ts_utils.get_node_at_cursor()

    --     while current_node do
    --         if current_node:type() == 'function_definition' then
    --             break
    --         end
    --         current_node = current_node:parent()
    --     end

    --     if not current_node then return end

    --     local function_name = (ts_utils.get_node_text(current_node:child(1)))[1]
    -- end, '[S]earch [R]eferences to [E]nclosing Function')
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
end

local function config_fn()
    -- Setup neovim lua configuration
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local lspconfig = require('lspconfig')

    local python_langserver_command = function(root_dir)
        local function path_starts_with(starts)
            for _, start in pairs(starts) do
                if string.sub(root_dir, 1, string.len(start)) == start then return true end
            end
            return false
        end

        local function file_exists(name)
            local f = io.open(name, "r")
            if f ~= nil then
                io.close(f)
                return true
            else
                return false
            end
        end

        local function docker_command()
            local workdir = root_dir:gsub("%/home%/scott%/src%/descript%-ai%-workers%/", "")
            local image = "us-east4-docker.pkg.dev/descript-dev-infra/ci/" .. workdir .. ":dev-dev"
            return {
                "docker",
                "run",
                "--rm",       -- Remove docker container after completion
                "-i",         -- Interactive mode so that nvim can communicate with the server
                "--pid=host", -- The LSP spec has a condition for langauge servers to shut down when their parent has shut down. This allows the language server to see nvim on the host.
                "--volume=/home/scott/src/descript-ai-workers:/home/scott/src/descript-ai-workers",
                "--workdir=" .. root_dir,
                image,
                "run",
                "pyright-langserver",
                "--stdio",
            }
        end

        if path_starts_with({
                "/home/scott/src/descript-ai-workers/pkg-py",
                "/home/scott/src/descript-ai-workers/services",
                "/home/scott/src/descript-ai-workers/tools",
            }) then
            if file_exists(root_dir .. "/override.Dockerfile") then
                return docker_command()
            end
            return { "pdm", "run", "pyright-langserver", "--stdio" }
        end
        return { "pyright-langserver", "--stdio" }
    end

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
    lspconfig.pyright.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        on_new_config = function(new_config, root_dir)
            new_config.cmd = python_langserver_command(root_dir)
        end,
    }
    lspconfig.gopls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
    lspconfig.ts_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
            hostInfo = 'neovim',
            maxTsServerMemory = 8192,
        }
    }
end


return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    priority = 100,
    config = config_fn,
    dependencies = {
        -- Useful status updates for LSP
        { 'j-hui/fidget.nvim', opts = {} },
        'folke/neodev.nvim',
    },
}
