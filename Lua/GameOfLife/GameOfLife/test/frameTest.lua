
h = require "test.testHelper"
io.read = h.read

local FrameMaker = require("FrameMaker").getInstance()
local StateType = require "type.StateType"

function testCheckNextGenForBeacon()

    h.input = {"y", "y", "beacon", 0}
    h.cnt = 0

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

    h.input = {"y", "y", "blinker", 0}
    h.cnt = 0

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

    h.input = {"y", "y", "fullhouse", 0}
    h.cnt = 0

    local frame = FrameMaker.createFrame()

    lu.assertEquals(frame:getLivingCount(), 36)

    frame:createNextGen()

    lu.assertEquals(frame:getLivingCount(), 0)

end


function testCheckNextGenForToad()
    h.input = {"y", "y", "toad", 0}
    h.cnt = 0

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
