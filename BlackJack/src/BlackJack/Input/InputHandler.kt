package BlackJack.Input

import BlackJack.Type.ActionType

interface InputHandler{
    fun readKey() : ActionType
    fun readNumber() : Double?
}

class ConsoleInputHandler : InputHandler{

    override fun readNumber(): Double? {

        val line = readLine()
        var isNumber = true

        if(line == null || line == "") return null

        val numberOfDots = line.count { it == '.' }

        line.forEach {
            when {
                it == '.' && numberOfDots > 1 -> isNumber = false
                it == '.' && numberOfDots <= 1 -> isNumber = true
                !it.isDigit() -> isNumber = false
            }
        }

        if(isNumber){
            return line.toDouble()
        }

        return null
    }

    override fun readKey(): ActionType =


        when (readLine()){
            "s" ->  ActionType.SPLIT
            "d" -> ActionType.DOUBLE
            "q" -> ActionType.END
            "h" -> ActionType.HIT
            "e" -> ActionType.STAND
            "n", "i" -> ActionType.NEW
            else -> ActionType.ERROR
    }

}

class NoInputHandler : InputHandler{

    override fun readNumber(): Double? = null

    override fun readKey(): ActionType = ActionType.ERROR

}