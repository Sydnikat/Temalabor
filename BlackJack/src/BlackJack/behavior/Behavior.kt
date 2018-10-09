package BlackJack.behavior

import BlackJack.entity.Card
import java.util.*

interface Behavior {
    fun hit(cards: ArrayList<Card>) : Boolean
    fun double(cards: ArrayList<Card>) : Boolean
    fun split(cards: ArrayList<Card>, numberOfDecks: Int) : Boolean
    fun getMaximumNumberOfDecks() : Int
}

