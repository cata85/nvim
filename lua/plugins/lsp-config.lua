return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = false,
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        local message =
                        diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                        return message
                    end,
                },
            }, neotest_ns)

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "<leader>gd", function()
                    vim.lsp.buf.definition()
                end, opts)
                vim.keymap.set("n", "K", function()
                    vim.lsp.buf.hover()
                end, opts)
                vim.keymap.set("n", "<leader>vws", function()
                    vim.lsp.buf.workspace_symbol()
                end, opts)
                vim.keymap.set("n", "<leader>vd", function()
                    vim.lsp.diagnostics.open_float()
                end, opts)
                vim.keymap.set("n", "]d", function()
                    vim.lsp.diagnostics.goto_next()
                end, opts)
                vim.keymap.set("n", "[d", function()
                    vim.lsp.diagnostics.goto_prev()
                end, opts)
                vim.keymap.set("n", "<leader>ga", function()
                    vim.lsp.buf.code_action()
                end, opts)
                vim.keymap.set("n", "<leader>gr", function()
                    vim.lsp.buf.references()
                end, opts)
                vim.keymap.set("n", "<leader>gn", function()
                    vim.lsp.buf.rename()
                end, opts)
                vim.keymap.set("i", "<C-g>", function()
                    vim.lsp.buf.signature_help()
                end, opts)
            end)

            -- to learn how to use mason.nvim with lsp-zero
            -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            require("mason").setup({
                PATH = "prepend",
            })
            local util = require("lspconfig/util")
            require("mason-lspconfig").setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    gopls = function ()
                        require("lspconfig").gopls.setup({
                            single_file_support = false,
                            cmd = { "gopls" },
                            filetypes = { "go", "gomod", "gowork", "gotmpl" },
                            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                            settings = {
                                gopls = {
                                    completeUnimported = true,
                                    usePlaceholders = true,
                                    analyses = {
                                        unusedparams = true,
                                    },
                                },
                            },
                        })
                    end
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
        end,
    },
    { "hrsh7th/cmp-nvim-lsp" },
    { 
        "hrsh7th/nvim-cmp",
        lazy = false,
    },
    { "L3MON4D3/LuaSnip" },
}
