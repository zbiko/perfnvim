local client_helpers = require("perfnvim.helpers.client_helpers")
local M = {}

-- Get the opened Perforce file paths
function M._GetP4OpenedPaths()
	local client_root = client_helpers._GetClientRoot()
	if not client_root then
		print("Failed to get client root")
		return nil;
	end
	local client_stream = client_helpers._GetClientStream()
	if not client_stream then
		client_stream = "/"
	end
	local p4openedcommand = "p4 opened -s | awk '{print $1, $5}' | sed 's|^" .. client_stream .. "|" .. client_root .. "|'"
	local handle = io.popen(p4openedcommand .. " 2> /dev/null")
	if not handle then
		print("Failed to run p4 opened command")
		return {}
	end
	local result = handle:read("*a")
	handle:close()
	local files = {}
	for file,changelist in result:gmatch("([^ \r\n]+) ([^ \r\n]+)") do
		table.insert(files, {file,changelist})
	end
	return files
end

return M
