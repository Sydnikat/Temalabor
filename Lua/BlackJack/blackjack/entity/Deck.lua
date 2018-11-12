
local Deck = {}

Deck.__index = Deck

setmetatable(Deck, {
    __call = function(class,...)
        return class:new(...)
    end
})

function Deck:new(cards, money)
    local newDeck = setmetatable({}, Deck)
    newDeck.cards = cards
    newDeck.money = money
    return newDeck
end

return Deck