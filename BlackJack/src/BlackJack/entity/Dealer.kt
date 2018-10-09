package BlackJack.entity

import BlackJack.color.CardColor
import BlackJack.observer.DealerObserver
import BlackJack.type.CardType
import kotlin.collections.ArrayList


open class Dealer(val numberOfDecksUsed: Int, val observer: DealerObserver) {

    private val maxCardNumber = 52 * numberOfDecksUsed
    protected var deckPool: ArrayList<Card> = createDeck()

    init{
        deckPool.shuffle()
    }

    private fun createDeck() =
         arrayListOf<Card>().apply {
            for (i in 0 until numberOfDecksUsed) {
                for(color in CardColor.values())
                {
                    for(value in CardType.values()){
                        this.add(Card(value, color))
                    }
                }
            }
        }

    fun createNewDeck() { deckPool = createDeck() }

    fun giveCard() : Card {

        if(deckPool.count() < maxCardNumber / 2) observer.noticeLowDeck()

        return deckPool.removeAt(0)
    }

}

class TesterDealer(numberOfDecksUsed: Int, observer: DealerObserver)
    : Dealer(numberOfDecksUsed, observer){

      fun createNewDeck(cards: ArrayList<Card>) { deckPool = cards }
}