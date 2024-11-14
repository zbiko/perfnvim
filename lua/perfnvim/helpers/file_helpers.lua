local client_helpers = require("perfnvim.helpers.client_helpers")
local M = {}

-- Get the opened Perforce file paths
function M._GetP4OpenedPaths()
	local client_root = client_helpers._GetClientRoot()
	if not client_root then
		print("Failed to get client root")
		return {}
	end
	local client_stream = client_helpers._GetClientStream()
	if not client_stream then
		client_stream = "/"
	end
	local p4openedcommand = "p4 opened -s | awk '{print $1}' | sed 's|^" .. client_stream .. "|" .. client_root .. "|'"
	if vim.g.selected_changelist then
		p4openedcommand = "p4 opened -s | grep " .. vim.g.selected_changelist .. " | awk '{print $1}' | sed 's|^" .. client_stream .. "|" .. client_root .. "|'"
	end
	local handle = io.popen(p4openedcommand)
	if not handle then
		print("Failed to run p4 opened command")
		return {}
	end
	local result = handle:read("*a")
	handle:close()
	local files = {}
	for file in result:gmatch("[^\r\n]+") do
		table.insert(files, file)
	end
	return files
end

return M
