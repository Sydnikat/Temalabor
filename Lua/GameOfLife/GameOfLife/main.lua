
Frame = require "entity.Frame"
FileInputHandler = require("input.FileInputHandler").getInstance()

frame = FileInputHandler.createFrameFromFile("blinker", true)

frame:printResult()
frame:createNextGen()

