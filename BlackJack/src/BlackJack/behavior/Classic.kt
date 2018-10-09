package BlackJack.behavior

import BlackJack.entity.Calculator
import BlackJack.entity.Card

abstract class Classic : Behavior{

    override fun getMaximumNumberOfDecks(): Int = 1

    override fun hit(cards: ArrayList<Card>): Boolean = true

    override fun double(cards: ArrayList<Card>): Boolean = true

    override fun split(cards: ArrayList<Card>, numberOfDecks: Int): Boolean = true

}

class ClassicPlayer : Classic() {

    override fun getMaximumNumberOfDecks(): Int = 3

    override fun hit(cards: ArrayList<Card>): Boolean = Calculator.evaluate(cards) <= 21

    override fun split(cards: ArrayList<Card>, numberOfDecks: Int): Boolean {

        println(cards.count())

        return when {
            numberOfDecks == 3 -> false
            cards.count() != 2 -> false
            cards[0].value != cards[1].value -> false
            else -> true
        }

    }

}

class ClassicBank : Classic(){

    override fun hit(cards: ArrayList<Card>): Boolean = Calculator.evaluate(cards) <= 16

    override fun double(cards: ArrayList<Card>): Boolean = false

    override fun split(cards: ArrayList<Card>, numberOfDecks: Int): Boolean = false


}
