package unitTests

import BlackJack.entity.Dealer
import BlackJack.observer.DealerObserver
import org.junit.Test

import org.junit.Assert.*

class DealerTest {
    @Test
    fun giveCardAndNoticeLowDeckTest() {

        val testDealerObserver = TestDealerObserver()

        val dealer = Dealer(numberOfDecksUsed = 1, observer = testDealerObserver)

        testDealerObserver.dealer = dealer

        assertEquals(52, dealer.getDeckPoolSize())

        dealer.giveCard()

        assertEquals(51, dealer.getDeckPoolSize())

        (1..25).forEach { _ ->
            dealer.giveCard()
        }

        assertEquals(26, dealer.getDeckPoolSize())

        dealer.giveCard()

        assertEquals(25, dealer.getDeckPoolSize())

        dealer.giveCard()

        assertEquals(51, dealer.getDeckPoolSize())

    }
}

class TestDealerObserver: DealerObserver{

    var dealer: Dealer? = null

    override fun noticeLowDeck() {

        dealer?.createNewDeck()

    }

}