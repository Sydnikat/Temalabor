package unitTests

import gameOfLife.entity.Frame
import gameOfLife.input.ManualInputHandler
import org.junit.Test

import java.io.ByteArrayInputStream

class ManualInputHandlerTest {

    private val frame = Frame(20,20)
    private val manualInputHandler = ManualInputHandler(frame)

    @Test
    fun pauseAndContinueTest() {

        System.setIn(ByteArrayInputStream("\nc\ns".toByteArray()))
        Thread(frame).start() //Elindítom a játékot
        Thread(manualInputHandler).start()
    }
}
