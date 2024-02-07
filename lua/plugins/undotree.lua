return {
	{
		"mbbill/undotree",
		config = function()
			local Mapper = require("./utils/mapper")
			Mapper.map(
				"n",
				"<leader>U",
				vim.cmd.UndotreeToggle,
				{ noremap = true },
				"Undotree",
				"Open mbbill undotree",
				"Opens mbbill's undotree (secondary undotree)"
			)
			vim.cmd("let g:undotree_SetFocusWhenToggle = 1")
		end,
	},
}
