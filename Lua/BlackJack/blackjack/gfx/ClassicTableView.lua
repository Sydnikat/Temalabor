
local PlayerView = require "gfx.ClassicPlayerView"
local BankView = require "gfx.ClassicBankView"

local ClassicTableView = {}

setmetatable({}, {
    __call = function(class, ...)
        class:new(...)
    end
})

function ClassicTableView:new(player, bank)
    local newView = setmetatable({}, self)
    self.__index = self
    newView.player = PlayerView(player)
    newView.bank = BankView(bank)
    return newView
end

function ClassicTableView:update()

    self.bank:update()

    print("\n")

    self.player:update()

end

return ClassicTableView

