
Cell = require "entity.Cell"
StateType = require "type.StateType"
GameSate = require "type.GameState"

local Frame = {
    state = GameSate.PAUSED,
    generationCounter = 0,
    cells  = {}
}
Frame.__index = Frame

setmetatable(Frame, {
    __call = function(class, ...)
        return class.CreateFrame(...)
    end
})

function Frame.CreateFrame(height, width, timeBetweenGens, chance)
    local self = setmetatable({}, Frame)
    self.height = height or 20
    self.width = width or 20
    self.timeBetweenGens = timeBetweenGens or 400.0
    self.chance =  chance or 4

    self:init()

    return self
end

function Frame:init()

    for i = 1, self.height, 1
    do
        table.insert(self.cells, {})
    end

    local chanceGen = self.chance
    if(2 > chanceGen)
    then
        chanceGen = 4
    end

    math.randomseed(os.time())
    for i = 1, self.height, 1
    do

        for j = 1, self.width, 1
        do
            local isAlive = (math.random(100000) % chanceGen) == 0

            local cellState = StateType.ALIVE

            if(isAlive == false)
            then
                cellState = StateType.DEAD
            end

            table.insert(self.cells[i], Cell(cellState))
        end
    end

    self:createNeighbors()

end

function Frame:createNeighbors()
    for i = 1, self.height, 1
    do
        for j = 1, self.width, 1
        do

            local upperRow
            local lowerRow
            local upperColumn
            local lowerColumn
            if(i - 1 == 0) then upperRow = self.height else upperRow = i - 1 end
            if(i + 1 == self.height + 1) then lowerRow = 1 else lowerRow = i + 1 end
            if(j - 1 == 0) then upperColumn = self.width else upperColumn = j - 1 end
            if(j + 1 == self.width + 1) then lowerColumn = 1 else lowerColumn = j + 1 end

            self.cells[i][j].neighbors[#self.cells[i][j].neighbors + 1] = self.cells[upperRow][upperColumn]
            self.cells[i][j].neighbors[#self.cells[i][j].neighbors + 1] = self.cells[upperRow][j]
            self.cells[i][j].neighbors[#self.cells[i][j].neighbors + 1] = self.cells[upperRow][lowerColumn]
            self.cells[i][j].neighbors[#self.cells[i][j].neighbors + 1] = self.cells[i]       [upperColumn]
            self.cells[i][j].neighbors[#self.cells[i][j].neighbors + 1] = self.cells[i]       [lowerColumn]
            self.cells[i][j].neighbors[#self.cells[i][j].neighbors + 1] = self.cells[lowerRow][upperColumn]
            self.cells[i][j].neighbors[#self.cells[i][j].neighbors + 1] = self.cells[lowerRow][j]
            self.cells[i][j].neighbors[#self.cells[i][j].neighbors + 1] = self.cells[lowerRow][lowerColumn]

        end
    end
end

function Frame:createNextGen()

    self:markToDie()
    self:cellsBirth()
    self:cellsDie()

    self.generationCounter = self.generationCounter + 1

    self:printResult()

    if(self.state == GameSate.RUNNING)
    then
        self.wait(timeBetweenGens / 1000)
    end
end

function Frame:getLivingCount()
    local livingCount = 0
    for i = 1, self.height, 1
    do
        for j = 1, self.width, 1
        do
            if(self.cells[i][j].state == StateType.ALIVE)
            then
                livingCount = livingCount + 1
            end
        end
    end
    return livingCount

end

function Frame:markToDie()
    for i = 1, self.height, 1
    do
        for j = 1, self.width, 1
        do
            self.cells[i][j]:checkState()
        end
    end

end

function Frame:cellsDie()
    for i = 1, self.height, 1
    do
        for j = 1, self.width, 1
        do
            self.cells[i][j]:die()
        end
    end
end

function Frame:cellsBirth()
    for i = 1, self.height, 1
    do
        for j = 1, self.width, 1
        do
            self.cells[i][j]:birth()
        end
    end
end

function Frame:printResult()
    --os.execute("cls")
    print("Generation:".. self.generationCounter .."\tNumber of living cells: ".. self:getLivingCount() .."\n")
    for i = 1, self.height, 1
    do
        io.flush()
        for j = 1, self.width, 1
        do
            if(self.cells[i][j].state == StateType.ALIVE)
            then
                io.write("#")
            else
                io.write(".")
            end
        end
        print()
    end

    print()

end


function Frame:wait(seconds)
    local time = os.clock()
    while os.clock()-time < seconds
    do
    end
end

return Frame
