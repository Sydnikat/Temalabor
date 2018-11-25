

local Cell = require "entity.Cell"
local StateType = require "type.StateType"
local ChangeType = require "type.ChangeType"

lu = require "luaunit"

FrameMaker = require("FrameMaker").getInstance()

FrameMaker.createFrame():simulate()



function testStateWithTwoNeighborsAlive()

    local cell = Cell(StateType.ALIVE)

    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.ALIVE))

    cell:checkState()

    lu.assertEquals(cell.changeState, ChangeType.NOTHING)

    cell.state = StateType.DEAD

    cell:checkState()

    lu.assertEquals(cell.changeState, ChangeType.NOTHING)
end



os.exit( lu.LuaUnit.run() )

