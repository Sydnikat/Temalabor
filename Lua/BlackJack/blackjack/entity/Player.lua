
local Participant = require "entity.Participant"
local Deck = require "entity.Deck"
local ActionType = require "type.ActionType"

local Player = {}

setmetatable(Player, {
    __call = function(class,...)
        local newPlayer = class:new(...)
        newPlayer.currentDeckIndex = 1
        newPlayer.numberOfUsedDecks = 1
        newPlayer.decks = class:createDecks(newPlayer)

        return newPlayer
    end,
    __index = Participant
})

function Player:createDecks(player)
    local decks = {}
    for i = 1, player.behavior.getMaximumNumberOfDecks(), 1 do
        table.insert(decks, Deck({}, 0))
    end
    return decks
end

function Player:preparation()

    for i = 1, #self.decks, 1 do
        self.decks[i].cards = {}
        self.decks[i].money = 0
    end
    self.currentDeckIndex = 1
    self.numberOfUsedDecks = 1
end

function Player:play()

    for _, deck in ipairs(self.decks) do

        if(#deck.cards ~= 0) then

            self.observer:noticeUpdate()

            local done = false

            while(done == false) do

                local key = self.inputHandler:readKey()

                if(key == ActionType.HIT) then self:hit(deck)
                elseif(key == ActionType.STAND) then done = true
                elseif(key == ActionType.DOUBLE) then self:double(deck)
                elseif(key == ActionType.SPLIT) then self:split(deck)
                elseif(key == ActionType.END) then
                    self.observer:noticeEndGame()
                    done = true
                elseif(key == ActionType.NEW) then
                    self.observer:noticeNewGame()
                    done = true
                else
                end
            end
        end
    end
end

function Player:hit(deck)
    if(self.behavior:hit(deck.cards)) then
        table.insert(deck.cards, self.dealer:giveCard())
        self.observer:noticeUpdate()
    end

end

function Player:split(deck)
    if(self.behavior:split(deck.cards, self.numberOfUsedDecks)) then

        self.numberOfUsedDecks = self.numberOfUsedDecks + 1

        local card = table.remove(deck.cards, 1)

        local idx = 0
        for i, d in ipairs(self.decks) do
            if(#d.cards == 0) then
                idx = i
                break
            end
        end

        table.insert(self.decks[idx].cards, card)
        self.decks[idx].money = deck.money / 2
        deck.money = deck.money / 2

        self.observer:noticeUpdate()
    end
end

function Player:changeDeck(index)
    if(index >= 1 and index <= self.behavior:getMaximumNumberOfDecks()) then
        self.currentDeckIndex = index
    end
end

function Player:double(deck)
    if(self.behavior:double(deck.cards)) then

        local currentMoney = deck.money

        if(self.amountOfMoney >= currentMoney) then

            self.amountOfMoney = self.amountOfMoney - currentMoney
            deck.money = 2 * deck.money

        elseif(self.amountOfMoney > 0.0) then

            deck.money = deck.money + self.amountOfMoney
            self.amountOfMoney = 0.0
        end

        self.observer:noticeUpdate()
    end
end

function Player:raise()
    local valid = false

    print("\nPlease raise!")

    while (valid == false) do

        local newAmount = self.inputHandler:readNumber()

        if(type(newAmount) == "number") then

            if(newAmount <= self.amountOfMoney) then

                self.decks[1].money = newAmount
                self.amountOfMoney = self.amountOfMoney - newAmount
                valid = true
            end
        end


    end
    print("\n\n")
end

function Player:receiveFirstCards()
    table.insert(self.decks[1].cards, self.dealer:giveCard())
    table.insert(self.decks[1].cards, self.dealer:giveCard())
end

function Player:showDeck()
    return self.decks[self.currentDeckIndex]
end


return Player
