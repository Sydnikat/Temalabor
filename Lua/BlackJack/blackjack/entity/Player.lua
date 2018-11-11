
local Participant = require "entity.Participant"
local Deck = require "entity.Deck"
local ConsoleInputHandler = require("input.ConsoleInputHandler"):getInstance()
local ActionType = require "type.ActionType"

local Player = {}

setmetatable({}, {
    __index = Participant,
    __call = function(class,...)
        local newPlayer = class:new(...)

        newPlayer.currentDeckIndex = 0
        newPlayer.numberOfUsedDecks = 1
        newPlayer.decks = Player:createDecks(newPlayer)

        return newPlayer
    end
})


function Player:createDecks(player)
    local decks = {}
    for i = 1, player.behavior.getMaximumNumberOfDecks(), 1 do
        table.insert(decks, Deck({}, 0))
    end
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

                local key = ConsoleInputHandler.readKey()

                if(key == ActionType.HIT) then self:hit(deck)
                elseif(key == ActionType.STAND) then done = true
                elseif(key == ActionType.DOUBLE) then self:double(deck)
                elseif(key == ActionType.SPLIT) then self:split(deck)
                elseif(key == ActionType.END) then
                    self.observer:noticeEndGame()
                    done = true
                elseif(key == ActionType.NEW) then
                    self.observer:noticeUpdate()
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

        local card = table.remove(deck.cards, 0)

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
    if(index >= 1 and index <= self.observer:getMaximumNumberOfDecks()) then
        self.currentDeckIndex = index
    end
end

function Player:double(deck)
    if(self.behavior:double(deck.cards)) then

        local currentMoney = deck.money

        if(self.amountOfMoney >= currentMoney) then

            self.amountOfMoney = self.amountMOney - currentMoney
            deck.money = 2 * deck.money

        elseif(self.amountOfMoney > 0.0) then

            deck.money = deck.money + self.amountOfMoney
            self.amountOfMoney = 0.0
        end

        observer.noticeUpdate()
    end
end

function Player:raise()
    local valid = false

    println("\nPlease raise!")

    while (valid == false) do

        local newAmount = ConsoleInputHandler.readNumber()

        if(newAmount == tonumber(0)) then

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
    table.insert(self.decks[1], self.dealer:giveCard())
    table.insert(self.decks[1], self.dealer:giveCard())
end

function Player:showDeck()
    return self.decks[self.currentDeckIndex]
end


return Player
