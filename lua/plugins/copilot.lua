return {
	"github/copilot.vim",
	config = function()
		local Mapper = require(".utils.mapper")
		Mapper.map(
			"i",
			"<C-j>",
			'copilot#Accept("<CR>")',
			{ expr = true, replace_keycodes = false, noremap = true },
			"Copilot",
			"Copilot Accept",
			"Accept the current suggestion"
		)
		Mapper.map(
			"i",
			"<C-Right>",
			"<Plug>(copilot-next)",
			{ noremap = true },
			"Copilot",
			"Copilot Next",
			"Move to the next suggestion"
		)
		Mapper.map(
			"i",
			"<C-Left>",
			"<Plug>(copilot-previous)",
			{ noremap = true },
			"Copilot",
			"Copilot Previous",
			"Move to the previous suggestion"
		)
		Mapper.map(
			"i",
			"<C-h>",
			"<Plug>(copilot-dismiss)",
			{ noremap = true },
			"Copilot",
			"Copilot Dismiss",
			"Dismiss the current suggestion"
		)
		Mapper.map(
			"i",
			"<C-l>",
			"<Plug>(copilot-suggest)",
			{ noremap = true },
			"Copilot",
			"Copilot Suggest",
			"Suggest a new completion"
		)
	end,
}
