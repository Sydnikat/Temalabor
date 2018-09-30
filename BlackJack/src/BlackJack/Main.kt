package BlackJack

import BlackJack.Entity.Table
import BlackJack.Input.ConsoleInputHandler

fun main(args: Array<String>) {

    Table(numberOfDecks =  8, inputHandler = ConsoleInputHandler()).startGame()

}