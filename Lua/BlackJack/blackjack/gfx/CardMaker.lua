
local CardType = require "type.CardType"
local ColorTye = require "type.ColorType"

local CardMaker = {}

function CardMaker:getInstance()

    local printCard = function(card)

        local cardString

        if(card.hidden)
        then
            cardString = "1F0A0"
        else
            local type

            if(card.color == "SPADE") then type = "A"
            elseif(card.color == "HEARTS") then type = "B"
            elseif(card.color == "DIAMONDS") then type = "C"
            else type = "D"
            end

            local value

            if(card.value == "ACE") then value = 1
            elseif(card.value == "TWO") then value = 2
            elseif(card.value == "THREE") then value = 3
            elseif(card.value == "FOUR") then value = 4
            elseif(card.value == "FIVE") then value = 5
            elseif(card.value == "SIX") then value = 6
            elseif(card.value == "SEVEN") then value = 7
            elseif(card.value == "EIGHT") then value = 8
            elseif(card.value == "NINE") then value = 9
            elseif(card.value == "TEN") then value = "A"
            elseif(card.value == "JACK") then value = "B"
            elseif(card.value == "QUEEN") then value = "D"
            else value = "E"
            end

            cardString = "1F0"..type..value
        end

        io.write(utf8.char(tonumber(cardString,16)))
    end

    return{
        printCard = printCard
    }

end

return CardMaker

