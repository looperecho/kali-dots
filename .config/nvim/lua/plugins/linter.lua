return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        local null_ls = require("null-ls")
        local sources = {
            null_ls.builtins.diagnostics.flake8.with({
                extra_args = { "--max-line-length", 120 }
            }),
        }

        -- Initial setup with the linter enabled
        null_ls.setup({
            sources = sources,
        })

        -- Track whether the linter is enabled
        local linter_enabled = true

        -- Define a function to toggle the linter
        function ToggleLinter()
            linter_enabled = not linter_enabled
            if linter_enabled then
                null_ls.register(sources)
                print("Linter enabled")
            else
                null_ls.disable({ sources = sources })
                print("Linter disabled")
            end
        end

        -- Set the keymap to toggle the linter
        vim.api.nvim_set_keymap("n", "<leader>td", ":lua ToggleLinter()<CR>", { noremap = true, silent = true, desc = "Diagnostics" })
    end
}
