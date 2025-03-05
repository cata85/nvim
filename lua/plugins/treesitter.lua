return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    init = function()
      require("nvim-treesitter.install").compilers = { vim.fn.getenv("CC"), "cc", "clang", "cl", "gcc" }
    end,
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        --compilers = { "clang" },
        auto_install = true,
        highlight = { enable = true },
        sync_install = true,
        indent = { enable = true },
        ensure_installed = {
          "c",
          "cpp",
          "lua",
        },
      })
    end
  }
}
