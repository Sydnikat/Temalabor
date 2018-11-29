

h = require "test.testHelper"
io.read = h.read

local FrameMaker = require("FrameMaker").getInstance()

function testCreateFrameFromFile()

    h.input = {"y", "y", "blinker", 2}
    h.cnt = 0

    local frame = FrameMaker.createFrame()

    lu.assertEquals(frame.height, 5)
    lu.assertEquals(frame.width, 5)
    lu.assertEquals(frame:getLivingCount(), 3)
end


function testCreateGeneralFrame()

    h.input = {"n", "g", 20, 15, 2}
    h.cnt = 0

    local frame = FrameMaker.createFrame()

    lu.assertEquals(frame.height, 20)
    lu.assertEquals(frame.width, 15)
    lu.assertEquals(frame.timeBetweenGens, 400)
    lu.assertEquals(frame.chance, 4)
end



function testCreateIndividual()

    h.input = {"n", "i", 20, 15, 300, 3, 2}
    h.cnt = 0

    local frame = FrameMaker.createFrame()

    lu.assertEquals(frame.height, 20)
    lu.assertEquals(frame.width, 15)
    lu.assertEquals(frame.timeBetweenGens, 300)
    lu.assertEquals(frame.chance, 3)
end

--io.read = old

