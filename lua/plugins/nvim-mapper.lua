return {
    {
        -- MAPPER use <leader>MM to open the mapper
        "gregorias/nvim-mapper",
        config = function()
            require("nvim-mapper").setup({
                no_map = false,
                search_path = os.getenv("HOME") .. "/.config/nvim/lua",
                action_on_enter = "execute" -- or "definition"
            })
        end,
    },
}
