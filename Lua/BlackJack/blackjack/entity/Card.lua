
local Card = {}

Card.__index = Card

setmetatable(Card, {
    __call = function(class,...)
        return class:new(...)
    end
})

function Card:new(value, color, hidden)
    local newCard = setmetatable({}, Card)
    newCard.value = value
    newCard.color = color
    newCard.hidden = hidden or false
    return newCard
end

return Card