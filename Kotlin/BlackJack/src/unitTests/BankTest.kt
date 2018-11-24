package unitTests

import BlackJack.behavior.ClassicBank
import BlackJack.color.CardColor
import BlackJack.entity.Bank
import BlackJack.entity.Card
import BlackJack.entity.TesterDealer
import BlackJack.observer.PlayerObserver
import BlackJack.type.CardType
import org.junit.Test

import org.junit.Assert.*
import org.junit.Before

class BankTest {

    private val bank = Bank(
            basicAmountOfMoney = 0.0,
            dealer = TesterDealer(1, TestDealerObserver()),
            behavior = ClassicBank(),
            observer = TestPlayerObserver()
    )

    @Before
    fun setUp(){

        val dealer = bank.dealer as TesterDealer

        dealer.createNewDeck(
                arrayListOf(
                        Card(CardType.KING, CardColor.DIAMONDS),
                        Card(CardType.FOUR, CardColor.HEARTS),
                        Card(CardType.NINE, CardColor.CLUBS),
                        Card(CardType.QUEEN, CardColor.SPADES)

                )
        )

        bank.receiveFirstCards()
    }

    @Test
    fun playTest() {

        bank.play()

        assertEquals(3, bank.showDeck().cards.count())

        assertFalse(bank.showDeck().cards[1].hidden)

        assertEquals(CardType.NINE, bank.showDeck().cards[2].value)
        assertEquals(CardColor.CLUBS, bank.showDeck().cards[2].color)

    }

    @Test
    fun receiveFirstCardsTest() {

        assertEquals(CardType.KING, bank.showDeck().cards[0].value)
        assertEquals(CardColor.DIAMONDS, bank.showDeck().cards[0].color)

        assertEquals(CardType.FOUR, bank.showDeck().cards[1].value)
        assertEquals(CardColor.HEARTS, bank.showDeck().cards[1].color)

        assertTrue(bank.showDeck().cards[1].hidden)

    }
}

class TestPlayerObserver: PlayerObserver{

    override fun noticeEndGame() {}
    override fun noticeUpdate() {}
    override fun noticePause() {}
    override fun noticeNewGame() {}

}