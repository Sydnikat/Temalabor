package BlackJack.Observer

interface PlayerObserver {

    fun noticeStand()
    fun noticeSplit()
    fun noticeNewGane()
    fun noticeEndGame()

}