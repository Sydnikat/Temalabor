
Frame = require "entity.Frame"
FileInputHandler = require "input.FileInputHandler".getInstance()
local read = io.read

local FrameMaker = {}

function FrameMaker:getInstance()

    local instance = {}

    local createFrame = function()

        local frame = {}

        print("Fájlból akarod betölteni? I - igen\t N - nem")

        if(string.upper(read()) == "I" )
        then
            frame = instance.loadFromFile(frame)
        else
            frame = instance.createIndividual(frame)
        end

        local maxGeneration = instance.getValue("Hány generációt szeretne szimulálni?")
        frame.duration = maxGeneration

        return frame
    end

    instance.createIndividual = function(frame)
        print("\nE - Egyéni beállítások\t A - Általános")

        if(string.upper(read()) == "A")
        then
            frame = Frame(
                instance.getValue("Kérem adja meg a váz magasságát (egész érték):"),
                instance.getValue("Kérem adja meg a váz szélességét (egész érték):")
            )
        else
            frame = Frame(
                instance.getValue("Kérem adja meg a váz magasságát (egész érték):"),
                instance.getValue("Kérem adja meg a váz szélességét (egész érték):"),
                instance.getValue("Kérem adja meg, hogy milyen gyorsan jöjjön létre az új generáció (milisec-ben)!"),
                instance.getValue("Kérem adja meg, hogy kb. minden hányadik sejt éljen (az érték egész és legalább 2 legyen)")
            )
        end

        return frame
    end

    instance.getValue = function(msg)
        local correct = false
        local value

        while(correct ~= true) do

            print("\n"..msg.."\t")
            value = tonumber(read())
            if(type(value) == nil)
            then
                print("Típushiba! Kérem adjon meg egy egész értéket!")
            else
                correct = true
            end
        end

        return value
    end

    instance.loadFromFile = function(frame)

        print("\nA tesztpályák közül szeretné betölteni? I - igen\t N - nem")
        print("*megjegyzés: Amennyiben parancsorból futtatja csak akkor válassza a tesztpályákat, ha a játék könyvtárából futtatja!*")

        if(string.upper(read()) == "I")
        then
            print("\nKérem adja meg a teszpálya nevét (csak a nevet)!")

            frame = FileInputHandler.createFrameFromFile(read())

        else
            print("\nKérem adja meg a fájl abszolút elérési útját!")
            frame = FileInputHandler.createFrameFromFile(read(), false)
        end

        return frame

    end

    return {
        createFrame = createFrame
    }
end

return FrameMaker

