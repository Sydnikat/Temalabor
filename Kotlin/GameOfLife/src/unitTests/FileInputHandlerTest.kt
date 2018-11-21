package unitTests

import gameOfLife.input.FileInputHandler
import org.junit.Test

import java.io.FileNotFoundException
import java.lang.Exception
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

    @Test(expected = Exception::class)
    fun wrongRowDataTest() {
        val frame = FileInputHandler.createFrameFromFile("missingRowDataTest")
    }

    @Test
    fun test() {
        assertFailsWith(Exception::class, "Nem megfelelő a fájl tartalma! A mátrix megadása helytelen2!"){
                FileInputHandler.createFrameFromFile("missingRowDataTest")
        }

    }
}