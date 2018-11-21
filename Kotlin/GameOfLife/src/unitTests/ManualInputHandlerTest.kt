package unitTests

import gameOfLife.entity.Frame
import gameOfLife.input.ManualInputHandler
import gameOfLife.type.GameState
import org.junit.Test

import org.junit.Assert.*
import java.io.ByteArrayInputStream

class ManualInputHandlerTest {

    private val frame = Frame(20,20)
    private val manualInputHandler = ManualInputHandler(frame)

    @Test
    fun pauseAndContinueTest() {
        Thread(PausedTest(frame)).start()
        Thread(frame).start() //Elindítom a játékot
        Thread(manualInputHandler).start()
    }
}

class PausedTest(private val frame: Frame): Runnable{
    override fun run() {

        Thread.sleep(10)  // Megvárom, hogy mindenképp elinduljon a másik szál

        System.setIn(ByteArrayInputStream("".toByteArray())) // Megállíltom a játékot

        Thread.sleep(10)

        assertEquals(GameState.PAUSED, frame.state)

        System.setIn(ByteArrayInputStream("c".toByteArray())) // Majd elindítom a átékot

        Thread.sleep(10)

        assertEquals(GameState.RUNNING, frame.state)

        System.setIn(ByteArrayInputStream("s".toByteArray())) // Végül leállítom, hogy ne ragadjon be a while ciklus

        Thread.sleep(10)

        assertEquals(GameState.STOP, frame.state)
    }

}