return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = "VimEnter",
        opts = {
            provider_selector = function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end,
        },
        config = function(_, opts)
            local Mapper = require("./utils/mapper")
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' 󰁂 %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, {chunkText, hlGroup})
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, {suffix, 'MoreMsg'})
                return newVirtText
            end
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
            vim.o.foldcolumn = "0"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.cmd([[hi default UfoFoldedFg guifg=Normal.foreground]])
            vim.cmd([[hi default UfoFoldedBg guibg=Normal.background]])
            vim.cmd([[hi default link UfoPreviewSbar PmenuSbar]])
            vim.cmd([[hi default link UfoPreviewThumb PmenuThumb]])
            vim.cmd([[hi default link UfoPreviewWinBar UfoFoldedBg]])
            vim.cmd([[hi default link UfoPreviewCursorLine Visual]])
            vim.cmd([[hi default link UfoFoldedEllipsis Comment]])
            vim.cmd([[hi default link UfoCursorFoldedLine CursorLine]])
            local ufo = require("ufo")
            ufo.setup({
                fold_virt_text_handler = handler,
                opts,
            })

            Mapper.map("n", "zm", function() require("ufo").closeAllFolds() end, { noremap = true }, "UFO", "Close All Folds", " 󱃄 Close All Folds")
            Mapper.map("n", "zk", function() require("ufo").goPreviousClosedFold() end, { noremap = true }, "UFO", "Goto Previous Fold", " 󱃄 Goto Prev Fold")
            Mapper.map("n", "zj", function() require("ufo").goNextClosedFold() end, { noremap = true }, "UFO", "Goto Next Fold", " 󱃄 Goto Next Fold")
            Mapper.map("n", "zr", function() require("ufo").openFoldsExceptKinds { "comment", "imports" } end, { noremap = true }, "UFO", "Open All Regular Folds", " 󱃄 Open All Regular Folds")
            Mapper.map("n", "zR", function() require("ufo").openFoldsExceptKinds {} end, { noremap = true }, "UFO", "Open All Folds", " 󱃄 Open All Folds")

            Mapper.map("n", "K", function()
                local winid = ufo.peekFoldedLinesUnderCursor(true)
                if not winid then
                    vim.lsp.buf.hover()
                end
            end, { noremap = true }, "UFO", "Peek Folded Lines", " 󱃄 Peek Folded Lines")
        end,
    },
}
