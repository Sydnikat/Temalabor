package unitTests

import gameOfLife.Game
import gameOfLife.entity.Frame
import org.junit.Test

import java.io.ByteArrayInputStream

class GameTest {

    @Test
    fun start() {

        System.setIn(ByteArrayInputStream("s".toByteArray()))

        val game = Game(Frame(20,20))

        game.start()

    }
}