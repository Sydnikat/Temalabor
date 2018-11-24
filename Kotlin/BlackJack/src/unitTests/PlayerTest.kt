package unitTests

import BlackJack.behavior.ClassicPlayer
import BlackJack.color.CardColor
import BlackJack.entity.Card
import BlackJack.entity.Player
import BlackJack.entity.TesterDealer
import BlackJack.input.ConsoleInputHandler
import BlackJack.type.CardType
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*
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
                        Card(CardType.FOUR, CardColor.CLUBS),
                        Card(CardType.QUEEN, CardColor.SPADES)

                )
        )

        player.changeDeck(0)

    }

    @Test
    fun doubleCheck() {

        System.setIn(ByteArrayInputStream("10".toByteArray()))

        player.raise()
        player.receiveFirstCards()

        assertEquals(90.0, player.showMoney(), 0.01)

        player.double(player.showDeck())

        assertEquals(20.0, player.showDeck().money, 0.01)

        assertEquals(80.0, player.showMoney(), 0.01)

    }

    @Test
    fun multipleDoubleTest() {

        System.setIn(ByteArrayInputStream("10".toByteArray()))

        player.raise()
        player.receiveFirstCards()

        assertEquals(90.0, player.showMoney(), 0.01)

        player.double(player.showDeck())
        player.double(player.showDeck())

        assertEquals(40.0, player.showDeck().money, 0.01)
        assertEquals(60.0, player.showMoney(), 0.01)

    }

    @Test
    fun checkMaximumDoubleTest() {

        System.setIn(ByteArrayInputStream("40".toByteArray()))

        player.raise()
        player.receiveFirstCards()

        assertEquals(60.0, player.showMoney(), 0.01)

        player.double(player.showDeck())
        player.double(player.showDeck())

        assertEquals(100.0, player.showDeck().money, 0.01)
        assertEquals(0.0, player.showMoney(), 0.01)

    }

    @Test
    fun playAndQuitTest() {

        System.setIn(ByteArrayInputStream("40\ns\nd\nh\ne\nh\nq".toByteArray()))

        player.raise()
        player.receiveFirstCards()

        player.play()

        assertNotEquals(100, player.showMoney())

    }

    @Test
    fun playAndNewGameTest() {

        System.setIn(ByteArrayInputStream("40\ns\nd\nh\ne\nh\nn\n500".toByteArray()))

        player.raise()
        player.receiveFirstCards()

        player.play()

        assertNotEquals(500, player.showMoney())

    }

    @Test
    fun simpleHitTest() {

        val dealer = player.dealer as TesterDealer

        dealer.createNewDeck(
                arrayListOf(
                        Card(CardType.TEN, CardColor.DIAMONDS),
                        Card(CardType.THREE, CardColor.HEARTS),
                        Card(CardType.FOUR, CardColor.SPADES),
                        Card(CardType.ACE, CardColor.CLUBS),
                        Card(CardType.JACK, CardColor.DIAMONDS),
                        Card(CardType.ACE, CardColor.DIAMONDS)

                )
        )

        System.setIn(ByteArrayInputStream("10".toByteArray()))

        player.raise()
        player.receiveFirstCards()

        player.hit(player.showDeck())

        assertEquals(3, player.showDeck().cards.count())

    }

    @Test
    fun multipleHitTest() {

        val dealer = player.dealer as TesterDealer

        dealer.createNewDeck(
                arrayListOf(
                        Card(CardType.TEN, CardColor.DIAMONDS),
                        Card(CardType.THREE, CardColor.HEARTS),
                        Card(CardType.FOUR, CardColor.SPADES),
                        Card(CardType.ACE, CardColor.CLUBS),
                        Card(CardType.JACK, CardColor.DIAMONDS),
                        Card(CardType.ACE, CardColor.DIAMONDS)

                )
        )

        System.setIn(ByteArrayInputStream("10".toByteArray()))

        player.raise()
        player.receiveFirstCards()

        player.hit(player.showDeck())
        player.hit(player.showDeck())
        player.hit(player.showDeck())

        assertEquals(5, player.showDeck().cards.count())

    }

    @Test
    fun checkMaximumHitTest() {

        val dealer = player.dealer as TesterDealer

        dealer.createNewDeck(
                arrayListOf(
                        Card(CardType.TEN, CardColor.DIAMONDS),
                        Card(CardType.THREE, CardColor.HEARTS),
                        Card(CardType.FOUR, CardColor.SPADES),
                        Card(CardType.ACE, CardColor.CLUBS),
                        Card(CardType.JACK, CardColor.DIAMONDS),
                        Card(CardType.ACE, CardColor.DIAMONDS)

                )
        )

        System.setIn(ByteArrayInputStream("10".toByteArray()))

        player.raise()
        player.receiveFirstCards()

        player.hit(player.showDeck())
        player.hit(player.showDeck())
        player.hit(player.showDeck())

        player.hit(player.showDeck())

        assertEquals(5, player.showDeck().cards.count())

    }

    @Test
    fun splitTwoCardsAndWithTheSameValueTest() {

        System.setIn(ByteArrayInputStream("10".toByteArray()))

        player.raise()
        player.receiveFirstCards()

        player.split(player.showDeck())

        assertEquals(1, player.showDeck().cards.count())
        assertEquals(5.0, player.showDeck().money, 0.01)

        player.changeDeck(player.numberOfUsedDecks - 1)


        assertEquals(1, player.showDeck().cards.count())
        assertEquals(5.0, player.showDeck().money, 0.01)

        assertEquals(Card(CardType.KING, CardColor.DIAMONDS), player.showDeck().cards[0])
    }

    @Test
    fun splitWithTwoCardsButNotTheSameValueTest() {

        //A két ugyan olyan kártya kivétele (az egységes kezelés és a boiler text csökkentése miatt)
        player.dealer.giveCard()
        player.dealer.giveCard()

        System.setIn(ByteArrayInputStream("10".toByteArray()))

        player.raise()
        player.receiveFirstCards()

        val currentUsedDeckNumber = player.numberOfUsedDecks

        player.split(player.showDeck())

        assertEquals(2, player.showDeck().cards.count())
        assertEquals(10.0, player.showDeck().money, 0.01)

        player.changeDeck(currentUsedDeckNumber + 1)


        assertEquals(0, player.showDeck().cards.count())
        assertEquals(0.0, player.showDeck().money, 0.01)

    }

    @Test
    fun splitButNotWithTwoNumberTest() {

        //A két ugyan olyan kártya kivétele (az egységes kezelés és a boiler text csökkentése miatt)
        player.dealer.giveCard()
        player.dealer.giveCard()

        System.setIn(ByteArrayInputStream("10".toByteArray()))

        player.raise()
        player.receiveFirstCards()

        val currentUsedDeckNumber = player.numberOfUsedDecks

        player.hit(player.showDeck())

        player.split(player.showDeck())

        assertEquals(3, player.showDeck().cards.count())
        assertEquals(10.0, player.showDeck().money, 0.01)

        player.changeDeck(currentUsedDeckNumber + 1)


        assertEquals(0, player.showDeck().cards.count())
        assertEquals(0.0, player.showDeck().money, 0.01)

    }

    @Test
    fun multipleSplitAndPreparationTest() {

        val dealer = player.dealer as TesterDealer

        dealer.createNewDeck(
                arrayListOf(
                        Card(CardType.JACK, CardColor.DIAMONDS),
                        Card(CardType.JACK, CardColor.HEARTS),
                        Card(CardType.JACK, CardColor.SPADES),
                        Card(CardType.JACK, CardColor.CLUBS),
                        Card(CardType.JACK, CardColor.DIAMONDS)

                )
        )

        System.setIn(ByteArrayInputStream("10".toByteArray()))

        player.raise()
        player.receiveFirstCards()

        player.split(player.showDeck())

        assertEquals(1, player.showDeck().cards.count())
        assertEquals(5.0, player.showDeck().money, 0.01)


        player.hit(player.showDeck())

        player.split(player.showDeck())

        assertEquals(1, player.showDeck().cards.count())
        assertEquals(2.5, player.showDeck().money, 0.01)

        player.hit(player.showDeck())

        player.split(player.showDeck())

        assertEquals(2, player.showDeck().cards.count())
        assertEquals(2.5, player.showDeck().money, 0.01)

        player.changeDeck(player.numberOfUsedDecks - 1)

        assertEquals(1, player.showDeck().cards.count())
        assertEquals(2.5, player.showDeck().money, 0.01)

        // ---------------------------------------------------------
        //Itt talán a legjobb tesztelni a preparation függvényt
        // ---------------------------------------------------------

        (0 until player.numberOfUsedDecks).forEach {
            player.changeDeck(it)

            if(it == 0)
                assertEquals(2, player.showDeck().cards.count())
            else
                assertEquals(1, player.showDeck().cards.count())
        }

        assertEquals(3, player.numberOfUsedDecks)

        player.preparation()

        assertEquals(1, player.numberOfUsedDecks)

        (0 until player.behavior.getMaximumNumberOfDecks()).forEach {
            player.changeDeck(it)
            assertEquals(0, player.showDeck().cards.count())
            assertEquals(0.0, player.showDeck().money, 0.01)
        }


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