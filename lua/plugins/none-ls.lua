return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                require("none-ls.diagnostics.flake8"),
                require("none-ls.diagnostics.cpplint"),
                require("none-ls.formatting.jq"),
                require("none-ls.diagnostics.eslint_d"),
                require("none-ls.code_actions.eslint"),
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier,
                -- null_ls.builtins.diagnostics.erb_lint,
                -- null_ls.builtins.diagnostics.rubocop,
                -- null_ls.builtins.formatting.rubocop,
            },
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
