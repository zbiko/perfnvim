local setup = require("perfnvim.setup")
local commands = require("perfnvim.commands")
local json = require ("perfnvim.json")
local M = {}

function M.setup()
	vim.api.nvim_create_user_command("P4add", function()
		commands.SelectChangelistInteractively("add")
	end, {})
	vim.api.nvim_create_user_command("P4edit", function()
		commands.SelectChangelistInteractively("edit")
	end, {})
	vim.api.nvim_create_user_command("P4opened", function()
		commands.GetP4Opened()
	end, {})
	vim.api.nvim_create_user_command("P4next", function()
		commands.GoToNextChange()
	end, {})
	vim.api.nvim_create_user_command("P4prev", function()
		commands.GoToPreviousChange()
	end, {})
	setup.setup()

	local update_global_values_cb = vim.uv.new_async(function(changelists, opened_files)
		vim.g.perfnvim_p4_changelists = json.decode(changelists)
		vim.g.perfnvim_p4_opened_files = json.decode(opened_files)
	end)

	local timer = vim.uv.new_timer()
	timer:start(0, 10000, function()
		vim.uv.new_thread({},function (cb)
			local json = require ("perfnvim.json")
			local cmds = require("perfnvim.commands")
			local results = cmds.GetP4Data()
			if results == nil then
				print("Cant connect to P4")
				return
			end
			local serialized_changelists = json.encode(results.changelists)
			local serialized_files = json.encode(results.files)
			vim.uv.async_send(cb, serialized_changelists, serialized_files)
		end, update_global_values_cb)
	end)

end

function M.P4add()
	commands.SelectChangelistInteractively("add")
end

function M.P4edit()
	commands.SelectChangelistInteractively("edit")
end

function M.P4opened()
	commands.GetP4Opened()
end

function M.P4next()
	commands.GoToNextChange()
end

function M.P4prev()
	commands.GoToPreviousChange()
end

return M
