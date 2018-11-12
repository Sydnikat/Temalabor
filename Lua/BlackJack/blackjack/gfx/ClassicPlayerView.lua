
local CardMaker = require("gfx.CardMaker"):getInstance()

local ClassicPlayerView = {}

setmetatable(ClassicPlayerView, {
    __call = function(class, ...)
        return class:new(...)
    end
})

function ClassicPlayerView:new(player)
    local newView = setmetatable({}, self)
    self.__index = self
    newView.player = player
    return newView
end

function ClassicPlayerView:update()

    for i = 1, self.player.numberOfUsedDecks, 1 do

        self.player:changeDeck(i)

        local deck = self.player:showDeck()

        io.flush()
        io.write( i..": "..deck.money.." ")


        for _, card in ipairs(deck.cards) do
            CardMaker.printCard(card)
        end

        io.write("\t")
    end

    io.write(self.player:showMoney())
    print()

end

return ClassicPlayerView

