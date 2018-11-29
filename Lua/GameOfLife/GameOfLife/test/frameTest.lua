
local old = io.read
local input = {}
local cnt = 0

io.read = function()
    cnt = cnt+1
    return input[cnt]
end

local FrameMaker = require("FrameMaker").getInstance()
local StateType = require "type.StateType"

function testCheckNextGenForBeacon()

    input = {"y", "y", "beacon", 0}
    cnt = 0

    local frame = FrameMaker.createFrame()

    lu.assertEquals(frame:getLivingCount(), 8)

    lu.assertEquals(frame.cells[3][3].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[4][4].state, StateType.ALIVE)

    frame:createNextGen()

    lu.assertEquals(frame:getLivingCount(), 6)

    lu.assertEquals(frame.cells[3][3].state, StateType.DEAD)
    lu.assertEquals(frame.cells[4][4].state, StateType.DEAD)

    frame:createNextGen()

    lu.assertEquals(frame:getLivingCount(), 8)

    lu.assertEquals(frame.cells[3][3].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[4][4].state, StateType.ALIVE)
end


function testCheckNextGenForBlinker()

    input = {"y", "y", "blinker", 0}
    cnt = 0

    local frame = FrameMaker.createFrame()

    lu.assertEquals(frame:getLivingCount(), 3)

    lu.assertEquals(frame.cells[3][2].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[3][3].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[3][4].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[2][3].state, StateType.DEAD)
    lu.assertEquals(frame.cells[4][3].state, StateType.DEAD)

    frame:createNextGen()

    lu.assertEquals(frame:getLivingCount(), 3)

    lu.assertEquals(frame.cells[3][2].state, StateType.DEAD)
    lu.assertEquals(frame.cells[3][3].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[3][4].state, StateType.DEAD)
    lu.assertEquals(frame.cells[2][3].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[4][3].state, StateType.ALIVE)

    frame:createNextGen()

    lu.assertEquals(frame:getLivingCount(), 3)

    lu.assertEquals(frame.cells[3][2].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[3][3].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[3][4].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[2][3].state, StateType.DEAD)
    lu.assertEquals(frame.cells[4][3].state, StateType.DEAD)
end


function testCheckNextGenForFullHouse()

    input = {"y", "y", "fullhouse", 0}
    cnt = 0

    local frame = FrameMaker.createFrame()

    lu.assertEquals(frame:getLivingCount(), 36)

    frame:createNextGen()

    lu.assertEquals(frame:getLivingCount(), 0)

end


function testCheckNextGenForToad()
    input = {"y", "y", "toad", 0}
    cnt = 0

    local frame = FrameMaker.createFrame()

    lu.assertEquals(frame:getLivingCount(), 6)

    lu.assertEquals(frame.cells[2][4].state, StateType.DEAD)

    lu.assertEquals(frame.cells[3][2].state, StateType.DEAD)
    lu.assertEquals(frame.cells[3][3].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[3][4].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[3][5].state, StateType.ALIVE)

    lu.assertEquals(frame.cells[4][2].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[4][3].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[4][4].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[4][5].state, StateType.DEAD)

    lu.assertEquals(frame.cells[5][3].state, StateType.DEAD)


    frame:createNextGen()

    lu.assertEquals(frame:getLivingCount(), 6)

    lu.assertEquals(frame.cells[2][4].state, StateType.ALIVE)

    lu.assertEquals(frame.cells[3][2].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[3][3].state, StateType.DEAD)
    lu.assertEquals(frame.cells[3][4].state, StateType.DEAD)
    lu.assertEquals(frame.cells[3][5].state, StateType.ALIVE)

    lu.assertEquals(frame.cells[4][2].state, StateType.ALIVE)
    lu.assertEquals(frame.cells[4][3].state, StateType.DEAD)
    lu.assertEquals(frame.cells[4][4].state, StateType.DEAD)
    lu.assertEquals(frame.cells[4][5].state, StateType.ALIVE)

    lu.assertEquals(frame.cells[5][3].state, StateType.ALIVE)
end

io.read = old
