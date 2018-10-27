package gameOfLife

import gameOfLife.entity.Frame
import gameOfLife.input.ManualInputHandler

class Game(private val frame: Frame) {

    private val gameLoop = Thread(frame)
    private val inputWatcher = Thread(ManualInputHandler(frame))

    fun start(){

        frame.printResult()
        inputWatcher.start()
        gameLoop.start()

    }
}