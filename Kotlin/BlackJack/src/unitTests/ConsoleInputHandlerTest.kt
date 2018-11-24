package unitTests

import BlackJack.input.ConsoleInputHandler
import BlackJack.type.ActionType
import org.junit.Test

import org.junit.Assert.*
import java.io.ByteArrayInputStream

class ConsoleInputHandlerTest {

    private val cInputHandler = ConsoleInputHandler()

    @Test
    fun readNumberTest() {

        System.setIn(ByteArrayInputStream("5\n2.0\n2.2.2\n \n5a6".toByteArray()))

        assertEquals(5.0, cInputHandler.readNumber())

        assertEquals(2.0, cInputHandler.readNumber())

        assertEquals(null, cInputHandler.readNumber())

        assertEquals(null, cInputHandler.readNumber())

        assertEquals(null, cInputHandler.readNumber())

    }

    @Test
    fun readKey() {

        System.setIn(ByteArrayInputStream("s\nd\nq\nh\ne\nn\ni\n \nrossz input".toByteArray()))

        assertEquals(ActionType.SPLIT, cInputHandler.readKey())
        assertEquals(ActionType.DOUBLE, cInputHandler.readKey())
        assertEquals(ActionType.END, cInputHandler.readKey())
        assertEquals(ActionType.HIT, cInputHandler.readKey())
        assertEquals(ActionType.STAND, cInputHandler.readKey())
        assertEquals(ActionType.NEW, cInputHandler.readKey())
        assertEquals(ActionType.NEW, cInputHandler.readKey())
        assertEquals(ActionType.ERROR, cInputHandler.readKey())
        assertEquals(ActionType.ERROR, cInputHandler.readKey())

    }
}