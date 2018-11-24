package unitTests

import BlackJack.color.CardColor
import BlackJack.entity.Calculator
import BlackJack.entity.Card
import BlackJack.entity.Deck
import BlackJack.type.CardType
import BlackJack.type.ResultType
import org.junit.Test
import kotlin.test.assertEquals


class CalculatorTest {

    @Test
    fun evaluateCardsWithoutAce() {

        val cards1 = arrayListOf(
                Card(CardType.EIGHT, CardColor.CLUBS),
                Card(CardType.TEN, CardColor.SPADES)
        )

        val cards2 = arrayListOf(
                Card(CardType.QUEEN, CardColor.DIAMONDS),
                Card(CardType.KING, CardColor.SPADES)
        )

        val cards3 = arrayListOf(
                Card(CardType.JACK, CardColor.CLUBS),
                Card(CardType.TEN, CardColor.HEARTS)
        )

        val cards4 = arrayListOf(
                Card(CardType.TWO, CardColor.CLUBS),
                Card(CardType.SEVEN, CardColor.SPADES),
                Card(CardType.SIX, CardColor.HEARTS),
                Card(CardType.FOUR, CardColor.SPADES)
        )

        assertEquals(18, Calculator.evaluate(cards1))
        assertEquals(22, Calculator.evaluate(cards2))
        assertEquals(21, Calculator.evaluate(cards3))
        assertEquals(19, Calculator.evaluate(cards4))

    }

    @Test
    fun evaluateCardsWithAceButLessThan21OrEvenWith21Test() {

        val cards1 = arrayListOf(
                Card(CardType.EIGHT, CardColor.CLUBS),
                Card(CardType.ACE, CardColor.SPADES)
        )

        val cards2 = arrayListOf(
                Card(CardType.TEN, CardColor.DIAMONDS),
                Card(CardType.ACE, CardColor.HEARTS)
        )

        assertEquals(19, Calculator.evaluate(cards1))
        assertEquals(21, Calculator.evaluate(cards2))

    }

    @Test
    fun evaluateCardsWithAceButMoreThan21Test() {

        val cards1 = arrayListOf(
                Card(CardType.JACK, CardColor.CLUBS),
                Card(CardType.ACE, CardColor.SPADES)
        )

        val cards2 = arrayListOf(
                Card(CardType.ACE, CardColor.DIAMONDS),
                Card(CardType.TEN, CardColor.SPADES),
                Card(CardType.TWO, CardColor.SPADES)
        )

        val cards3 = arrayListOf(
                Card(CardType.ACE, CardColor.DIAMONDS),
                Card(CardType.FOUR, CardColor.CLUBS),
                Card(CardType.SIX, CardColor.HEARTS),
                Card(CardType.QUEEN, CardColor.DIAMONDS)
        )

        assertEquals(12, Calculator.evaluate(cards1))
        assertEquals(13, Calculator.evaluate(cards2))
        assertEquals(22, Calculator.evaluate(cards3))

    }

    @Test
    fun evaluateCardsWithMultipleAcesTest() {

        val cards1 = arrayListOf(
                Card(CardType.ACE, CardColor.CLUBS),
                Card(CardType.ACE, CardColor.SPADES)
        )

        val cards2 = arrayListOf(
                Card(CardType.ACE, CardColor.DIAMONDS),
                Card(CardType.TEN, CardColor.SPADES),
                Card(CardType.ACE, CardColor.SPADES),
                Card(CardType.SIX, CardColor.SPADES)
        )

        val cards3 = arrayListOf(
                Card(CardType.ACE, CardColor.DIAMONDS),
                Card(CardType.EIGHT, CardColor.CLUBS),
                Card(CardType.ACE, CardColor.HEARTS),
                Card(CardType.JACK, CardColor.DIAMONDS)
        )

        assertEquals(12, Calculator.evaluate(cards1))
        assertEquals(18, Calculator.evaluate(cards2))
        assertEquals(21, Calculator.evaluate(cards3))

    }

