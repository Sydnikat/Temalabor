
local Participant = require "entity.Participant"
local Deck = require "entity.Deck"

local Bank = {}

setmetatable({}, {
    __index = Participant,
    __call = function(class,...)
        local newBank = class:new(...)

        newBank.deck = Deck({}, 0)

        return newBank
    end
})

function Bank:play()

    for _, card in ipairs(self.deck.cards) do
        card.hidden = false
    end

    while(self.behavior:hit(self.deck.cards)) do

        table.insert(self.deck.cards, self.dealer:giveCard())

        self.observer:noticeUpdate()
    end

    if(self.behavior:hit(self.deck.cards) == false and #self.deck.cards == 2)
    then
        self.observer.noticeUpdate()
    end
end

function Bank:preparation()
    self.deck.cards = {}
end

function Bank:receiveFirstCards()
    table.insert(self.deck.cards, self.dealer:giveCard())
    local card = self.dealer:giveCard()
    card.hidden = true
    table.insert(self.deck.cards, card)
end

function Bank:showDeck()
    return self.deck
end

return Bank

