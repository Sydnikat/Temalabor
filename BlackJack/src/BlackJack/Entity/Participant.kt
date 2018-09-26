package BlackJack.Entity


import BlackJack.Deportment.ClassicBank
import BlackJack.Deportment.ClassicPlayer


abstract class Participant(
        var amountOfMoney: Double,
        val dealer: Dealer) {

    abstract fun hit()
    abstract fun stand()
    abstract fun split()
    abstract fun double()
    abstract fun receiveFirstCards()
    abstract fun showCards() : ArrayList<Card>
    fun takeMoney(money: Double) { amountOfMoney += money }
    abstract fun preparation()
}

class Player(
        basicAmountOfMoney: Double,
        dealer: Dealer,
        private val behavior: ClassicPlayer)
    : Participant(basicAmountOfMoney, dealer){


    private var decks = ArrayList<Deck>()

    var currentDeckIndex = 0
    private  set

    private var numberOfUsedDecks = 1

    init{

        (1..behavior.maximumNumberOfDecks).forEach { _ -> decks.add(Deck(ArrayList(), 0.0)) }

    }

    override fun preparation() {

        (0 until decks.count()).forEach {
            decks[it].cards.clear()
            decks[it].money = 0.0
        }
        currentDeckIndex = 0
    }


    override fun hit() {
        if(behavior.hit(decks[currentDeckIndex].cards)){

            decks[currentDeckIndex].cards.add(dealer.giveCard())

        }

    }

    override fun stand() {
        if(behavior.stand(decks[currentDeckIndex].cards)){

            //TODO PlayerObserver.noticeStand()

        }

    }

    override fun split() {
        if(behavior.split(decks[currentDeckIndex].cards, numberOfUsedDecks)){

            numberOfUsedDecks++
            //TODO PlayerObserver.noticeSplit()

            val card = decks[currentDeckIndex].cards.removeAt(0)

            decks[currentDeckIndex + 1].cards.add(card)
            decks[currentDeckIndex + 1].money = decks[currentDeckIndex].money / 2
            decks[currentDeckIndex].money /= 2

        }
    }

    fun changeDeck(index: Int) {

        if(index >= 0 && index < behavior.maximumNumberOfDecks){

            currentDeckIndex = index

        }
    }

    override fun double() {
        if(behavior.double(decks[currentDeckIndex].cards)){

            val currentMoney = decks[currentDeckIndex].money
            amountOfMoney -= currentMoney
            decks[currentDeckIndex].money *= 2
        }

    }

    override fun receiveFirstCards() {

        decks[0].cards.addAll(arrayListOf(dealer.giveCard(), dealer.giveCard()))

    }

    override fun showCards(): ArrayList<Card> = decks[currentDeckIndex].cards



}

class Bank (basicAmountOfMoney: Double, dealer: Dealer, behavior: ClassicBank)
    : Participant(basicAmountOfMoney, dealer){
    override fun preparation() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun hit() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun stand() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun split() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun double() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun receiveFirstCards() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun showCards(): ArrayList<Card> {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

}

fun main(args: Array<String>) {

    val p = Player(100.0, Dealer(3, Table()), ClassicPlayer())
    p.split()
}