
local Cell = require "entity.Cell"
local StateType = require "type.StateType"
local ChangeType = require "type.ChangeType"

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

function testStateWithThreeNeighborsAlive()
    local cell = Cell(StateType.ALIVE)

    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.ALIVE))

    cell:checkState()

    lu.assertEquals(cell.changeState, ChangeType.NOTHING)

    cell.state = StateType.DEAD

    cell:checkState()

    lu.assertEquals(cell.changeState, ChangeType.BIRTH)
end

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

function testStateWithLessThanTwoNeighborsAlive()
    local cell = Cell(StateType.ALIVE)

    table.insert(cell.neighbors, Cell(StateType.ALIVE))

    cell:checkState()

    lu.assertEquals(cell.changeState, ChangeType.DIE)

    cell.state = StateType.DEAD

    cell:checkState()

    lu.assertEquals(cell.changeState, ChangeType.NOTHING)
end

function testBirthWithTwoNeighborsAlive()
    local cell = Cell(StateType.ALIVE)

    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.DEAD))

    cell.state = StateType.DEAD

    cell:checkState()
    cell:birth()

    lu.assertEquals(cell.state, StateType.DEAD)
end

function testBirthWithThreeNeighborsAlive()

    local cell = Cell(StateType.ALIVE)

    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.ALIVE))

    cell.state = StateType.DEAD

    cell:checkState()
    cell:birth()

    lu.assertEquals(cell.state, StateType.ALIVE)
end

function testBirthWithMoreThanThreeNeighborsAlive()
    local cell = Cell(StateType.ALIVE)

    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.ALIVE))

    cell.state = StateType.DEAD

    cell:checkState()
    cell:birth()

    lu.assertEquals(cell.state, StateType.DEAD)
end

function testDieWithLessThanTwoNeighborsAlive()
    local cell = Cell(StateType.ALIVE)

    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.DEAD))
    table.insert(cell.neighbors, Cell(StateType.DEAD))

    cell.state = StateType.ALIVE

    cell:checkState()
    cell:die()

    lu.assertEquals(cell.state, StateType.DEAD)
end

function testDieWithTwoOrThreeNeighborsAlive()
    local cell = Cell(StateType.ALIVE)

    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.DEAD))

    cell.state = StateType.ALIVE

    cell:checkState()
    cell:die()

    lu.assertEquals(cell.state, StateType.ALIVE)

    cell.neighbors[2].state = StateType.ALIVE

    cell:checkState()
    cell:die()

    lu.assertEquals(cell.state, StateType.ALIVE)
end

function testDieWithMoreThanThreeNeighborsAlive()
    local cell = Cell(StateType.ALIVE)

    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.ALIVE))
    table.insert(cell.neighbors, Cell(StateType.ALIVE))

    cell.state = StateType.ALIVE

    cell:checkState()
    cell:die()

    lu.assertEquals(cell.state, StateType.DEAD)
end