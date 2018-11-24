package unitTests

import BlackJack.color.CardColor
import BlackJack.entity.Card
import BlackJack.entity.Table
import BlackJack.entity.TesterDealer
import BlackJack.input.ConsoleInputHandler
import BlackJack.type.CardType
import org.junit.Test

import org.junit.Assert.*
import java.io.ByteArrayInputStream
import java.util.*

class TableTest {

    private val table = Table(
            numberOfDecks = 5,
            inputHandler = ConsoleInputHandler(),
            testing = true
    )

    @Test
    fun gameTestWithWinByBlackJackAndStopAndQuit() {

        val dealer = table.dealer as TesterDealer

        // Csinálok egy olyan osztót, aminek gyorsan megadom a felhasználandó kártyákat.
        // Itt csak az értékekből gyorsan csinálok egy teszt paklit.
        dealer.createNewDeck(deckMaker("10 j 3 7 q 8".split(" ")))


        // Először kér rossz input az alapösszegre, amjd a jó adat.
        // Aztán egy rossz input a kezdésre, majd egy indítás.
        // Ezután megint rossz adat tesztelése az emelésnél, majd 10-es érték bevitele.
        // Menet elindul majd megáll, aztán kilép
        System.setIn(ByteArrayInputStream("100e\n100\no\nn\nj10\n10\ne\nq\nq".toByteArray()))

        table.startGame()

        assertEquals(115.0, table.getPlayerMoney() , 0.001)
        assertEquals(1, table.winCount)
        assertEquals(0, table.loseCount)

    }

    @Test
    fun gameTestWithLoseByBlackJackAndStopAndQuit() {

        val dealer = table.dealer as TesterDealer
        dealer.createNewDeck(deckMaker("3 7 10 j q 8".split(" ")))

        System.setIn(ByteArrayInputStream("10e\n10\no\nn\nj10\n10\ne\nq\nq".toByteArray()))

        table.startGame()

        assertEquals(0.0, table.getPlayerMoney() , 0.001)
        assertEquals(0, table.winCount)
        assertEquals(1, table.loseCount)

    }

    @Test
    fun gameTestWithTwoTimesThanNewGameAndThenStop() {

        // Egy sor egy kör kártyáinak felel meg.
        // Ezzel tesztelek egy győztes, egy vesztes egy döntetlen kört.
        // Az utolsó sor pedig csak a teszt befejezéséhez kell.
        val dealer = table.dealer as TesterDealer
        dealer.createNewDeck(deckMaker(("3 7 10 10 q " +
                                        "k 4 4 5 j " +
                                        "j 6 7 10 " +
                                        "k q j 10").split(" ")))

        // Először kér rossz input az alapösszegre, amjd a jó adat.
        // Aztán egy rossz input a kezdésre, majd egy indítás.
        // Ezután megint rossz adat tesztelése az emelésnél, majd 10-es érték bevitele.
        // Aztán húz -> megáll -> folytatja -> emel 5-öt -> megáll -> abbahagyja.
        // Újat kezd -> 200 az alapösszeg -> új játék start -> 10-et emel -> megáll -> folytatja
        // -> 10-et emel -> új játékot kezd -> 500 az alapösszeg majd nem indít, hanem egyből kilép.
        System.setIn(ByteArrayInputStream(
                ("10e\n100\no\nn\nj20\n10\nh\ne\ni\n5\ne\nq" +
                        "\nn\n200\nn\n10\ne\ni\n10\nn\n500\nq").toByteArray())
        )

        table.startGame()

        assertEquals(500.0, table.getPlayerMoney() , 0.001)
        assertEquals(0, table.winCount)
        assertEquals(0, table.loseCount)

    }

    private fun deckMaker(cards: List<String>): ArrayList<Card> {

        val result = ArrayList<Card>()

        cards.forEach {
            result.add( when(it){
                "1" -> Card(CardType.ACE, CardColor.DIAMONDS)
                "2" -> Card(CardType.TWO, CardColor.DIAMONDS)
                "3" -> Card(CardType.THREE, CardColor.DIAMONDS)
                "4" -> Card(CardType.FOUR, CardColor.DIAMONDS)
                "5" -> Card(CardType.FIVE, CardColor.DIAMONDS)
                "6" -> Card(CardType.SIX, CardColor.DIAMONDS)
                "7" -> Card(CardType.SEVEN, CardColor.DIAMONDS)
                "8" -> Card(CardType.EIGHT, CardColor.DIAMONDS)
                "9" -> Card(CardType.NINE, CardColor.DIAMONDS)
                "10" -> Card(CardType.TEN, CardColor.DIAMONDS)
                "j" -> Card(CardType.JACK, CardColor.DIAMONDS)
                "q" -> Card(CardType.QUEEN, CardColor.DIAMONDS)
                "k" -> Card(CardType.KING, CardColor.DIAMONDS)
                else -> Card(CardType.ACE, CardColor.DIAMONDS)

            })
        }

        return result

    }
}