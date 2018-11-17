
local Card = {}

setmetatable(Card, {
    __call = function(class,...)
        return class:new(...)
    end
})

function Card:new(value, color, number, hidden)
    local newCard = setmetatable({}, self)
    self.__index = self
    newCard.value = value
    newCard.color = color
    newCard.number = number
    newCard.hidden = hidden or false
    return newCard
end

return Card