package BlackJack.entity

import BlackJack.behavior.ClassicPlayer
import BlackJack.color.CardColor
import BlackJack.input.ConsoleInputHandler
import BlackJack.type.CardType
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*
import unitTests.TestDealerObserver
import unitTests.TestPlayerObserver
import java.io.ByteArrayInputStream

class PlayerTest {

    private val player = Player(
            basicAmountOfMoney = 100.0,
            dealer = TesterDealer(1, TestDealerObserver()),
            behavior = ClassicPlayer(),
            observer = TestPlayerObserver(),
            inputHandler = ConsoleInputHandler()
    )

    @Before
    fun setUp() {

        val dealer = player.dealer as TesterDealer

        dealer.createNewDeck(
                arrayListOf(
                        Card(CardType.KING, CardColor.DIAMONDS),
                        Card(CardType.KING, CardColor.HEARTS),
                        Card(CardType.NINE, CardColor.CLUBS),
                        Card(CardType.QUEEN, CardColor.SPADES)

                )
        )

        player.changeDeck(0)

    }

    @Test
    fun preparation() {
    }

    @Test
    fun playTest() {
    }

    @Test
    fun hitTest() {
    }

    @Test
    fun splitTest() {
    }

    @Test
    fun raiseTest() {

        System.setIn(ByteArrayInputStream("1a\n100.1\n100".toByteArray()))

        player.raise()

        assertEquals(0.0, player.showMoney(), 0.01)
        assertEquals(100.0, player.showDeck().money, 0.01)

        (1 until player.behavior.getMaximumNumberOfDecks()).forEach {

            player.changeDeck(it)

            assertEquals(0.0, player.showDeck().money, 0.01)
        }

    }

    @Test
    fun receiveFirstCardsTest() {

        player.receiveFirstCards()

        assertEquals(Card(CardType.KING, CardColor.DIAMONDS), player.showDeck().cards[0])
        assertEquals(Card(CardType.KING, CardColor.HEARTS), player.showDeck().cards[1])


    }

}