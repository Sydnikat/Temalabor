package gameOfLife.entity

import gameOfLife.type.ChangeType
import gameOfLife.type.StateType

class Cell(var state: StateType){

    private var change = ChangeType.NOTHING

    fun checkState() {
        val livingNeighbors = neighbors.count { it.state == StateType.ALIVE }

        change = when {
            livingNeighbors > 3 || livingNeighbors < 2 -> {
                if(state == StateType.ALIVE) ChangeType.DIE
                else ChangeType.NOTHING
            }
            else -> {
                if(state == StateType.DEAD && livingNeighbors == 3) ChangeType.BIRTH
                else ChangeType.NOTHING
            }
        }

    }

    fun die() {
        if(change == ChangeType.DIE)
            state = StateType.DEAD
    }

    fun birth() {
        if(change == ChangeType.BIRTH)
            state = StateType.ALIVE
    }

    val neighbors = ArrayList<Cell>()
}