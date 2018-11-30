
h = require "test.testHelper"
io.read = h.read

local ActionType = require "type.ActionType"
local ConsoleInputHandler = require("input.ConsoleInputHandler"):getInstance()


function testReadNumber()

    h.input = {"5", "2.0", "2.2.2", " ", "5a6"}
    h.cnt = 0

    lu.assertEquals(ConsoleInputHandler.readNumber(), 5) -- A number típus igazából nem tesz különbséget 5 és 5.0 között
    
    lu.assertEquals(ConsoleInputHandler.readNumber(), 2.0)
    
    lu.assertEquals(ConsoleInputHandler.readNumber(), nil)
    
    lu.assertEquals(ConsoleInputHandler.readNumber(), nil)
    
    lu.assertEquals(ConsoleInputHandler.readNumber(), nil)

end


function testReadKey()

    h.input = {"s", "d", "q", "h", "e", "n", "i", " ", "rossz input"}
    h.cnt = 0

    lu.assertEquals(ConsoleInputHandler.readKey(), ActionType.SPLIT)
    lu.assertEquals(ConsoleInputHandler.readKey(), ActionType.DOUBLE)
    lu.assertEquals(ConsoleInputHandler.readKey(), ActionType.END)
    lu.assertEquals(ConsoleInputHandler.readKey(), ActionType.HIT)
    lu.assertEquals(ConsoleInputHandler.readKey(), ActionType.STAND)
    lu.assertEquals(ConsoleInputHandler.readKey(), ActionType.NEW)
    lu.assertEquals(ConsoleInputHandler.readKey(), ActionType.NEW)
    lu.assertEquals(ConsoleInputHandler.readKey(), ActionType.ERROR)
    lu.assertEquals(ConsoleInputHandler.readKey(), ActionType.ERROR)

end

