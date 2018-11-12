
local InputHandler = require("input.ConsoleInputHandler"):getInstance()
local Table = require "entity.Table"
local Player = require "entity.Player"
local Dealer = require "entity.Dealer"


Table(6, InputHandler):startGame()

