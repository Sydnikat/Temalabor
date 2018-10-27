package gameOfLife.input

import gameOfLife.observer.GameObserver

class ManualInputHandler(private val observer: GameObserver) : Runnable {
    
    override fun run() {

        var done = false
        while (!done){

            val command = readLine()

            when (command) {
                "" -> {
                    observer.noticePause()
                    println("c - continue\t s - stop")
                }
                "c" -> observer.noticeContinue()
                "s" -> {
                    observer.noticeStop()
                    done = true
                }
            }
        }
    }

}