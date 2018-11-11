

local ColorType = require "type.ColorType"
local CardType = require "type.CardType"
local Card = require "entity.Card"

local Dealer = {}

setmetatable(Dealer, {
    __call = function(class,...)
        return class:new(...)
    end
})

function Dealer:new(numberOfUsedDecks, observer)

    local newDealer = setmetatable({}, self)
    self.__index = self
    newDealer.numberOfUsedDecks = numberOfUsedDecks or 1
    newDealer.observer = observer
    newDealer.maxCardNumber = newDealer.numberOfUsedDecks * 52
    newDealer.deckPool = self:createDeck(newDealer)

    return newDealer
end

function Dealer:createDeck(dealer)

    local deck = {}

    local usedDecks = self.numberOfUsedDecks or dealer.numberOfUsedDecks

    for i = 1, usedDecks, 1 do
        for color, _ in pairs(ColorType) do
            for value, _ in pairs(CardType) do
                table.insert(deck, Card(value, color))
            end
        end
    end

    return deck

end

function Dealer:createNewDeck()
    self.deckPool = self:createDeck()
end

function Dealer:giveCard()

    if(#self.deckPool < self.maxCardNumber / 2) then
        self.observer:noticeLowDeck()
    end

    return table.remove(self.deckPool, math.random(1, #self.deckPool))

end

return Dealer