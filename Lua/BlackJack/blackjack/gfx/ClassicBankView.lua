
local CardMaker = require("gfx.CardMaker"):getInstance()

local ClassicBankView = {}

setmetatable(ClassicBankView, {
    __call = function(class, ...)
        return class:new(...)
    end
})

function ClassicBankView:new(bank)
    local newView = setmetatable({}, self)
    self.__index = self
    newView.bank = bank
    return newView
end

function ClassicBankView:update()

    for _, card in ipairs(self.bank:showDeck().cards) do
        CardMaker.printCard(card)
    end
    print("\n")

end

return ClassicBankView