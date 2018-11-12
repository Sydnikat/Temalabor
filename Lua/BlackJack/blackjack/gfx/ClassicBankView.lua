
local CardMaker = require("gfx.CardMaker"):getInstance()

local ClassicBankView = {}

setmetatable({}, {
    __call = function(class, ...)
        class:new(...)
    end
})

function ClassicBankView:new(bank)
    local newView = setmetatable({}, self)
    self.__index = self
    newView.bank = bank
    return newView
end

function ClassicBankView:update()

    for _, card in ipairs(self.bank:showDeck()) do
        CardMaker:printCard(card)
    end

end

return ClassicBankView