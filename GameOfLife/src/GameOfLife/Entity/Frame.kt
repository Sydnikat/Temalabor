package GameOfLife.Entity

import GameOfLife.Observer.GameObserver
import GameOfLife.Type.GameState
import GameOfLife.Type.StateType
import java.util.*
import kotlin.collections.ArrayList

class Frame (val height: Int,
             val width: Int,
             private val timeBetweenGens: Long = 250,
             fillWithRandom: Boolean = true,
             chance: Int = 4) : Runnable, GameObserver {

    val cells = ArrayList<ArrayList<Cell>>()

    private var state = GameState.PAUSED
    private var generationCounter = 0
    private var livingCount = 0

    init{
        (0 until height).forEach { _ ->
            cells.add(ArrayList())
        }

        val random = Random()
        val chanceGen = if(chance < 2) 2 else chance

        cells.forEach {
            (0 until width).forEach { _ ->
                it.add(Cell( if(fillWithRandom && random.nextInt() % chanceGen == 0) StateType.ALIVE else StateType.DEAD ))
            }
        }

        (0 until height).forEach { i ->
            for(j in 0 until width){

                val upperRow = if(i - 1 < 0) height - 1 else i - 1
                val lowerRow = if(i + 1 == height) 0 else i + 1
                val upperColumn = if(j - 1 < 0) width - 1 else j - 1
                val lowerColumn = if(j + 1 == width) 0 else j + 1

                cells[i][j].neighbors.addAll(arrayListOf(
                        cells[upperRow][upperColumn],
                        cells[upperRow][j],
                        cells[upperRow][lowerColumn],
                        cells[i]       [upperColumn],
                        cells[i]       [lowerColumn],
                        cells[lowerRow][upperColumn],
                        cells[lowerRow][j],
                        cells[lowerRow][lowerColumn]
                ))
            }
        }
    }

    override fun noticeStop() {
        state = GameState.STOP
    }

    override fun noticeContinue() {
        state = GameState.RUNNING
    }

    override fun noticePause() {
        state = GameState.PAUSED
    }


    override fun run() {

        state = GameState.RUNNING

        generationCounter = 0

        while (state != GameState.STOP){

            while (state == GameState.RUNNING)
                    createNextGen()

            Thread.sleep(1000)
        }
    }

    fun createNextGen(){

        markToDie()
        cellsBirth()
        cellsDie()

        generationCounter++

        printResult()
        if(state == GameState.RUNNING)
            Thread.sleep(timeBetweenGens)

    }

    private fun markToDie() {
        cells.forEach { i ->
            i.forEach {
                it.checkState()
            }
        }
    }

    private fun cellsDie() {
        livingCount = 0
        cells.forEach { i ->
            i.forEach {
                it.die()
                if(it.state == StateType.ALIVE) livingCount++
            }
        }
    }

    private fun cellsBirth() {
        cells.forEach { i ->
            i.forEach {
                it.birth()
            }
        }
    }

    fun printResult(){

        ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor()

        println("Generation: $generationCounter\tNumber of living cells: $livingCount\n")

        cells.forEach { i ->
            i.forEach { it ->
                if(it.state == StateType.ALIVE) print('#')
                else print(' ')
            }
            println()
        }

    }
}