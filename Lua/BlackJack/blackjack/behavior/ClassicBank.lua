
local ClassicBehavior = require "behavior.ClassicBehavior"
local Calculator = require("entity.Calculator"):getInstance()

local ClassicBank = {}

setmetatable(ClassicBank, {
    __index = ClassicBehavior,
    __call = function(class, ...)
        return class:new(...)
    end
})

function ClassicBank:getMaximumNumberOfDecks()
    return 3
end

function ClassicBank:hit(cards)
    return Calculator.evaluate(cards) <= 16
end

function ClassicBank:double()
    return false
end

function ClassicBank:split()
    return false
end

return ClassicBank