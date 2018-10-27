package BlackJack.entity

import BlackJack.type.CardType
import BlackJack.type.ResultType

object Calculator {

    fun evaluate(cards: ArrayList<Card>) : Int{

        var sum = 0
        cards.forEach { sum += it.value.number() }

        if(cards.any { it.value == CardType.ACE }) {

            var numberOfAces = cards.count { it.value == CardType.ACE }

            while(sum > 21 && numberOfAces > 0) {
                sum -= 10
                numberOfAces--
            }
        }
        return sum
    }

    fun calculateResult(player: Deck, bank: Deck) : ResultType {

        val playerValue = evaluate(player.cards)
        val bankValue = evaluate(bank.cards)

        if (playerValue == 21 && player.cards.count() == 2)
            if (player.cards.any { it.value == CardType.JACK } && player.cards.any { it.value == CardType.TEN }) return ResultType.WINBYJACK

        if (bankValue == 21 && bank.cards.count() == 2)
            if (bank.cards.any { it.value == CardType.JACK } && bank.cards.any { it.value == CardType.TEN }) return ResultType.LOSEBYJACK


        when {
            playerValue > 21 -> return ResultType.LOSE
            playerValue == 21 -> {
                return if (bankValue == 21) ResultType.TIE
                else ResultType.WIN
            }
            else -> return when {
                bankValue == 21 -> ResultType.LOSE
                bankValue > 21 -> ResultType.WIN
                else -> {
                    when {
                        bankValue < playerValue -> ResultType.WIN
                        bankValue == playerValue -> ResultType.TIE
                        else -> ResultType.LOSE
                    }
                }
            }
        }
    }


}