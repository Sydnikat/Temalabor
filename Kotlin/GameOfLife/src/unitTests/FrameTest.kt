package unitTests

import gameOfLife.FrameMaker
import gameOfLife.entity.Frame
import gameOfLife.type.StateType
import org.junit.Test

import org.junit.Assert.*
import java.io.ByteArrayInputStream

class FrameTest {

    @Test
    fun checkNextGenForBeaconTest() {

        System.setIn(ByteArrayInputStream("i\ni\nbeacon".toByteArray()))

        val frame = FrameMaker.createFrame()

        assertEquals(8, frame.livingCount())

        assertEquals(StateType.ALIVE, frame.cells[2][2].state)
        assertEquals(StateType.ALIVE, frame.cells[3][3].state)

        frame.createNextGen()

        assertEquals(6, frame.livingCount())

        assertEquals(StateType.DEAD, frame.cells[2][2].state)
        assertEquals(StateType.DEAD, frame.cells[3][3].state)

        frame.createNextGen()

        assertEquals(8, frame.livingCount())

        assertEquals(StateType.ALIVE, frame.cells[2][2].state)
        assertEquals(StateType.ALIVE, frame.cells[3][3].state)
    }

    @Test
    fun checkNextGenForBlinkerTest() {

        System.setIn(ByteArrayInputStream("i\ni\nblinker".toByteArray()))

        val frame = FrameMaker.createFrame()

        assertEquals(3, frame.livingCount())

        assertEquals(StateType.ALIVE, frame.cells[2][1].state)
        assertEquals(StateType.ALIVE, frame.cells[2][3].state)
        assertEquals(StateType.DEAD, frame.cells[1][2].state)
        assertEquals(StateType.DEAD, frame.cells[3][2].state)

        frame.createNextGen()

        assertEquals(3, frame.livingCount())

        assertEquals(StateType.DEAD, frame.cells[2][1].state)
        assertEquals(StateType.DEAD, frame.cells[2][3].state)
        assertEquals(StateType.ALIVE, frame.cells[1][2].state)
        assertEquals(StateType.ALIVE, frame.cells[3][2].state)

        frame.createNextGen()

        assertEquals(3, frame.livingCount())

        assertEquals(StateType.ALIVE, frame.cells[2][1].state)
        assertEquals(StateType.ALIVE, frame.cells[2][3].state)
        assertEquals(StateType.DEAD, frame.cells[1][2].state)
        assertEquals(StateType.DEAD, frame.cells[3][2].state)
    }

    @Test
    fun checkNextGenForFullHouseTest() {

        System.setIn(ByteArrayInputStream("i\ni\nfullhouse".toByteArray()))

        val frame = FrameMaker.createFrame()

        assertEquals(36, frame.livingCount())

        frame.createNextGen()

        assertEquals(0, frame.livingCount())

    }

    @Test
    fun checkNextGenForToadTest() {
        System.setIn(ByteArrayInputStream("i\ni\ntoad".toByteArray()))

        val frame = FrameMaker.createFrame()

        assertEquals(6, frame.livingCount())

        assertEquals(StateType.DEAD,  frame.cells[1][3].state)

        assertEquals(StateType.DEAD,  frame.cells[2][1].state)
        assertEquals(StateType.ALIVE, frame.cells[2][2].state)
        assertEquals(StateType.ALIVE, frame.cells[2][3].state)
        assertEquals(StateType.ALIVE, frame.cells[2][4].state)

        assertEquals(StateType.ALIVE, frame.cells[3][1].state)
        assertEquals(StateType.ALIVE, frame.cells[3][2].state)
        assertEquals(StateType.ALIVE, frame.cells[3][3].state)
        assertEquals(StateType.DEAD,  frame.cells[3][4].state)

        assertEquals(StateType.DEAD,  frame.cells[4][2].state)


        frame.createNextGen()

        assertEquals(6, frame.livingCount())

        assertEquals(StateType.ALIVE, frame.cells[1][3].state)

        assertEquals(StateType.ALIVE, frame.cells[2][1].state)
        assertEquals(StateType.DEAD,  frame.cells[2][2].state)
        assertEquals(StateType.DEAD,  frame.cells[2][3].state)
        assertEquals(StateType.ALIVE, frame.cells[2][4].state)

        assertEquals(StateType.ALIVE, frame.cells[3][1].state)
        assertEquals(StateType.DEAD,  frame.cells[3][2].state)
        assertEquals(StateType.DEAD,  frame.cells[3][3].state)
        assertEquals(StateType.ALIVE, frame.cells[3][4].state)

        assertEquals(StateType.ALIVE, frame.cells[4][2].state)
    }
}