package gameOfLife.observer

interface GameObserver {
    fun noticeStop()
    fun noticeContinue()
    fun noticePause()
}