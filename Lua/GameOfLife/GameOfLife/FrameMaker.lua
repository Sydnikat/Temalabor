
Frame = require "entity.Frame"
FileInputHandler = require ("input.FileInputHandler").getInstance()
local read = io.read

local FrameMaker = {}

function FrameMaker:getInstance()

    local instance = {}

    local createFrame = function()

        local frame = {}

        print("Do you want to load the map from a file? Y - Yes\t N - No")

        if(string.upper(read()) == "Y" ) then
            frame = instance.loadFromFile(frame)
        else
            frame = instance.createIndividual(frame)
        end

        frame.duration = instance.getValue("How many generations do you want to simulate?")

        return frame
    end

    instance.createIndividual = function(frame)
        print("\nI - Individual settings\t G - General settings")

        if(string.upper(read()) == "G")
        then
            frame = Frame(
                instance.getValue("Please enter the width of the testframe (integer value):"),  -- Frame width
                instance.getValue("Please enter the height of the testframe (integer value):")  -- Frame height
            )
        else
            frame = Frame(
                instance.getValue("Please enter the width of the testframe (integer value):"),   -- Frame width
                instance.getValue("Please enter the height of the testframe (integer value):"), -- Frame height
                instance.getValue("Please enter the elapsed time between two generations (in millisec)!"),  -- timeBetweenGens
                instance.getValue("Please enter the rate of the living cells - (1 / rate) will be the chance - (choose at least 2)!")   --chance
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
            if(type(value) == type(0)) then
                correct = true
            else
                print("Type error! Please use integer value!")
            end
        end

        return value
    end

    instance.loadFromFile = function(frame)

        print("\nDo you want to load a pre-defined map? Y - Yes\t N - No")
        print("*Note: If you run this app in command promt please make sure that you are in the root directory of the game!*")

        if(string.upper(read()) == "Y") then
            print("\nPlease enter the name of the pre-defined map (only the name - no extension - )!")
            frame = FileInputHandler.createFrameFromFile(read())

        else
            print("\nPlease enter the absolute path of the test map!")
            frame = FileInputHandler.createFrameFromFile(read(), false)
        end

        return frame

    end

    return {
        createFrame = createFrame
    }
end

return FrameMaker

