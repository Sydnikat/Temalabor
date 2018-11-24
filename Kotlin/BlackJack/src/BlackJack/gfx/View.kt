package BlackJack.gfx

import BlackJack.entity.Bank
import BlackJack.entity.Player


abstract class ClassicView : Updatable

class ClassicTableView(player: Player, bank: Bank) : ClassicView() {

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

    override fun update() {

        val deck =  bank.showDeck()

        deck.cards.forEach { print(UnicodeMaker.cardToUnicode(it)) }
    }
}

