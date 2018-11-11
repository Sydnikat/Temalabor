
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

            if(card.color == ColorTye.SPADE) then type = "A"
            elseif(card.color == ColorTye.HEARTS) then type = "B"
            elseif(card.color == ColorTye.DIAMONDS) then type = "C"
            else type = "D"
            end

            local value

            if(card.value == CardType.ACE) then value = 1
            elseif(card.value == CardType.TWO) then value = 2
            elseif(card.value == CardType.THREE) then value = 3
            elseif(card.value == CardType.FOUR) then value = 4
            elseif(card.value == CardType.FIVE) then value = 5
            elseif(card.value == CardType.SIX) then value = 6
            elseif(card.value == CardType.SEVEN) then value = 7
            elseif(card.value == CardType.EIGHT) then value = 8
            elseif(card.value == CardType.NINE) then value = 9
            elseif(card.value == CardType.TEN) then value = "A"
            elseif(card.value == CardType.JACK) then value = "B"
            elseif(card.value == CardType.QUEEN) then value = "D"
            else value = "E"
            end

            cardString = "1A0"..type..value
        end

        print(utf8.char(tonumber(cardString,16)))
    end

    return{
        printCard = printCard
    }

end

return CardMaker

