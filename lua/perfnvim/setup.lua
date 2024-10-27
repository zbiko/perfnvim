-- lua/perfnvim/setup.lua

local constants = require("perfnvim.constants")
local change_helpers = require("perfnvim.helpers.change_helpers")

local function setup()
	vim.api.nvim_set_hl(0, constants.p4addSignHighlight, { fg = "Lime", bg = "NONE" })
	vim.fn.sign_define(constants.p4addSignName, {
		text = "+",
		texthl = constants.p4addSignHighlight,
	})

	vim.api.nvim_set_hl(0, constants.p4changeSignHighlight, { fg = "yellow", bg = "NONE" })
	vim.fn.sign_define(constants.p4changeSignName, {
		text = "~",
		texthl = constants.p4changeSignHighlight,
	})

	vim.api.nvim_set_hl(0, constants.p4deleteSignHighlight, { fg = "red", bg = "NONE" })
	vim.fn.sign_define(constants.p4deleteSignName, {
		text = "_",
		texthl = constants.p4deleteSignHighlight,
	})
	vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
		pattern = "*",
		callback = change_helpers._AnnotateSigns,
	})
end

return {
	setup = setup,
}
