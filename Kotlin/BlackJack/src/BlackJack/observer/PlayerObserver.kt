package BlackJack.observer

interface PlayerObserver {

    fun noticeNewGame()
    fun noticeEndGame()
    fun noticeUpdate()

}