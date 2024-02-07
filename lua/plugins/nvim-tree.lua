return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function ()
            local nvimtree = require("nvim-tree")
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- change color for arrows in tree to light blue
            vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

            nvimtree.setup({
                view = {
                    width = 60,
                    relativenumber = true,
                },
                -- change folder arrow icons
                renderer = {
                indent_markers = {
                  enable = true,
                },
                icons = {
                  glyphs = {
                    folder = {
                      arrow_closed = "►", -- arrow when folder is closed
                      arrow_open = "▼", -- arrow when folder is open
                    },
                  },
                },
              },
              -- disable window_picker for
              -- explorer to work well with
              -- window splits
              actions = {
                open_file = {
                  window_picker = {
                    enable = false,
                  },
                },
              },
              filters = {
                custom = { ".DS_Store" },
              },
              git = {
                ignore = false,
              },
            })
            vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>")
            vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>")
            vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>")
            vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>")
        end
    },
}
