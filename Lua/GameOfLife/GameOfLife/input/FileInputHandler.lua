
--Frame = require "entity.Frame"

--getmetatable('').__index = function(str,i) return string.sub(str,i,i) end --> Elkérem a string metatable-jét és felülírom az index operátort, így tudok string-et indexelni lua-ban
--getmetatable('').__len = function(str) return string.len(str) end --> Elkérem a srting metatable-jét és felülírom a hossz operátorját, így egyszerűbben meg tudom mondani a hosszát (mint egy tábla számossága)

local FileInputHandler = {}


function FileInputHandler:getInstance()

    local instance = {}

    local createFrameFromFile = function(fileName, relative)

        instance.fileName = fileName
        instance.relative = relative or true
        instance.lines = {}

        if(instance.file_exists() == false) then return {} end

        instance.lines = instance.getLines()


        local firstLine = instance.split(instance.lines[1], " ")

        local error = assert( #firstLine == 3, "Nem megfelelő a fájl tartalma! A mátrix megadása helytelen!")
        if(type(error) == string)
        then
            print(error)
            return {}
        end

        error = assert( #instance.lines - 1 == tonumber(firstLine[1]), "Nem megfelelő a fájl tartalma! A mátrix megadása helytelen!")
        if(type(error) == string)
        then
            print(error)
            return {}
        end

        for i = 2, #instance.lines, 1
        do
            error = assert(#instance.lines[i] == tonumber(firstLine[2]), "Nem megfelelő a fájl tartalma! A mátrix megadása helytelen!")
            if(type(error) == string)
            then
                print(error)
                return {}
            end
        end

        local aliveCellType = firstLine[3]

        local frame = Frame(tonumber(firstLine[1]), tonumber(firstLine[2]))

        for i = 1, frame.height, 1
        do
            for j = 1, frame.width, 1
            do
                local state = StateType.DEAD

                if(string.sub(instance.lines[i + 1],j,j) == aliveCellType)
                --if(instance.lines[i + 1][j] == aliveCellType)
                then
                    state = StateType.ALIVE
                end

                frame.cells[i][j].state = state
            end
        end

        return frame
    end

    instance.split = function(s, delimiter)
        local result = {};
        for match in (s..delimiter):gmatch("(.-)"..delimiter) do
            table.insert(result, match);
        end
        return result;
    end

    instance.getLines = function()

        if(instance.relative)
        then
            instance.fileName = "testMaps/".. instance.fileName ..".txt"
        end

        local lines = {}
        for line in io.lines(instance.fileName)
        do
            lines[#lines + 1] = line
        end

        return lines
    end

    instance.file_exists = function()
        local result
        if(instance.relative)
        then
            result = assert(io.open("testMaps/".. instance.fileName ..".txt", "r"), "Nem találja a fájl")
        else
            result = assert(io.open(instance.fileName , "r"), "Nem találja a fájl")
        end

        if( type(result) == string)
        then
            print(result)
            return false
        else
            result:close()
            return true
        end
    end


    return {
        createFrameFromFile = createFrameFromFile
    }

end

return FileInputHandler