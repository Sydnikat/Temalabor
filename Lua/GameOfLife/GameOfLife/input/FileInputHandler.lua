
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

        local error = assert( #firstLine == 3, "The context of the file is incorrect! PLease make sure to give a correct matrix definition!")
        if(type(error) == string) then
            print(error)
        end

        error = assert( #instance.lines - 1 == tonumber(firstLine[1]), "The context of the file is incorrect! PLease make sure that the number of rows is correct!")
        if(type(error) == string) then
            print(error)
        end

        for i = 2, #instance.lines, 1 do
            error = assert(#instance.lines[i] == tonumber(firstLine[2]), "The context of the file is incorrect! PLease make sure that the number of columns is correct!")
            if(type(error) == string) then
                print(error)
            end
        end

        local aliveCellType = firstLine[3]

        local frame = Frame(tonumber(firstLine[1]), tonumber(firstLine[2]))

        for i = 1, frame.height, 1 do
            for j = 1, frame.width, 1 do
                local state = StateType.DEAD

                if(string.sub(instance.lines[i + 1],j,j) == aliveCellType) then
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

        if(instance.relative) then
            instance.fileName = "testMaps/".. instance.fileName ..".txt"
        end

        local lines = {}
        for line in io.lines(instance.fileName) do
            lines[#lines + 1] = line
        end

        return lines
    end

    instance.file_exists = function()
        local result
        if(instance.relative) then
            result = assert(io.open("testMaps/".. instance.fileName ..".txt", "r"), "File not found!")
        else
            result = assert(io.open(instance.fileName , "r"), "File not found!")
        end

        if( type(result) == type(" ")) then
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