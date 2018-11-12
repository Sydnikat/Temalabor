
local CardMaker = require("gfx.CardMaker"):getInstance()

local ClassicPlayerView = {}

setmetatable({}, {
    __call = function(class, ...)
        class:new(...)
    end
})

function ClassicPlayerView:new(player)
    local newView = setmetatable({}, self)
    self.__index = self
    newView.player = player
    return newView
end

function ClassicPlayerView:update()
    for i = 1, self.numberOfUsedDecks, 1 do

        self.player:changeDeck(1)

        local deck = self.player:showDeck()

        io.write( i..": "..deck.money.." ")

        for _, card in ipairs(deck) do
            CardMaker:printCard(card)
        end

        io.write("\t")

    end

    io.write(self.player.showMoney().."\n")

end

return ClassicPlayerView

