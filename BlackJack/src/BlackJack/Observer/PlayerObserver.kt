package BlackJack.Observer

interface PlayerObserver {

    fun noticeNewGame()
    fun noticeEndGame()
    fun noticeUpdate()
    fun noticePause()

}