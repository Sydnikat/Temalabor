
local ActionType = require "type.ActionType"
local read = io.read

local ConsoleInputHandler = {}

function ConsoleInputHandler:getInstance()

    local readNumber = function()
        return tonumber(read())
    end

    local readKey = function()
        local line = string.upper(read())
        local result

        if(line == "S") then result = ActionType.SPLIT
        elseif(line == "D") then result = ActionType.DOUBLE
        elseif(line == "Q") then result = ActionType.END
        elseif(line == "H") then result = ActionType.HIT
        elseif(line == "E") then result = ActionType.STAND
        elseif(line == "N" or line == "I") then result = ActionType.NEW
        else result = ActionType.ERROR
        end

        return result

    end

    return {
        readNumber = readNumber,
        readKey = readKey
    }
end

return ConsoleInputHandler