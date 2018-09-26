package BlackJack.Behavior

import BlackJack.Entity.Card

interface Behavior {
    fun hit(cards: ArrayList<Card>) : Boolean
    fun stand(cards: ArrayList<Card>) : Boolean
    fun double(cards: ArrayList<Card>) : Boolean
    fun split(cards: ArrayList<Card>, numberOfDecks: Int) : Boolean
}

