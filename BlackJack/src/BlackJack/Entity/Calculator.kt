package BlackJack.Entity

import BlackJack.Type.CardTypes

object Calculator {

    fun evaluate(cards: ArrayList<Card>) : Int{

        var sum = 0
        cards.forEach { sum += it.value.number() }

        if(cards.any { it.value == CardTypes.ACE }) {

            var numberOfAces = cards.count { it.value == CardTypes.ACE }

            while(sum > 21 && numberOfAces > 0) {
                sum -= 10
                numberOfAces--
            }
        }
        return sum
    }
}