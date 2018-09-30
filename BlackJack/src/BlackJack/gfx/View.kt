package BlackJack.gfx

import BlackJack.Entity.Bank
import BlackJack.Entity.Player


abstract class ClassicView : Updatable

class ClassicTableView(private val player: Player, private val bank: Bank) : ClassicView() {

    private val playerView = ClassicPlayerView(player)

    private val bankView = ClassicBankView(bank)

    override fun update() {

        bankView.update()

        println("\n")

        playerView.update()

    }
}

class ClassicPlayerView(private val player: Player) : ClassicView() {

    override fun update() {

        (0 until player.numberOfUsedDecks).forEach { i ->

            player.changeDeck(i)

            val deck = player.showDeck()

            print((i + 1).toString() + ": " + deck.money.toString() + " ")

            deck.cards.forEach { print(UnicodeMaker.cardToUnicode(it)) }

            print("\t")

        }

        println(player.showMoney())

    }
}

class ClassicBankView(private val bank: Bank) : ClassicView() {

    var prevCardNumber = bank.showDeck().cards.count()

    override fun update() {

        val deck =  bank.showDeck()

        //if( prevCardNumber > 2 && prevCardNumber != deck.cards.count() ) Thread.sleep(2000)

        bank.showDeck().cards.forEach { print(UnicodeMaker.cardToUnicode(it)) }

        prevCardNumber = deck.cards.count()


    }
}

