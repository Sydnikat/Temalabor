
local StateType = require "type.StateType"
local ChangeType = require "type.ChangeType"

local Cell = {
    state = 0,
    changeState = 0,
    neighbors = {}
}
Cell.__index = Cell

setmetatable(Cell, {
    __call = function(class, ...)
        return class.CreateCell(...)
    end
})

function Cell.CreateCell(state)
    local self = setmetatable({}, Cell)
    self.state = state
    return self
end

function Cell:checkState()
    local livingNeighbors = 0

    for _, cell in ipairs(self.neighbors)
    do
        if(cell.state == StateType.ALIVE)
        then
            livingNeighbors = livingNeighbors + 1
        end
    end

    if(livingNeighbors > 3 or livingNeighbors < 2) then
        if(self.state == StateType.ALIVE)
        then
            self.changeState = ChangeType.DIE
        else
            self.changeState = ChangeType.NOTHING
        end
    else
        if(self.state == StateType.DEAD and livingNeighbors == 3)
        then
            self.changeState = ChangeType.BIRTH
        else
            self.changeState = ChangeType.NOTHING
        end
    end

end

function Cell:die()
    if(self.changeState == ChangeType.DIE)
    then
        self.state = StateType.DEAD
    end
end

function Cell:birth()
    if(self.changeState == ChangeType.BIRTH)
    then
        self.state = StateType.ALIVE
    end
end

return Cell