return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
    },

    config = function()

        require("mason").setup({
            ensure_installed = {
                "flake8",
            }
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "jedi_language_server",
            }
        })

        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Python, Jedi LSP
        lspconfig.jedi_language_server.setup{
            filetypes = {'py', 'spec'},
            capabilities = capabilities
        }

        lspconfig.lua_ls.setup{
        }

        -- Python, ruff as lint
        -- lspconfig.ruff.setup({
        --     settings = {
        --         organizeImports = false,
        --     },
        --     -- diable ruff as hoverProvider, avoids confict with Jedi lsp
        --     on_attach = function(client) client.server_capabilities.hoverProvider = false end,
        -- })
    end
}