    @Test
    fun calculateResultWithWinByBlackJackTest() {

        var pDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.JACK, CardColor.CLUBS),
                Card(CardType.TEN, CardColor.SPADES)
        ))

        var bDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.NINE, CardColor.DIAMONDS),
                Card(CardType.ACE, CardColor.HEARTS)
        ))

        assertEquals(ResultType.WINBYJACK, Calculator.calculateResult(pDeck, bDeck))

        pDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.TEN, CardColor.DIAMONDS),
                Card(CardType.JACK, CardColor.HEARTS)
        ))

        bDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.TEN, CardColor.SPADES),
                Card(CardType.ACE, CardColor.SPADES)
        ))

        assertEquals(ResultType.WINBYJACK, Calculator.calculateResult(pDeck, bDeck))

    }

    @Test
    fun calculateResultWithLoseByBlackJackTest() {

        var bDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.JACK, CardColor.CLUBS),
                Card(CardType.TEN, CardColor.SPADES)
        ))

        var pDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.NINE, CardColor.DIAMONDS),
                Card(CardType.ACE, CardColor.HEARTS)
        ))

        assertEquals(ResultType.LOSEBYJACK, Calculator.calculateResult(pDeck, bDeck))

        bDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.TEN, CardColor.DIAMONDS),
                Card(CardType.JACK, CardColor.HEARTS)
        ))

        pDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.TEN, CardColor.SPADES),
                Card(CardType.ACE, CardColor.SPADES)
        ))

        assertEquals(ResultType.LOSEBYJACK, Calculator.calculateResult(pDeck, bDeck))

    }

    @Test
    fun calculateResultWithTieTest() {

        var bDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.NINE, CardColor.CLUBS),
                Card(CardType.TEN, CardColor.SPADES),
                Card(CardType.TWO, CardColor.SPADES)
        ))

        var pDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.TEN, CardColor.DIAMONDS),
                Card(CardType.ACE, CardColor.HEARTS)
        ))

        assertEquals(ResultType.TIE, Calculator.calculateResult(pDeck, bDeck))

        bDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.TEN, CardColor.DIAMONDS),
                Card(CardType.SIX, CardColor.SPADES),
                Card(CardType.FOUR, CardColor.CLUBS)
        ))

        pDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.NINE, CardColor.DIAMONDS),
                Card(CardType.FIVE, CardColor.HEARTS),
                Card(CardType.THREE, CardColor.SPADES),
                Card(CardType.THREE, CardColor.HEARTS)

        ))

        assertEquals(ResultType.TIE, Calculator.calculateResult(pDeck, bDeck))

    }

    @Test
    fun calculateResultLoseTest() {


        var pDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.QUEEN, CardColor.CLUBS),
                Card(CardType.KING, CardColor.SPADES)
        ))

        var bDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.THREE, CardColor.DIAMONDS),
                Card(CardType.ACE, CardColor.HEARTS)
        ))

        assertEquals(ResultType.LOSE, Calculator.calculateResult(pDeck, bDeck))

        pDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.QUEEN, CardColor.CLUBS),
                Card(CardType.KING, CardColor.SPADES)
        ))

        bDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.JACK, CardColor.DIAMONDS),
                Card(CardType.JACK, CardColor.HEARTS)
        ))

        assertEquals(ResultType.LOSE, Calculator.calculateResult(pDeck, bDeck))
        pDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.TEN, CardColor.DIAMONDS),
                Card(CardType.SIX, CardColor.SPADES),
                Card(CardType.THREE, CardColor.CLUBS)
        ))

        bDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.NINE, CardColor.DIAMONDS),
                Card(CardType.FIVE, CardColor.HEARTS),
                Card(CardType.THREE, CardColor.SPADES),
                Card(CardType.THREE, CardColor.HEARTS)

        ))

        assertEquals(ResultType.LOSE, Calculator.calculateResult(pDeck, bDeck))

    }

    @Test
    fun calculateWinTest() {

        var pDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.TEN, CardColor.CLUBS),
                Card(CardType.KING, CardColor.SPADES)
        ))

        var bDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.JACK, CardColor.DIAMONDS),
                Card(CardType.JACK, CardColor.HEARTS)
        ))

        assertEquals(ResultType.WIN, Calculator.calculateResult(pDeck, bDeck))

        pDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.TEN, CardColor.DIAMONDS),
                Card(CardType.SIX, CardColor.SPADES),
                Card(CardType.THREE, CardColor.CLUBS)
        ))

        bDeck = Deck(money = 0.0, cards = arrayListOf(
                Card(CardType.NINE, CardColor.DIAMONDS),
                Card(CardType.FIVE, CardColor.HEARTS),
                Card(CardType.THREE, CardColor.SPADES)

        ))

        assertEquals(ResultType.WIN, Calculator.calculateResult(pDeck, bDeck))

    }
}