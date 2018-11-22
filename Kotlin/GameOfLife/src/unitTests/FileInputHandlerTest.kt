package unitTests

import gameOfLife.input.FileInputHandler
import gameOfLife.type.StateType
import org.junit.Test

import java.io.FileNotFoundException
import java.lang.Exception
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith

class FileInputHandlerTest {

    @Test(expected = FileNotFoundException::class)
    fun wrongFileNameTest() {

        val frame = FileInputHandler.createFrameFromFile("this is not a test map")

    }

    @Test(expected = Exception::class)
    fun wrongInitDataTest() {
        val frame = FileInputHandler.createFrameFromFile("missingDataTest")
    }

    @Test
    fun wrongRowDataTest() {
        assertFailsWith(Exception::class){
            FileInputHandler.createFrameFromFile("missingRowDataTest")
        }
    }

    @Test
    fun createNewFrameTest() {
        val frame = FileInputHandler.createFrameFromFile("blinker")

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
}