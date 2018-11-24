package BlackJack.entity

import BlackJack.behavior.ClassicBank
import BlackJack.behavior.ClassicPlayer
import BlackJack.input.InputHandler
import BlackJack.observer.DealerObserver
import BlackJack.observer.PlayerObserver
import BlackJack.type.ActionType
import BlackJack.type.GameState
import BlackJack.type.ResultType
import BlackJack.gfx.ClassicTableView
import java.lang.Math.abs

class Table(numberOfDecks: Int, private val inputHandler: InputHandler, testing: Boolean = false) : DealerObserver, PlayerObserver {

    val dealer = if(!testing) Dealer(numberOfDecks, this) else TesterDealer(numberOfDecks, this)

    private val player = Player(0.0, dealer, ClassicPlayer(), inputHandler, this)

    private val bank = Bank(0.0, dealer, ClassicBank(), this)

    private var state = GameState.NEW

    private var isLowDeck = false

    private val tableView = ClassicTableView(player, bank)

    var winCount = 0
    private set
    var loseCount = 0
    private set


    fun startGame(){

        println("\nKöszöntjük a BlackJack asztalnál! Ne feledje, a bank mindig nyer :)\n")

        while (state != GameState.QUIT){

            when(state){

                GameState.RUNNING -> play()
                GameState.NEW -> settings()
                GameState.END -> showStatistics()
                GameState.QUIT -> {}
            }

        }
        println("Köszönjük, hogy a mi BlackJack alkalmazásunkat választotta! \nBye-bye! Have a good day!")
    }

    private  fun settings(){

        println("Adja meg az összeget, amivel játszani szeretne!")

        var newAmount = inputHandler.readNumber()

        while (newAmount == null) {
            println("Hibás bemenet!")
            newAmount = inputHandler.readNumber()
        }

        player.setBasicMoney(newAmount)

        winCount = 0
        loseCount = 0

        println("n - Start  q - Kilépés")
        var valid = false
        while(!valid){

            when(inputHandler.readKey()){

                ActionType.NEW -> {
                    state = GameState.RUNNING
                    valid = true
                }
                ActionType.END -> {
                    state = GameState.QUIT
                    valid = true
                }
                else -> valid = false
            }
        }
    }

    private fun showStatistics(){

        val coins = if(bank.showMoney() == 0.0) bank.showMoney() * -1 else bank.showMoney() * -1


        println("\nEredmények: \n" +
                "\tÖn enniyszer nyert: " + winCount.toString() + "\n" +
                "\tÖn enniyszer vesztett: " + loseCount.toString() + "\n" +
                "\tAz Ön nyeresége " + coins.toString() + " zseton.\n")

        println("n - Új játék  q - kilépés")

        var valid = false
        while(!valid){

            when(inputHandler.readKey()){

                ActionType.NEW -> {
                    state = GameState.NEW
                    valid = true
                }
                ActionType.END -> {
                    state = GameState.QUIT
                    valid = true
                }
                else -> valid = false
            }
        }

    }

    private fun play(){

        if(isLowDeck){

            dealer.createNewDeck()
            isLowDeck = false

        }

        player.preparation()
        bank.preparation()

        player.raise()

        player.receiveFirstCards()
        bank.receiveFirstCards()


        player.play()

        if( state != GameState.RUNNING ) return

        bank.play()

        calculateResult()

    }

    private fun calculateResult() {

        var playerOdds: Double
        var bankOdds: Double

        (0 until player.numberOfUsedDecks).forEach {

            player.changeDeck(it)

            val result = Calculator.calculateResult(player.showDeck(), bank.showDeck())
            val playerMoney = player.showDeck().money

            when(result){
                ResultType.WIN -> {
                    print("Ön nyert!")
                    playerOdds = 2.0
                    bankOdds = -1.0
                    winCount++
                }
                ResultType.WINBYJACK -> {
                    print("BlackJack! Ön nyert! ")
                    playerOdds = 2.5
                    bankOdds = -1.5
                    winCount++
                }
                ResultType.TIE -> {
                    print("Döntetlen! ")
                    playerOdds = 1.0
                    bankOdds = 1.0
                }
                ResultType.LOSE -> {
                    print("Ön vesztett! ")
                    playerOdds = 0.0
                    bankOdds = 1.0
                    loseCount++
                }
                ResultType.LOSEBYJACK -> {
                    print("Ön vesztett! ")
                    playerOdds = -0.5
                    bankOdds = 1.5
                    loseCount++
                }
            }

            if(player.showMoney() >= abs(playerMoney * playerOdds))
                player.takeMoney(playerMoney * playerOdds)
            else
                player.takeMoney(player.showMoney() * -1)


            bank.takeMoney(playerMoney * bankOdds)
        }

        println("\nJelenlegi összeg: " + player.showMoney())

        var canPlay = true
        if(player.showMoney() <= 0.0)
            canPlay = false

        println("Folytatja? i - Igen    q - Nem ")

        var valid = false
        while(!valid){

            when(inputHandler.readKey()){

                ActionType.NEW -> {

                    if(canPlay) {
                        state = GameState.RUNNING
                        valid = true
                    }
                }
                ActionType.END -> {
                    state = GameState.END
                    valid = true
                }
                else -> valid = false
            }
        }

    }

    fun getPlayerMoney() = player.showMoney()

    override fun noticeUpdate() { tableView.update() }

    override fun noticeNewGame() {state = GameState.NEW }

    override fun noticeEndGame() { state = GameState.END }

    override fun noticeLowDeck() { isLowDeck = true }
}