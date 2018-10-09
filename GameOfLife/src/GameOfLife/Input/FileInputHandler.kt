package GameOfLife.Input

import GameOfLife.Entity.Frame
import GameOfLife.Type.StateType
import java.io.File

object FileInputHandler {

    fun createFrameFromFile(fileName: String?, relative: Boolean = true) : Frame{

        val lines = if(relative) File("testMaps/$fileName.txt").readLines()
                    else File(fileName).readLines()

        val firstLine = lines[0].split(" ")

        if(firstLine.count() != 3)
            throw Exception("Nem megfelelő a fájl tartalma! A mátrix megadása helytelen!")

        if(lines.count() - 1 != firstLine[0].toInt())
            throw Exception("Nem megfelelő a fájl tartalma! A mátrix megadása helytelen!")

        (1 until lines.count()).forEach {
            if( lines[it].count() != firstLine[1].toInt())
                throw Exception("Nem megfelelő a fájl tartalma! A mátrix megadása helytelen!")
        }

        val aliveCellType = firstLine[2]

        val frame = Frame(height = firstLine[0].toInt(), width = firstLine[1].toInt(), fillWithRandom = false)

        (0 until frame.height).forEach { i ->
            (0 until frame.width).forEach { j ->
                frame.cells[i][j].state = if(lines[i + 1][j] == aliveCellType[0]) StateType.ALIVE else StateType.DEAD
            }
        }

        return frame
    }

    fun listMaps() { File("testMaps/").list().forEach { println(it) } }
}