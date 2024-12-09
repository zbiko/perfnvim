local M = {}

function M._GetP4Info()
	-- Execute the 'p4 info' command and capture the output
	local handle = io.popen("p4 info" .. " 2> /dev/null")
	if not handle then
		print("Failed to run p4 info command")
		return
	end
	local result = handle:read("*a")
	handle:close()
	return result
end

function M._GetClientRoot()
	local result = M._GetP4Info()
	if result then
		local client_root = result:match("Client root:%s*(.-)\n")
		return client_root
	else
		print("Cannot obtain client root from p4 info")
		return
	end
end

function M._GetClientName()
	local result = M._GetP4Info()
	if result then
		local client_name = result:match("Client name:%s*(.-)\n")
		return client_name
	else
		print("Cannot obtain client name from p4 info")
		return
	end
end

function M._GetClientStream()
	local result = M._GetP4Info()
	if result then
		local client_stream = result:match("Client stream:%s*(.-)\n")
		return client_stream
	else
		print("Cannot obtain client stream from p4 info")
		return
	end
end

return M
