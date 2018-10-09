package GameOfLife.Input

object InputReader {

    fun readNumber(): Int? {

        val line = readLine()
        var isNumber = true

        if(line == null || line == "") return null

        line.forEach {
                if(!it.isDigit())  isNumber = false
        }

        if(isNumber){
            return line.toInt()
        }

        return null
    }

}