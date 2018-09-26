package BlackJack.Behavior

import BlackJack.Entity.Calculator
import BlackJack.Entity.Card

open class Classic : Behavior{

    override fun hit(cards: ArrayList<Card>): Boolean = true

    override fun stand(cards: ArrayList<Card>): Boolean = true

    override fun double(cards: ArrayList<Card>): Boolean = true

    override fun split(cards: ArrayList<Card>, numberOfDecks: Int): Boolean = true

}

class ClassicPlayer : Classic() {

    val maximumNumberOfDecks = 3

    override fun hit(cards: ArrayList<Card>): Boolean = Calculator.evaluate(cards) <= 21

    override fun split(cards: ArrayList<Card>, numberOfDecks: Int): Boolean {

        if(numberOfDecks == 3)
            return false

        if(cards.count() != 2)
            return false

        if(cards[0].value != cards[1].value)
            return false

        return true
    }

}

class ClassicBank : Classic(){

    override fun hit(cards: ArrayList<Card>): Boolean = Calculator.evaluate(cards) <= 16

    override fun double(cards: ArrayList<Card>): Boolean = false

    override fun split(cards: ArrayList<Card>, numberOfDecks: Int): Boolean = false


}
