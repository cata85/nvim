return {
    {
        "tomasky/bookmarks.nvim",
        priority = 100,
        event = "VimEnter",
        lazy = false,
        config = function()
            local Mapper = require("./utils/mapper")
            require("bookmarks").setup({
                sign_priority = 8, --set bookmark sign priority to cover other sign
                save_file = vim.fn.expand("$HOME/.bookmarks"), -- bookmarks save file path
                keywords = {
                    ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
                    ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
                    ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
                    ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
                },
                on_attach = function(bufnr)
                    local bm = require("bookmarks")
                    local actions = require("bookmarks.actions")
                    Mapper.map(
                        "n",
                        "mm",
                        bm.bookmark_toggle,
                        { noremap = true },
                        "Bookmarks",
                        "Toggle Bookmark",
                        "Add or remove bookmark at current line."
                    )
                    Mapper.map(
                        "n",
                        "mi",
                        bm.bookmark_ann,
                        { noremap = true },
                        "Bookmarks",
                        "Edit Bookmark",
                        "Add or edit mark annotation at current line."
                    )
                    Mapper.map(
                        "n",
                        "<leader>mc",
                        bm.bookmark_clean,
                        { noremap = true },
                        "Bookmarks",
                        "Clear Bookmarks",
                        "Clean all marks in local buffer."
                    )
                    local next_refresh = function()
                        actions.refresh()
                        bm.bookmark_next()
                    end
                    Mapper.map(
                        "n",
                        "mn",
                        next_refresh,
                        { noremap = true },
                        "Bookmarks",
                        "Next Bookmark",
                        "Jump to next mark in local buffer."
                    )
                    local prev_refresh = function()
                        actions.refresh()
                        bm.bookmark_prev()
                    end
                    Mapper.map(
                        "n",
                        "mp",
                        prev_refresh,
                        { noremap = true },
                        "Bookmarks",
                        "Previous Bookmark",
                        "Jump to previous mark in local buffer."
                    )
                end,
            })
            Mapper.map(
                "n",
                "ml",
                ":Telescope bookmarks list<CR>",
                { noremap = true },
                "Bookmarks",
                "Show Bookmarks List",
                "Show marked file list in quickfix window."
            )
            require("telescope").load_extension("bookmarks")
        end,
    },
}
