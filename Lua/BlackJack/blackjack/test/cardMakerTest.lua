
local CardMaker = require("gfx.CardMaker"):getInstance()
local Card = require "entity.Card"

function testCardToUnicode() 

    lu.assertEquals(
        utf8.char(tonumber(CardMaker.printCard(Card("JACK", "CLUBS", 11, true)), 16)),
        "🂠"
    )
    
    lu.assertEquals(
        utf8.char(tonumber(CardMaker.printCard(Card("JACK", "CLUBS", 11, false)), 16)),
        "🃛"
    )
    
    lu.assertEquals(
        utf8.char(tonumber(CardMaker.printCard(Card("FOUR", "HEARTS", 4, false)), 16)),
        "🂴"
    )
    
    lu.assertEquals(
        utf8.char(tonumber(CardMaker.printCard(Card("NINE", "SPADES", 9, false)), 16)),
        "🂩"
    )
    
    lu.assertEquals(
        utf8.char(tonumber(CardMaker.printCard(Card("KING", "DIAMONDS", 11, false)), 16)),
        "🃎"
    )

end

