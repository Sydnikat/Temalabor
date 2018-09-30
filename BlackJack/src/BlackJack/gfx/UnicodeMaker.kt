package BlackJack.gfx

import BlackJack.Color.CardColor
import BlackJack.Entity.Card
import BlackJack.Type.CardType

fun Char.or(other: Char?): Char = this.toInt().or(other?.toInt()!!).toChar()

object UnicodeMaker {

    fun cardToUnicode(card: Card): String {

        if(card.hidden) return "\uD83C\uDCA0"

        val list = mutableMapOf<CardType,Char>()

        CardType.values().forEach {
            var i = it.ordinal + 2
            if (i >= 0xC)
                i++
            list[it] = i.toChar()
        }
        list[CardType.ACE] = 1.toChar()

        val colorChar =
                when(card.color) {
                    CardColor.SPADES-> '\uDCA0'
                    CardColor.HEARTS -> '\uDCB0'
                    CardColor.DIAMONDS -> '\uDCC0'
                    CardColor.CLUBS -> '\uDCD0'
        }

        val firstChar = '\uD83C'
        val secondChar = colorChar.or(list[card.value])

        return "$firstChar$secondChar"

    }
}