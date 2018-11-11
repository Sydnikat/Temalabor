


local Participant = {}

setmetatable(Participant, {
    __call = function(class,...)
        return class:new(...)
    end
})

function Participant:new(amountOfMoney, dealer, behavior, inputHandler,observer)
    local newParticipnat = setmetatable({}, self)
    self.__index = self
    newParticipnat.amountOfMoney = amountOfMoney
    newParticipnat.behavior = behavior
    newParticipnat.dealer = dealer
    newParticipnat.inputHandler = inputHandler
    newParticipnat.observer = observer
    return newParticipnat
end

function Participant:takeMoney(money)
    self.amountOfMoney = self.amountOfMoney + money
end

function Participant:setBasicMoney(newAmount)
    self.amountOfMoney = newAmount
end

function Participant:showMoney()
    return self.amountOfMoney
end

return Participant