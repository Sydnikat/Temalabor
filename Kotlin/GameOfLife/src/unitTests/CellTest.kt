package unitTests

import gameOfLife.entity.Cell
import gameOfLife.type.ChangeType
import gameOfLife.type.StateType
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class CellTest {

    private val cell = Cell(StateType.ALIVE)

    @Before
    fun setUp(){
        cell.neighbors.clear()
        cell.state = StateType.ALIVE
    }

    @Test
    fun checkStateWithMoreThanThreeNeighborsAlive() {
        cell.neighbors.addAll(arrayListOf(Cell(StateType.ALIVE), Cell(StateType.ALIVE), Cell(StateType.ALIVE), Cell(StateType.ALIVE)))

        cell.checkState()

        assertEquals(ChangeType.DIE, cell.change)

        cell.state = StateType.DEAD

        cell.checkState()

        assertEquals(ChangeType.NOTHING, cell.change)
    }

    @Test
    fun checkStateWithThreeNeighborsAlive() {
        cell.neighbors.addAll(arrayListOf(Cell(StateType.ALIVE), Cell(StateType.ALIVE), Cell(StateType.ALIVE)))

        cell.checkState()

        assertEquals(ChangeType.NOTHING, cell.change)

        cell.state = StateType.DEAD

        cell.checkState()

        assertEquals(ChangeType.BIRTH, cell.change)
    }

    @Test
    fun checkStateWithTwoNeighborsAlive() {
        cell.neighbors.addAll(arrayListOf(Cell(StateType.ALIVE), Cell(StateType.ALIVE)))

        cell.checkState()

        assertEquals(ChangeType.NOTHING, cell.change)

        cell.state = StateType.DEAD

        cell.checkState()

        assertEquals(ChangeType.NOTHING, cell.change)
    }


    @Test
    fun checkStateWithLessThanTwoNeighborsAlive() {
        cell.neighbors.addAll(arrayListOf(Cell(StateType.ALIVE)))

        cell.checkState()

        assertEquals(ChangeType.DIE, cell.change)

        cell.state = StateType.DEAD

        cell.checkState()

        assertEquals(ChangeType.NOTHING, cell.change)
    }

    @Test
    fun birthTestWithTwoNeighborsAlive() {
        cell.neighbors.addAll(arrayListOf(Cell(StateType.ALIVE), Cell(StateType.ALIVE), Cell(StateType.DEAD)))
        cell.state = StateType.DEAD

        cell.checkState()
        cell.birth()

        assertEquals(StateType.DEAD, cell.state)
    }

    @Test
    fun birthTestWithThreeNeighborsAlive() {
        cell.neighbors.addAll(arrayListOf(Cell(StateType.ALIVE), Cell(StateType.ALIVE), Cell(StateType.ALIVE)))
        cell.state = StateType.DEAD

        cell.checkState()
        cell.birth()

        assertEquals(StateType.ALIVE, cell.state)
    }

    @Test
    fun birthTestWithMoreThanThreeNeighborsAlive() {
        cell.neighbors.addAll(arrayListOf(Cell(StateType.ALIVE), Cell(StateType.ALIVE), Cell(StateType.ALIVE), Cell(StateType.ALIVE)))
        cell.state = StateType.DEAD

        cell.checkState()
        cell.birth()

        assertEquals(StateType.DEAD, cell.state)
    }

    @Test
    fun dieTestWithLessThanTwoNeighborsAlive() {
        cell.neighbors.addAll(arrayListOf(Cell(StateType.ALIVE), Cell(StateType.DEAD), Cell(StateType.DEAD)))
        cell.state = StateType.ALIVE

        cell.checkState()
        cell.die()

        assertEquals(StateType.DEAD, cell.state)
    }

    @Test
    fun dieTestWithTwoOrThreeNeighborsAlive() {
        cell.neighbors.addAll(arrayListOf(Cell(StateType.ALIVE), Cell(StateType.ALIVE), Cell(StateType.DEAD)))
        cell.state = StateType.ALIVE

        cell.checkState()
        cell.die()

        assertEquals(StateType.ALIVE, cell.state)

        cell.neighbors[2].state = StateType.ALIVE

        cell.checkState()
        cell.die()

        assertEquals(StateType.ALIVE, cell.state)
    }

    @Test
    fun dieTestWithMoreThanThreeNeighborsAlive() {
        cell.neighbors.addAll(arrayListOf(Cell(StateType.ALIVE), Cell(StateType.ALIVE), Cell(StateType.ALIVE), Cell(StateType.ALIVE)))
        cell.state = StateType.ALIVE

        cell.checkState()
        cell.die()

        assertEquals(StateType.DEAD, cell.state)
    }
}