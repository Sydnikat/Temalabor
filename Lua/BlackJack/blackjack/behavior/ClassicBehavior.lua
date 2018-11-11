

local ClassicBehavior = {}

setmetatable(ClassicBehavior, {
    __call = function(class,...)
        return class:new(...)
    end
})

function ClassicBehavior:new()
    local newClassicBehavior = setmetatable({}, self)
    self.__index = self
    return newClassicBehavior
end

function ClassicBehavior:getMaximumNumberOfDecks()
    return 1
end

function ClassicBehavior:hit(cards)
    return true
end

function ClassicBehavior:double(cards)
    return true
end

function ClassicBehavior:split(cards, numberOfDecks)
    return true
end

return ClassicBehavior

