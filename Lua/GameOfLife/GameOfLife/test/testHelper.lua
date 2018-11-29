
local M = {}

M.old = io.read
M.input = {}
M.cnt = 0

M.read = function()
    M.cnt = M.cnt+1
    return M.input[M.cnt]
end

return M


