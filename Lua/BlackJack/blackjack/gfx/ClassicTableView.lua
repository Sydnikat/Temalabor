
local PlayerView = require "gfx.ClassicPlayerView"
local BankView = require "gfx.ClassicBankView"

local ClassicTableView = {}

setmetatable(ClassicTableView, {
    __call = function(class, ...)
        return class:new(...)
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
    self.player:update()

end

return ClassicTableView

