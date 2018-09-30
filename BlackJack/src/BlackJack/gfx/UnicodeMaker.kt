package BlackJack.gfx

import BlackJack.Color.CardColor
import BlackJack.Entity.Card
import BlackJack.Type.CardTypes

object UnicodeMaker {

    fun cardToUnicode(card: Card) =
            if(!card.hidden) {
                when (card.color) {
                    CardColor.SPADES -> {
                        when (card.value) {
                            CardTypes.ACE -> "\uD83C\uDCA1"
                            CardTypes.TWO -> "\uD83C\uDCA2"
                            CardTypes.THREE -> "\uD83C\uDCA3"
                            CardTypes.FOUR -> "\uD83C\uDCA4"
                            CardTypes.FIVE -> "\uD83C\uDCA5"
                            CardTypes.SIX -> "\uD83C\uDCA6"
                            CardTypes.SEVEN -> "\uD83C\uDCA7"
                            CardTypes.EIGHT -> "\uD83C\uDCA8"
                            CardTypes.NINE -> "\uD83C\uDCA9"
                            CardTypes.TEN -> "\uD83C\uDCAA"
                            CardTypes.JACK -> "\uD83C\uDCAB"
                            CardTypes.QUEEN -> "\uD83C\uDCAD"
                            CardTypes.KING -> "\uD83C\uDCAE"
                        }
                    }
                    CardColor.HEARTS -> {
                        when (card.value) {
                            CardTypes.ACE -> "\uD83C\uDCB1"
                            CardTypes.TWO -> "\uD83C\uDCB2"
                            CardTypes.THREE -> "\uD83C\uDCB3"
                            CardTypes.FOUR -> "\uD83C\uDCB4"
                            CardTypes.FIVE -> "\uD83C\uDCB5"
                            CardTypes.SIX -> "\uD83C\uDCB6"
                            CardTypes.SEVEN -> "\uD83C\uDCB7"
                            CardTypes.EIGHT -> "\uD83C\uDCB8"
                            CardTypes.NINE -> "\uD83C\uDCB9"
                            CardTypes.TEN -> "\uD83C\uDCBA"
                            CardTypes.JACK -> "\uD83C\uDCBB"
                            CardTypes.QUEEN -> "\uD83C\uDCBD"
                            CardTypes.KING -> "\uD83C\uDCBE"
                        }
                    }
                    CardColor.DIAMONDS -> {
                        when (card.value) {
                            CardTypes.ACE -> "\uD83C\uDCC1"
                            CardTypes.TWO -> "\uD83C\uDCC3"
                            CardTypes.THREE -> "\uD83C\uDCC3"
                            CardTypes.FOUR -> "\uD83C\uDCC4"
                            CardTypes.FIVE -> "\uD83C\uDCC5"
                            CardTypes.SIX -> "\uD83C\uDCC6"
                            CardTypes.SEVEN -> "\uD83C\uDCC7"
                            CardTypes.EIGHT -> "\uD83C\uDCC8"
                            CardTypes.NINE -> "\uD83C\uDCC9"
                            CardTypes.TEN -> "\uD83C\uDCCA"
                            CardTypes.JACK -> "\uD83C\uDCCB"
                            CardTypes.QUEEN -> "\uD83C\uDCCD"
                            CardTypes.KING -> "\uD83C\uDCCE"
                        }
                    }
                    CardColor.CLUBS -> {
                        when (card.value) {
                            CardTypes.ACE -> "\uD83C\uDCD1"
                            CardTypes.TWO -> "\uD83C\uDCD2"
                            CardTypes.THREE -> "\uD83C\uDCD3"
                            CardTypes.FOUR -> "\uD83C\uDCD4"
                            CardTypes.FIVE -> "\uD83C\uDCD5"
                            CardTypes.SIX -> "\uD83C\uDCD6"
                            CardTypes.SEVEN -> "\uD83C\uDCD7"
                            CardTypes.EIGHT -> "\uD83C\uDCD8"
                            CardTypes.NINE -> "\uD83C\uDCD9"
                            CardTypes.TEN -> "\uD83C\uDCDA"
                            CardTypes.JACK -> "\uD83C\uDCDB"
                            CardTypes.QUEEN -> "\uD83C\uDCDD"
                            CardTypes.KING -> "\uD83C\uDCDE"
                        }
                    }
                }
            }else "\uD83C\uDCA0"
}