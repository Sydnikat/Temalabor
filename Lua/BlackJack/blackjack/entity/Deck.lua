
local Deck = {}

setmetatable(Deck, {
    __call = function(class,...)
        return class:new(...)
    end
})

function Deck:new(cards, money)
    local newDeck = setmetatable({}, self)
    self.__index = self
    newDeck.cards = cards
    newDeck.money = money
    return newDeck
end

return Deck