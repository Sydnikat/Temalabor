package unitTests

import BlackJack.behavior.ClassicBank
import BlackJack.entity.Bank
import BlackJack.entity.Dealer
import BlackJack.entity.TesterDealer
import BlackJack.observer.DealerObserver
import BlackJack.observer.PlayerObserver
import org.junit.Test

import org.junit.Assert.*

class BankTest {

    val bank = Bank(
            basicAmountOfMoney = 0.0,
            dealer = TesterDealer(1, TestDealerObserver()),
            behavior = ClassicBank(),
            observer = TestPlayerObserver()
    )

    @Test
    fun playTest() {

    }

    @Test
    fun preparationTest() {
    }

    @Test
    fun receiveFirstCardsTest() {
    }

    @Test
    fun showDeckTest() {
    }
}

class TestPlayerObserver: PlayerObserver{

    override fun noticeEndGame() {}
    override fun noticeUpdate() {}
    override fun noticePause() {}
    override fun noticeNewGame() {}

}