package unitTests

import gameOfLife.entity.Frame
import gameOfLife.input.InputReader
import org.junit.Test

import org.junit.Assert.*
import java.io.ByteArrayInputStream

class FrameTest {

    val frame = Frame(20,20)

    @Test
    fun printResult() {

        System.setIn(ByteArrayInputStream("1".toByteArray()))

        val sz = InputReader.readNumber()

        assertEquals(1, sz)

    }
}