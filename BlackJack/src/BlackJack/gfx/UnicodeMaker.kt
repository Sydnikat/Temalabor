package BlackJack.gfx

import BlackJack.Color.CardColor
import BlackJack.Entity.Card
import BlackJack.Type.CardType

object UnicodeMaker {

    fun cardToUnicode(card: Card) =
            if(!card.hidden) {
                when (card.color) {
                    CardColor.SPADES -> {
                        when (card.value) {
                            CardType.ACE -> "\uD83C\uDCA1"
                            CardType.TWO -> "\uD83C\uDCA2"
                            CardType.THREE -> "\uD83C\uDCA3"
                            CardType.FOUR -> "\uD83C\uDCA4"
                            CardType.FIVE -> "\uD83C\uDCA5"
                            CardType.SIX -> "\uD83C\uDCA6"
                            CardType.SEVEN -> "\uD83C\uDCA7"
                            CardType.EIGHT -> "\uD83C\uDCA8"
                            CardType.NINE -> "\uD83C\uDCA9"
                            CardType.TEN -> "\uD83C\uDCAA"
                            CardType.JACK -> "\uD83C\uDCAB"
                            CardType.QUEEN -> "\uD83C\uDCAD"
                            CardType.KING -> "\uD83C\uDCAE"
                        }
                    }
                    CardColor.HEARTS -> {
                        when (card.value) {
                            CardType.ACE -> "\uD83C\uDCB1"
                            CardType.TWO -> "\uD83C\uDCB2"
                            CardType.THREE -> "\uD83C\uDCB3"
                            CardType.FOUR -> "\uD83C\uDCB4"
                            CardType.FIVE -> "\uD83C\uDCB5"
                            CardType.SIX -> "\uD83C\uDCB6"
                            CardType.SEVEN -> "\uD83C\uDCB7"
                            CardType.EIGHT -> "\uD83C\uDCB8"
                            CardType.NINE -> "\uD83C\uDCB9"
                            CardType.TEN -> "\uD83C\uDCBA"
                            CardType.JACK -> "\uD83C\uDCBB"
                            CardType.QUEEN -> "\uD83C\uDCBD"
                            CardType.KING -> "\uD83C\uDCBE"
                        }
                    }
                    CardColor.DIAMONDS -> {
                        when (card.value) {
                            CardType.ACE -> "\uD83C\uDCC1"
                            CardType.TWO -> "\uD83C\uDCC3"
                            CardType.THREE -> "\uD83C\uDCC3"
                            CardType.FOUR -> "\uD83C\uDCC4"
                            CardType.FIVE -> "\uD83C\uDCC5"
                            CardType.SIX -> "\uD83C\uDCC6"
                            CardType.SEVEN -> "\uD83C\uDCC7"
                            CardType.EIGHT -> "\uD83C\uDCC8"
                            CardType.NINE -> "\uD83C\uDCC9"
                            CardType.TEN -> "\uD83C\uDCCA"
                            CardType.JACK -> "\uD83C\uDCCB"
                            CardType.QUEEN -> "\uD83C\uDCCD"
                            CardType.KING -> "\uD83C\uDCCE"
                        }
                    }
                    CardColor.CLUBS -> {
                        when (card.value) {
                            CardType.ACE -> "\uD83C\uDCD1"
                            CardType.TWO -> "\uD83C\uDCD2"
                            CardType.THREE -> "\uD83C\uDCD3"
                            CardType.FOUR -> "\uD83C\uDCD4"
                            CardType.FIVE -> "\uD83C\uDCD5"
                            CardType.SIX -> "\uD83C\uDCD6"
                            CardType.SEVEN -> "\uD83C\uDCD7"
                            CardType.EIGHT -> "\uD83C\uDCD8"
                            CardType.NINE -> "\uD83C\uDCD9"
                            CardType.TEN -> "\uD83C\uDCDA"
                            CardType.JACK -> "\uD83C\uDCDB"
                            CardType.QUEEN -> "\uD83C\uDCDD"
                            CardType.KING -> "\uD83C\uDCDE"
                        }
                    }
                }
            }else "\uD83C\uDCA0"
}