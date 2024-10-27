local M = {}

function M._ReverseArray(arr)
	local n = #arr
	for i = 1, math.floor(n / 2) do
		arr[i], arr[n - i + 1] = arr[n - i + 1], arr[i]
	end
end

return M
