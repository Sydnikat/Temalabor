
local ClassicBehavior = require "behavior.ClassicBehavior"
local Calculator = require("entity.Calculator"):getInstance()

local ClassicPlayer = {}

setmetatable(ClassicPlayer, {
    __index = ClassicBehavior,
    __call = function(class, ...)
        return class:new(...)
    end
})

function ClassicPlayer:getMaximumNumberOfDecks()
    return 3
end

function ClassicPlayer:hit(cards)
    return Calculator.evaluate(cards) <= 21
end

function ClassicPlayer:split(cards, numberOfDecks)

    local result

    if(numberOfDecks == 3) then result = false
    elseif(#cards ~= 2) then result = false
    elseif(cards[1].value ~= cards[2].value) then result = false
    else result = true
    end

    return result
end

return ClassicPlayer