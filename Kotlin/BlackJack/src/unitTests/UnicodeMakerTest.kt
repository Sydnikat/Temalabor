package unitTests

import BlackJack.color.CardColor
import BlackJack.entity.Card
import BlackJack.gfx.UnicodeMaker
import BlackJack.type.CardType
import org.junit.Test

import org.junit.Assert.*

class UnicodeMakerTest {

    @Test
    fun cardToUnicodeTest() {

        assertEquals(
                "\uD83C\uDCA0",
                UnicodeMaker.cardToUnicode(Card(CardType.JACK, CardColor.CLUBS, hidden = true))
        )

        assertEquals(
                "\uD83C\uDCDB",
                UnicodeMaker.cardToUnicode(Card(CardType.JACK, CardColor.CLUBS, hidden = false))
        )

        assertEquals(
                "\uD83C\uDCB4",
                UnicodeMaker.cardToUnicode(Card(CardType.FOUR, CardColor.HEARTS, hidden = false))
        )

        assertEquals(
                "\uD83C\uDCA9",
                UnicodeMaker.cardToUnicode(Card(CardType.NINE, CardColor.SPADES, hidden = false))
        )

        assertEquals(
                "\uD83C\uDCCE",
                UnicodeMaker.cardToUnicode(Card(CardType.KING, CardColor.DIAMONDS, hidden = false))
        )


    }
}