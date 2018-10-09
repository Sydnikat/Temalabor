package GameOfLife

import GameOfLife.Entity.Frame


fun main(args: Array<String>) {

    Game(FrameMaker.createFrame()).start()
    //Game(Frame(60,60, timeBetweenGens = 100)).start()

}