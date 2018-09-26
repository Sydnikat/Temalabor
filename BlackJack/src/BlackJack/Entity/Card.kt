package BlackJack.Entity

import BlackJack.Color.CardColor
import BlackJack.Type.CardTypes


data class Card(val value: CardTypes, val color: CardColor, var hidden: Boolean = false)