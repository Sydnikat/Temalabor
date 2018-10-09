package GameOfLife.Observer

interface GameObserver {
    fun noticeStop()
    fun noticeContinue()
    fun noticePause()
}