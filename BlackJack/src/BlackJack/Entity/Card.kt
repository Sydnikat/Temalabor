package BlackJack.Entity

import BlackJack.Color.CardColor
import BlackJack.Type.CardType


data class Card(val value: CardType, val color: CardColor, var hidden: Boolean = false)