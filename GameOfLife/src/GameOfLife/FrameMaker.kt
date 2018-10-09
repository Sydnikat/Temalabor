package GameOfLife

import GameOfLife.Entity.Frame
import GameOfLife.Input.FileInputHandler
import GameOfLife.Input.InputReader

object FrameMaker {

    fun createFrame(): Frame {

        println("Fájlból akarod betölteni? I - igen\t N - nem")

        return if(readLine() == "i" ) loadFromFile()
        else createIndividual()

    }

    private fun createIndividual(): Frame {

        println("\nE - Egyéni beállítások\t A - Általános")

        return if(readLine() == "a")
                    Frame(  height = getValue("Kérem adja meg a váz magasságát (egész érték):"),
                            width = getValue("Kérem adja meg a váz szélességét (egész érték):"))

               else Frame(  height = getValue("Kérem adja meg a váz magasságát (egész érték):"),
                            width = getValue("Kérem adja meg a váz szélességét (egész érték):"),
                            timeBetweenGens = setGenTime("Kérem adja meg, hogy milyen gyorsan jöjjön létre az új generáció (milisec-ben)!"),
                            chance = setLivingChance("Kérem adja meg, hogy kb. minden hányadik sejt éljen (az érték egész és legalább 2 legyen)"))



    }

    private fun setLivingChance(message: String): Int = getValue(message)

    private fun setGenTime(message: String): Long = getValue(message).toLong()

    private fun getValue(message: String): Int {

        var value: Int? = 0
        var correct = false

        while (!correct){

            print("\n$message\t")

            value = InputReader.readNumber()

            if(value != null) {
                correct = true
            }
            else{
                println("Típushiba! Kérem adjon meg egy egész értéket!")
            }
        }

        return value!!

    }

    private fun loadFromFile(): Frame {

        println("\nA tesztpályák közül szeretné betölteni? I - igen\t N - nem")
        println("*megjegyzés: Amennyiben parancsorból futtatja csak akkor válassza a tesztpályákat, ha a játék könyvtárából futtatja!*")

        return if(readLine() == "i"){

            FileInputHandler.listMaps()
            println("Kérem adja meg a teszpálya nevét (csak a nevet)!")

            FileInputHandler.createFrameFromFile(readLine())

        }else{

            println("Kérem adja meg a fájl abszolút elérési útját!")
            FileInputHandler.createFrameFromFile(readLine(), relative = false)
        }

    }
}