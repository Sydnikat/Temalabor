

local Dealer = require "entity.Dealer"

local testObserver = {
    dealer = {}
}

function testObserver:noticeLowDeck()
    self.dealer:createNewDeck()
end

function testGiveCardAndNoticeLowDeck()
    
    local dealer = Dealer(1, testObserver)

    testObserver.dealer = dealer
    
    lu.assertEquals(#dealer.deckPool, 52)
    
    dealer:giveCard()
    
    lu.assertEquals(#dealer.deckPool, 51)

    for i = 1, 25, 1 do
        dealer:giveCard()
    end
    
    lu.assertEquals(#dealer.deckPool, 26)
    
    dealer:giveCard()
    
    lu.assertEquals(#dealer.deckPool, 25)
    
    dealer:giveCard()
    
    lu.assertEquals(#dealer.deckPool, 51)

end