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
	--local p4openedcommand = "p4 opened -s | awk '{print $1, $5}' sed 's|^" .. client_stream .. "|" .. client_root .. "|'"
	local p4openedcommand = "p4 opened -s"
	local handle = io.popen(p4openedcommand .. " 2> /dev/null")
	if not handle then
		print("Failed to run p4 opened command")
		return {}
	end
	local result = handle:read("*a")
	handle:close()
	local files = {}
    local changelists = {}
    local types = {}
    for line in result:gmatch("[^\r\n]+") do
        local file,type,changelist = line:match("(.*) %- (.*) change ([0-9]+)")
        if file then
            table.insert(files, "\"" .. file .. "\"")
            table.insert(types, type)
            table.insert(changelists, changelist)
        else
            -- try default changelist
            file,type = line:match("(.*) %- (.*) default change")
            if file then
                table.insert(files, file)
                table.insert(types, type)
                table.insert(changelists, "default ")
            end
        end
    end

    -- use p4 where to translate remote path to local
    local p4wherecommand = "p4 where " .. table.concat(files, " ")
	handle = io.popen(p4wherecommand .. " 2> /dev/null")
	if not handle then
		print("Failed to run p4 where command")
		return {}
	end
	result = handle:read("*a")
	handle:close()

    files = {}
    for line in result:gmatch("[^\r\n]+") do
        for local_path in line:gmatch(" (/[^/].*)$") do
            table.insert(files, local_path)
        end
	end

    local openedPaths = {}
    for i = 1, #files do
        table.insert(openedPaths, {files[i], types[i], changelists[i]})
    end

	return openedPaths
end

return M
