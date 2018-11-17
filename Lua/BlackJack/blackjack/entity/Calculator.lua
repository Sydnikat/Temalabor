
local ResultType = require "type.ResultType"

local Calculator = {}

function Calculator:getInstance()

    local evaluate = function(cards)
        local sum = 0

        for _, card in ipairs(cards) do
            sum = sum + card.number
        end

        local numberOfAces = 0

        for _, card in ipairs(cards) do
            if(card.value == "ACE")
            then
                numberOfAces = numberOfAces + 1
            end
        end

        while(sum > 21 and numberOfAces > 0) do
            sum = sum - 10  -- Making the value of ACE (default 11) to 1
            numberOfAces = numberOfAces - 1
        end

        return sum

    end

    local calculateResult = function(playerDeck, bankDeck)

        local playerValue = evaluate(playerDeck.cards)
        local bankValue = evaluate(bankDeck.cards)

        if(playerValue == 21 and #playerDeck.cards == 2) then
            if((playerDeck.cards[1].value == "JACK" or playerDeck.cards[2].value == "JACK") and
               (playerDeck.cards[1].value == "TEN" or playerDeck.cards[2].value == "TEN")) then
                return ResultType.WINBYJACK
            end
        end

        if(bankValue == 21 and #bankDeck.cards == 2) then
            if((bankDeck.cards[1].value == "JACK" or bankDeck.cards[2].value == "JACK") and
               (bankDeck.cards[1].value == "TEN" or bankDeck.cards[2].value == "TEN")) then
                return ResultType.LOSEBYJACK
            end
        end

        if(playerValue > 21) then return ResultType.LOSE
        elseif(playerValue == 21) then
            if(bankValue == 21) then return ResultType.TIE
            else return ResultType.WIN
            end
        else
            if(bankValue == 21) then return ResultType.LOSE
            elseif(bankValue > 21) then return ResultType.WIN
            else
                if(bankValue < playerValue) then return ResultType.WIN
                elseif(bankValue == playerValue) then return ResultType.TIE
                else return ResultType.LOSE
                end
            end
        end

    end

    return {
        evaluate = evaluate,
        calculateResult = calculateResult
    }
end

return Calculator