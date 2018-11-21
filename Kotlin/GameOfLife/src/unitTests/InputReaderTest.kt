package unitTests

import gameOfLife.input.InputReader
import org.junit.Test

import org.junit.Assert.*
import java.io.ByteArrayInputStream

class InputReaderTest {

    @Test
    fun readRealNumberTest() {
        System.setIn(ByteArrayInputStream("12".toByteArray()))

        val sz = InputReader.readNumber()

        assertEquals(12, sz)
    }

    @Test
    fun readStringTest() {
        System.setIn(ByteArrayInputStream("nem szám".toByteArray()))

        val sz = InputReader.readNumber()

        assertEquals(null, sz)
    }

    @Test
    fun readEmptyLineTest() {
        System.setIn(ByteArrayInputStream("".toByteArray()))

        val sz = InputReader.readNumber()

        assertEquals(null, sz)
    }

    @Test
    fun readWrongNumberTypeTest() {
        System.setIn(ByteArrayInputStream("12a4".toByteArray()))

        val sz = InputReader.readNumber()

        assertEquals(null, sz)
    }
}