package GameOfLife

import GameOfLife.Entity.Frame
import GameOfLife.Input.ManualInputHandler

class Game(private val frame: Frame) {

    private val gameLoop = Thread(frame)
    private val inputWatcher = Thread(ManualInputHandler(frame))

    fun start(){

        frame.printResult()
        inputWatcher.start()
        gameLoop.start()

    }
}