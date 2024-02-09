return {
    {
        "ziontee113/color-picker.nvim",
        config = function()
            local Mapper = require("./utils/mapper")
            require("color-picker").setup({
                ["icons"] = { "ﱢ", "" },
                ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
                ["keymap"] = { -- mapping example:
                    ["U"] = "<Plug>ColorPickerSlider5Decrease",
                    ["O"] = "<Plug>ColorPickerSlider5Increase",
                },
                ["background_highlight_group"] = "Normal", -- default
                ["border_highlight_group"] = "FloatBorder", -- default
                ["text_highlight_group"] = "Normal", --default
            })
            Mapper.map("n", "<leader>pc", "<cmd>PickColor<CR>", { noremap = true, silent = true }, "Color Picker","Color Picker", "Color Picker")
            Mapper.map("i", "<C-e>", "<cmd>PickColorInsert<CR>", { noremap = true, silent = true }, "Color Picker","Color Picker", "Color Picker")
            vim.cmd("highlight FloatBorder guibg=NONE")
        end,
    },
}
