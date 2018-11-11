
local Deck = {}

Deck.__index = Deck

setmetatable(Deck, {
    __call = function(class,...)
        return class:new(...)
    end
})

function Deck:new(cards, money)
    local newDeck = setmetatable({}, Deck)
    newDeck.value = cards
    newDeck.color = money
    return newDeck
end

return Deck