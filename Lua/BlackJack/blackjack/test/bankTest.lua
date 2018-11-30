

local Bank = require "entity.Bank"
local Card = require "entity.Card"
local ClassicBank = require "behavior.ClassicBank"
local testPlayerObserver = require "test.testPlayerObserver"


local testDealer = {
    deckPool = {}
}
function testDealer:giveCard()
    return table.remove(self.deckPool, 1)
end


function testPlay()

    local bank = Bank(0, testDealer, ClassicBank(), nil, testPlayerObserver)

    local cards = {}

    table.insert(cards, Card("KING", "DIAMONDS", 11))
    table.insert(cards, Card("FOUR", "HEARTS", 4))
    table.insert(cards, Card("NINE", "CLUBS", 9))
    table.insert(cards, Card("QUEEN", "SPADES", 11))

    bank.dealer.deckPool = cards

    bank:receiveFirstCards()

    bank:play()

    lu.assertEquals(#bank:showDeck().cards, 3)
    
    lu.assertFalse(bank:showDeck().cards[2].hidden)
    
    lu.assertEquals("NINE", bank:showDeck().cards[3].value)
    lu.assertEquals("CLUBS", bank:showDeck().cards[3].color)

end


function testReceiveFirstCards()

    local bank = Bank(0, testDealer, ClassicBank(), nil, testPlayerObserver)

    local cards = {}

    table.insert(cards, Card("KING", "DIAMONDS", 11))
    table.insert(cards, Card("FOUR", "HEARTS", 4))
    table.insert(cards, Card("NINE", "CLUBS", 9))
    table.insert(cards, Card("QUEEN", "SPADES", 11))

    bank.dealer.deckPool = cards

    bank:receiveFirstCards()

    lu.assertEquals("KING", bank:showDeck().cards[1].value)
    lu.assertEquals("DIAMONDS", bank:showDeck().cards[1].color)
    
    lu.assertEquals("FOUR", bank:showDeck().cards[2].value)
    lu.assertEquals("HEARTS", bank:showDeck().cards[2].color)
    
    lu.assertTrue(bank:showDeck().cards[2].hidden)

end
