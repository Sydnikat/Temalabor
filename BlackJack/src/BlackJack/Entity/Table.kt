package BlackJack.Entity

import BlackJack.Observer.DealerObserver
import BlackJack.Observer.PlayerObserver

class Table : DealerObserver, PlayerObserver {


    override fun noticeStand() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun noticeSplit() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun noticeNewGane() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun noticeEndGame() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun noticeLowDeck() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }
}