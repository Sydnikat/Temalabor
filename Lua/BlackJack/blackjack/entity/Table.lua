
local Player = require "entity.Player"
local Bank = require "entity.Bank"
local Dealer = require "entity.Dealer"
local inputHandler = require("input.ConsoleInputHandler"):getInstance()
local ActionType = require "type.ActionType"
local GameState = require "type.GameState"
local ResultType = require "type.ResultType"
local ClassicTableView = require "gfx.ClassicTableView"
local ClassicPlayer = require "behavior.ClassicPlayer"
local ClassicBank = require "behavior.ClassicBank"
local Calculator = require("entity.Calculator"):getInstance()


local Table = {}

setmetatable(Table, {
    __call = function(class,...)
        return class:new(...)
    end
})

function Table:new(numberOfDecks, inputHandler)

    local newTable = setmetatable({}, self)
    self.__index = self

    newTable.inputHandler = inputHandler
    newTable.dealer = Dealer(numberOfDecks, self)
    newTable.player = Player(0, newTable.dealer, ClassicPlayer(), inputHandler, self)
    newTable.bank = Bank(0, newTable.dealer, ClassicBank(), nil, self)
    newTable.state = GameState.NEW
    newTable.isLowDeck = false
    newTable.tableView = ClassicTableView(newTable.player, newTable.bank)
    newTable.wincount = 0
    newTable.loseCount = 0

    return newTable
end

function Table:startGame()
    print("\nWelcome to the table! Do not forget, the house always wins!")

    while(self.state ~= GameState.QUIT) do
        if(self.state == GameState.RUNNING) then self:play()
        elseif(self.state == GameState.NEW) then self:settings()
        elseif(self.state == GameState.PAUSED) then self:saveState()
        elseif(self.state == GameState.END) then self:showStatistics()
        elseif(self.state == GameState.QUIT) then
        end
    end

    print("Thank you for choosing our BlackJack app! \nBye-Bye! Have a nice day!")
end

function Table:settings()
    print("Please enter the amount of money you want to have!")

    local newAmount = self.inputHandler:readNumber()

    while(type(newAmount) ~= type(0)) do
        print("Incorrect value!")
        newAmount = self.inputHandler:readNumber()
    end

    self.player = newAmount

    self.winCount = 0
    self.loseCount = 0

    print("n - Start new game\tq - Quit")
    local valid = false
    while(valid == false) do

        local key = inputHandler.readKey()
        if( key == ActionType.NEW)then
            self.state = GameState.RUNNING
            valid = true
        elseif(key ==  ActionType.END) then
            self.state = GameState.QUIT
            valid = true
        else
            valid = false
        end
    end
end

function Table:showStatistics()                                 --TODO: implementálni

    print("\nResults:\n \tYou won "..self.winCount.." times\n\tYou lost "..self.loseCount.." times\n\tYour profit: "..self.bank:showMoney() * -1)

    print("n - Start new game\tq - Quit")
    local valid = false
    while(valid == false) do

        local key = inputHandler.readKey()
        if( key == ActionType.NEW)then
            self.state = GameState.NEW
            valid = true
        elseif(key ==  ActionType.END) then
            self.state = GameState.QUIT
            valid = true
        else
            valid = false
        end
    end

end

function Table:saveState()

    self.state = GameState.RUNNING                              -- TODO: Kivenni! soon: Fájlkezelés
end

function Table:play()

    if(self.isLowDeck) then
        self.dealer:createNewDeck()
        self.isLowDecl = false
    end

    self.player:preparation()
    self.bank:preparation()

    self.player:raise()

    self.player:receiveFirstCards()
    self.bank:receiveFirstCards()


    self.player:play()

    if( self.state ~= GameState.RUNNING ) then return
    end

    self.bank:play()

    self:calculateResult()

end

function Table:calculateResult()

    local playerOdds
    local bankOdds

    for i = 1, self.player.numberOfUsedDecks, 1 do

        self.player:changeDeck(i)

        local result = Calculator:calculateResult(self.player:showDeck(), self.bank:showDeck())
        local playerMoney = self.player:showDeck().money

        if(result == ResultType.WIN) then
            print("You win!")
            playerOdds = 2
            bankOdds = -1
            self.winCount = self.winCount + 1
        elseif(result == ResultType.WINBYJACK) then
            print("BlackJack! You win!")
            playerOdds = 2.5
            bankOdds = -1.5
            self.winCount = self.winCount + 1
        elseif(result == ResultType.LOSEBYJACK) then
            print("You lost!")
            playerOdds = 0
            bankOdds = 1.5
            self.loseCount = self.loseCount + 1
        elseif(result == ResultType.TIE) then
            print("It's tie!")
            playerOdds = 1
            bankOdds = 1
        elseif(result == ResultType.LOSE) then
            print("You lost!")
            playerOdds = 0
            bankOdds = 1
            self.loseCount = self.loseCount + 1
        else print("error")
        end

        self.player:takeMoney(playerMoney * playerOdds)

        self.bank:takeMoney(playerMoney * bankOdds)

    end

    print("\nCurrent account: "..self.player:showMoney())

    local canPlay = true
    if(self.player:showMoney() <= 0) then canPlay = false end

    print("Continue? i - Yes \tq - No")
    local valid = false
    while(valid == false) do

        local key = inputHandler.readKey()
        if( key == ActionType.NEW)then
            if(canPlay) then
                self.state = GameState.RUNNING
                valid = true
            end
        elseif(key ==  ActionType.END) then
            self.state = GameState.END
            valid = true
        else
            valid = false
        end
    end


end

-- Interface functions

function Table:noticeUpdate()
    self.tableView:update()
end

function Table:noticeNewGame()
    self.state = GameState.NEW
end

function Table:noticeEndGame()
    self.state = GameState.END
end

function Table:noticeLowDeck()
    self.isLowDeck = true
end

function Table:noticePause()
    self.state = GameState.PAUSED
end

return Table

