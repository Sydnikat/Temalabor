
local ClassicBehavior = require "behavior.ClassicBehavior"
local Calculator = require("entity.Calculator"):getInstance()

local ClassicBank = {}

setmetatable(ClassicBank, {
    __index = ClassicBehavior,
    __call = function(class, ...)
        return class:new(...)
    end
})

function ClassicBank:hit(cards)
    return Calculator.evaluate(cards) <= 16
end

return ClassicBank