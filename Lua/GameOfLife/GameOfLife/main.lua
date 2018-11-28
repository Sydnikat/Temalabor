

require "test.unitTests"


local old = io.read

do

    local input = {"y", "y", "toad", 5}
    local cnt = 0

    io.read = function()

        cnt = cnt+1
        return input[cnt]
    end

end



require("FrameMaker").getInstance().createFrame():simulate()

--FrameMaker.createFrame():simulate()

io.read = old

--local a = io.read()

--print(a)