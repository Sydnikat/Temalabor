
local old = io.read
local input = {}
local cnt = 0

io.read = function()
    cnt = cnt+1
    return input[cnt]
end

local FrameMaker = require("FrameMaker").getInstance()
local StateType = require "type.StateType"

function testCreateFrameFromFile()

    input = {"y", "y", "blinker", 2}
    cnt = 0

    local frame = FrameMaker.createFrame()

    lu.assertEquals(frame.height, 5)
    lu.assertEquals(frame.width, 5)

    local c = 0
    for i = 1, frame.height, 1 do
        for j = 1, frame.width, 1 do
            if(frame.cells[i][j].state == StateType.ALIVE) then c = c + 1 end
        end
    end
    lu.assertEquals(c, 3)
end


function testCreateGeneralFrame()

    input = {"n", "g", 20, 15, 2}
    cnt = 0

    local frame = FrameMaker.createFrame()

    lu.assertEquals(frame.height, 20)
    lu.assertEquals(frame.width, 15)
    lu.assertEquals(frame.timeBetweenGens, 400)
    lu.assertEquals(frame.chance, 4)
end



function testCreateIndividual()

    input = {"n", "i", 20, 15, 300, 3, 2}
    cnt = 0

    local frame = FrameMaker.createFrame()

    lu.assertEquals(frame.height, 20)
    lu.assertEquals(frame.width, 15)
    lu.assertEquals(frame.timeBetweenGens, 300)
    lu.assertEquals(frame.chance, 3)
end

io.read = old

