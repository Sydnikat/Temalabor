package BlackJack.Entity

import BlackJack.Color.CardColor
import BlackJack.Observer.DealerObserver
import BlackJack.Type.CardTypes
import kotlin.collections.ArrayList


class Dealer(val numberOfDecksUsed: Int, val observer: DealerObserver) {

    private val maxCardNumber = 52 * numberOfDecksUsed
    private var deckPool: ArrayList<Card> = createDeck()

    init{
        deckPool.shuffle()
    }

    private fun createDeck() =
         arrayListOf<Card>().apply {
            for (i in 0 until numberOfDecksUsed) {
                for(color in CardColor.values())
                {
                    for(value in CardTypes.values()){
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