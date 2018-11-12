
local Card = {}

Card.__index = Card

setmetatable(Card, {
    __call = function(class,...)
        return class:new(...)
    end
})

function Card:new(value, color, number, hidden)
    local newCard = setmetatable({}, Card)
    newCard.value = value
    newCard.color = color
    newCard.number = number
    newCard.hidden = hidden or false
    return newCard
end

return Card