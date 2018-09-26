package BlackJack.Input

import BlackJack.Type.ActionType

interface InputHandler{
    fun readKey() : ActionType
}

class ConsoleInputHandler : InputHandler{

    override fun readKey(): ActionType =


        when (System.`in`.read().toChar()){
            's' ->  ActionType.SPLIT
            'd' -> ActionType.DOUBLE
            'q' -> ActionType.END
            'h' -> ActionType.HIT
            'e' -> ActionType.STAND
            'n' -> ActionType.NEW
            else -> ActionType.ERROR
    }

}