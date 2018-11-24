package BlackJack.entity


import BlackJack.behavior.Behavior
import BlackJack.input.InputHandler
import BlackJack.input.NoInputHandler
import BlackJack.observer.PlayerObserver
import BlackJack.type.ActionType


abstract class Participant(
        protected var amountOfMoney: Double,
        val dealer: Dealer,
        val behavior: Behavior,
        val inputHandler: InputHandler,
        val observer: PlayerObserver) {

    abstract fun play()
    abstract fun receiveFirstCards()
    abstract fun showDeck() : Deck
    fun takeMoney(money: Double) { amountOfMoney += money }
    fun setBasicMoney(newAmount: Double) { amountOfMoney = newAmount }
    fun showMoney() : Double = amountOfMoney
    abstract fun preparation()
}

class Player(
        basicAmountOfMoney: Double,
        dealer: Dealer,
        behavior: Behavior,
        inputHandler: InputHandler,
        observer: PlayerObserver)
    : Participant(basicAmountOfMoney, dealer, behavior, inputHandler, observer){

    private var decks = ArrayList<Deck>()

    private var currentDeckIndex = 0

    var numberOfUsedDecks = 1
    private set

    init{

        (1..behavior.getMaximumNumberOfDecks()).forEach { _ -> decks.add(Deck(ArrayList(), 0.0)) }

    }

    override fun preparation() {

        (0 until decks.count()).forEach {
            decks[it].cards.clear()
            decks[it].money = 0.0
        }
        currentDeckIndex = 0
        numberOfUsedDecks = 1
    }

    override fun play() {

        var forceStop = false
        var i = 0

        while (i < decks.count() && !forceStop){

            val it = decks[i++]

            if(it.cards.isNotEmpty()){

                observer.noticeUpdate()

                var done = false
                while (!done) {

                    when (inputHandler.readKey()) {

                        ActionType.HIT -> hit(it)
                        ActionType.STAND -> done = true
                        ActionType.DOUBLE -> double(it)
                        ActionType.SPLIT -> split(it)
                        ActionType.END -> {
                            observer.noticeEndGame()
                            done = true
                            forceStop = true
                        }
                        ActionType.NEW ->{
                            observer.noticeNewGame()
                            done = true
                            forceStop = true
                        }
                        ActionType.ERROR -> {}
                    }
                }
            }
        }

    }

    fun hit(deck: Deck) {
        if(behavior.hit(deck.cards)){

            deck.cards.add(dealer.giveCard())

            observer.noticeUpdate()
        }

    }


    fun split(deck: Deck) {
        if(behavior.split(deck.cards, numberOfUsedDecks)){

            numberOfUsedDecks++

            val card = deck.cards.removeAt(0)

            var idx = 0
            for(d in decks){
                if(d.cards.isEmpty()){
                    idx = decks.indexOf(d)
                    break
                }
            }

            decks[idx].cards.add(card)
            decks[idx].money = deck.money / 2
            deck.money /= 2

            observer.noticeUpdate()
        }
    }

    fun changeDeck(index: Int) {

        if(index >= 0 && index < behavior.getMaximumNumberOfDecks()){

            currentDeckIndex = index

        }
    }

    fun double(deck: Deck) {
        if(behavior.double(deck.cards)){

            val currentMoney = deck.money

            if(amountOfMoney >= currentMoney) {

                amountOfMoney -= currentMoney
                deck.money *= 2
            }
            else if(amountOfMoney > 0.0){

                deck.money += amountOfMoney
                amountOfMoney = 0.0
            }

            observer.noticeUpdate()
        }
    }

    fun raise(){

        var valid = false

        println("\nKérem emeljen!")

        while (!valid){

            val newAmount = inputHandler.readNumber()

            if(newAmount != null){

                if(newAmount <= amountOfMoney){

                    decks[0].money = newAmount
                    amountOfMoney -= newAmount
                    valid = true
                }
            }
        }
        print("\n\n")
    }

    override fun receiveFirstCards() {

        decks[0].cards.addAll(arrayListOf(dealer.giveCard(), dealer.giveCard()))

    }

    override fun showDeck(): Deck = decks[currentDeckIndex]



}

class Bank (
        basicAmountOfMoney: Double,
        dealer: Dealer,
        behavior: Behavior,
        inputHandler: InputHandler,
        observer: PlayerObserver)
    : Participant(basicAmountOfMoney, dealer, behavior, inputHandler, observer){

    constructor( basicAmountOfMoney: Double,
                 dealer: Dealer,
                 behavior: Behavior,
                 observer: PlayerObserver)
            : this(basicAmountOfMoney, dealer, behavior, NoInputHandler(), observer)

    private var deck = Deck(ArrayList(), 0.0)

    override fun play() {

        deck.cards.forEach { it.hidden = false }

        while (behavior.hit(deck.cards)){

            deck.cards.add(dealer.giveCard())

        }

        observer.noticeUpdate()
    }

    override fun preparation() {

        deck.cards.clear()

    }

    override fun receiveFirstCards() {

        deck.cards.add(dealer.giveCard())

        val card = dealer.giveCard()
        card.hidden = true
        deck.cards.add(card)

    }

    override fun showDeck(): Deck = deck

}