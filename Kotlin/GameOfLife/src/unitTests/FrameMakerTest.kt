package unitTests

import gameOfLife.FrameMaker
import gameOfLife.type.StateType
import org.junit.Test

import org.junit.Assert.*
import java.io.ByteArrayInputStream

class FrameMakerTest {

    @Test
    fun createFrameFromFileTest() {
        System.setIn(ByteArrayInputStream("i\ni\nblinker".toByteArray()))

        val frame = FrameMaker.createFrame()

        assertEquals(5, frame.height)
        assertEquals(5, frame.width)
        var c = 0
        frame.cells.forEach {
            it.forEach { i ->
                if(i.state == StateType.ALIVE)
                    c++
            }
        }
        assertEquals(3, c)
    }

    @Test
    fun createGeneralFrameTest() {
        System.setIn(ByteArrayInputStream("n\na\n20\n15".toByteArray()))

        val frame = FrameMaker.createFrame()

        assertEquals(20, frame.height)
        assertEquals(15, frame.width)
        assertEquals(250.toLong(), frame.timeBetweenGens)
        assertTrue(frame.fillWithRandom)
        assertEquals(4, frame.chance)
    }


    @Test
    fun createIndividualTest() {
        System.setIn(ByteArrayInputStream("n\ne\n20\n15\n400\n3".toByteArray()))

        val frame = FrameMaker.createFrame()

        assertEquals(20, frame.height)
        assertEquals(15, frame.width)
        assertEquals(400.toLong(), frame.timeBetweenGens)
        assertTrue(frame.fillWithRandom)
        assertEquals(3, frame.chance)
    }

    @Test
    fun inputCheckTest() {
        System.setIn(ByteArrayInputStream("n\na\n2r\n20\n11.2\n15".toByteArray()))

        val frame = FrameMaker.createFrame()

        assertEquals(20, frame.height)
        assertEquals(15, frame.width)
    }
}