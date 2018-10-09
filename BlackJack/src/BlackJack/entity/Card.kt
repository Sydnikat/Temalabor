package BlackJack.entity

import BlackJack.color.CardColor
import BlackJack.type.CardType


data class Card(val value: CardType, val color: CardColor, var hidden: Boolean = false)