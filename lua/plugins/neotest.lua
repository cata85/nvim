return {
    {
        "LazyVim/LazyVim",
    },
    {
        "folke/trouble.nvim",
        opts = { use_diagnostic_signs = true },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/neotest-go",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "folke/neodev.nvim",
        },
        lazy = true,
        opts = {
            status = { virtual_text = true },
            icons = {
                expanded = "",
                child_prefix = "",
                child_indent = "",
                final_child_prefix = "",
                non_collapsible = "",
                collapsed = "",

                passed = "",
                running = "",
                failed = "",
                unknown = "",
            },
        },
        config = function(_, opts)
            local Mapper = require("./utils/mapper")
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
            require("neodev").setup({
                library = { plugins = { "neotest" }, types = true },
            })

            require("neotest").setup({
                adapters = {
                    require("neotest-go")({
                        experimental = {
                            test_table = true,
                        },
                    }),
                },
                opts,
            })

            local single = function()
                require("neotest").run.run()
                require("neotest").output_panel.toggle()
                local win = vim.fn.bufwinid("Neotest Output Panel")
                if win > -1 then
                    vim.api.nvim_set_current_win(win)
                end
            end
            Mapper.map(
                "n",
                "<leader>nt",
                single,
                { noremap = true },
                "NeoTest",
                "NeoTest Single Function",
                "Test Single Function"
            )
            local file = function()
                require("neotest").run.run(vim.fn.expand("%"))
                require("neotest").output_panel.toggle()
                local win = vim.fn.bufwinid("Neotest Output Panel")
                if win > -1 then
                    vim.api.nvim_set_current_win(win)
                end
            end
            Mapper.map("n", "<leader>nf", file, { noremap = true }, "NeoTest", "NeoTest File", "Test File")
            Mapper.map(
                "n",
                "<leader>no",
                "<cmd>lua require('neotest').output.open({ enter = true, auto_close = true })<CR>",
                { noremap = true },
                "NeoTest",
                "NeoTest Output",
                "Test Output"
            )
            local output = function()
                require("neotest").output_panel.toggle()
                local win = vim.fn.bufwinid("Neotest Output Panel")
                if win > -1 then
                    vim.api.nvim_set_current_win(win)
                end
            end
            Mapper.map(
                "n",
                "<leader>npp",
                output,
                { noremap = true },
                "NeoTest",
                "NeoTest Output Panel",
                "Toggle Output Panel"
            )
            Mapper.map(
                "n",
                "<leader>npc",
                "<cmd>lua require('neotest').output_panel.clear()<CR>",
                { noremap = true },
                "NeoTest",
                "NeoTest Output Panel Clear",
                "Clear Output Panel"
            )
            local sum = function()
                require("neotest").summary.toggle()
                local win = vim.fn.bufwinid("Neotest Summary")
                if win > -1 then
                    vim.api.nvim_set_current_win(win)
                end
            end
            Mapper.map(
                "n",
                "<leader>ns",
                sum,
                { noremap = true },
                "NeoTest",
                "NeoTest Summary Toggle",
                "Toggle Summary"
            )
        end,
    },
}
