
h = require "test.testHelper"
io.read = h.read

local Player = require "entity.Player"
local Dealer = require "entity.Dealer"
local ActionType = require "type.ActionType"
local GameState = require "type.GameState"
local ResultType = require "type.ResultType"
local ClassicTableView = require "gfx.ClassicTableView"
local ClassicPlayer = require "behavior.ClassicPlayer"
local ClassicBank = require "behavior.ClassicBank"
local Calculator = require("entity.Calculator"):getInstance()
local ConsoleInputHandler = require("input.ConsoleInputHandler"):getInstance()
local testPlayerObserver = require "test.testPlayerObserver"
local Card = require "entity.Card"

local testDealer = {
    deckPool = {}
}
function testDealer:giveCard()
    return table.remove(self.deckPool, 1)
end

function setUp(player) 

    player.dealer.deckPool = {
        Card("KING", "DIAMONDS", 11),
        Card("KING", "HEARTS", 11),
        Card("NINE", "CLUBS", 9),
        Card("FOUR", "CLUBS", 4),
        Card("QUEEN", "SPADES", 11)
    }

    player:changeDeck(0)

end


function testDoubleCheck()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp(player)
    h.input = {"10"}
    h.cnt = 0

    player:raise()
    player:receiveFirstCards()
    
    lu.assertEquals(player:showMoney(), 90.0)
    
    player:double(player:showDeck())
    
    lu.assertEquals(player:showDeck().money, 20.0)
    
    lu.assertEquals(player:showMoney(), 80.0)

end


function testMultipleDouble()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp(player)
    h.input = {"10"}
    h.cnt = 0

    player:raise()
    player:receiveFirstCards()
    
    lu.assertEquals(player:showMoney(), 90.0)

    player:double(player:showDeck())
    player:double(player:showDeck())
    
    lu.assertEquals(player:showDeck().money, 40.0)
    lu.assertEquals(player:showMoney(), 60.0)

end


function tetsCheckMaximumDouble()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp(player)
    h.input = {"40"}
    h.cnt = 0

    player:raise()
    player:receiveFirstCards()

    lu.assertEquals(player:showMoney(), 40.0)

    player:double(player:showDeck())
    player:double(player:showDeck())

    lu.assertEquals(player:showDeck().money, 100.0)
    lu.assertEquals(player:showMoney(), 0.0)

end


function testPlayAndQuit()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp(player)
    h.input = {"40", "s", "d", "h", "e", "h", "q" }
    h.cnt = 0

    player:raise()
    player:receiveFirstCards()

    player:play()

    lu.assertNotEquals(player:showMoney(), 100.0)

end


function testPlayAndNewGame()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp(player)
    h.input = {"40", "s", "d", "h", "e", "h", "n", "500"}
    h.cnt = 0

    player:raise()
    player:receiveFirstCards()

    player:play()

    lu.assertNotEquals(player:showMoney(), 500)

end

function setUp2(player)

    player.dealer.deckPool = {
        Card("TEN", "DIAMONDS", 10),
        Card("THREE", "HEARTS", 3),
        Card("FOUR", "SPADES", 4),
        Card("ACE", "CLUBS", 11),
        Card("JACK", "DIAMONDS", 11),
        Card("ACE", "DIAMONDS", 11)
    }

    player:changeDeck(0)

end


function testSimpleHit()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp2(player)
    h.input = {"10"}
    h.cnt = 0

    player:raise()
    player:receiveFirstCards()

    player:hit(player:showDeck())

    lu.assertEquals(#player:showDeck().cards, 3)

end


function testMultipleHit()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp2(player)
    h.input = {"10"}
    h.cnt = 0

    player:raise()
    player:receiveFirstCards()

    player:hit(player:showDeck())
    player:hit(player:showDeck())
    player:hit(player:showDeck())

    lu.assertEquals(#player:showDeck().cards, 5)

end


function testCheckMaximumHit()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp2(player)
    h.input = {"10"}
    h.cnt = 0

    player:raise()
    player:receiveFirstCards()

    player:hit(player:showDeck())
    player:hit(player:showDeck())
    player:hit(player:showDeck())

    player:hit(player:showDeck())

    lu.assertEquals(#player:showDeck().cards, 5)

end


function testSplitTwoCardsAndWithTheSameValue()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp(player)
    h.input = {"10"}
    h.cnt = 0

    player:raise()
    player:receiveFirstCards()

    player:split(player:showDeck())

    lu.assertEquals(#player:showDeck().cards, 1)
    lu.assertEquals(player:showDeck().money, 5.0)

    player:changeDeck(player.numberOfUsedDecks)


    lu.assertEquals(#player:showDeck().cards, 1)
    lu.assertEquals(player:showDeck().money, 5.0)

    lu.assertEquals(player:showDeck().cards[1].value, "KING")
    lu.assertEquals(player:showDeck().cards[1].color, "DIAMONDS")
end


function tetsSplitWithTwoCardsButNotTheSameValue()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp(player)
    h.input = {"10"}
    h.cnt = 0

    --A két ugyan olyan kártya kivétele (az egységes kezelés és a boiler text csökkentése miatt)
    player.dealer:giveCard()
    player.dealer:giveCard()


    player:raise()
    player:receiveFirstCards()

    local currentUsedDeckNumber = player.numberOfUsedDecks

    player:split(player:showDeck())

    lu.assertEquals(#player:showDeck().cards, 2)
    lu.assertEquals(player:showDeck().money, 10.0)

    player:changeDeck(currentUsedDeckNumber + 1)


    lu.assertEquals(#player:showDeck().cards, 0)
    lu.assertEquals(player:showDeck().money, 0.0)

end


function testSplitButNotWithTwoNumber()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp(player)
    h.input = {"10"}
    h.cnt = 0

    --A két ugyan olyan kártya kivétele (az egységes kezelés és a boiler text csökkentése miatt)
    player.dealer:giveCard()
    player.dealer:giveCard()

    player:raise()
    player:receiveFirstCards()

    local currentUsedDeckNumber = player.numberOfUsedDecks

    player:hit(player:showDeck())

    player:split(player:showDeck())

    lu.assertEquals(#player:showDeck().cards, 3)
    lu.assertEquals(player:showDeck().money, 10.0)

    player:changeDeck(currentUsedDeckNumber + 1)


    lu.assertEquals(#player:showDeck().cards, 0)
    lu.assertEquals(player:showDeck().money, 0.0)

end


function testMultipleSplitAndPreparation()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp(player)
    h.input = {"10"}
    h.cnt = 0

    player.dealer.deckPool = {
        Card("JACK", "DIAMONDS", 11),
        Card("JACK", "HEARTS", 11),
        Card("JACK", "SPADES", 11),
        Card("JACK", "CLUBS", 11),
        Card("JACK", "DIAMONDS", 11)
    }

    player:raise()
    player:receiveFirstCards()

    player:split(player:showDeck())

    lu.assertEquals(#player:showDeck().cards, 1)
    lu.assertEquals(player:showDeck().money, 5.0)


    player:hit(player:showDeck())

    player:split(player:showDeck())

    lu.assertEquals(#player:showDeck().cards, 1)
    lu.assertEquals(player:showDeck().money, 2.5)

    player:hit(player:showDeck())

    player:split(player:showDeck())

    lu.assertEquals(#player:showDeck().cards, 2)
    lu.assertEquals(player:showDeck().money, 2.5)

    player:changeDeck(player.numberOfUsedDecks)

    lu.assertEquals(#player:showDeck().cards, 1)
    lu.assertEquals(player:showDeck().money, 2.5)

    -- ---------------------------------------------------------
    -- Itt talán a legjobb tesztelni a preparation függvényt
    -- ---------------------------------------------------------

    for i = 1, player.numberOfUsedDecks, 1 do

        player:changeDeck(i)
        if(i == 1) then lu.assertEquals(#player:showDeck().cards, 2)
        else
            lu.assertEquals(#player:showDeck().cards, 1)
        end

    end

    lu.assertEquals(player.numberOfUsedDecks, 3)

    player:preparation()

    lu.assertEquals(player.numberOfUsedDecks, 1)

    for i = 1, player.behavior:getMaximumNumberOfDecks(), 1 do

        player:changeDeck(i)
        lu.assertEquals(#player:showDeck().cards, 0)
        lu.assertEquals(player:showDeck().money, 0.0)

    end

end


function testRaise()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp(player)
    h.input = {"1a", "100.1", "100"}
    h.cnt = 0

    player:raise()

    lu.assertEquals(player:showMoney(), 0.0)
    lu.assertEquals(player:showDeck().money, 100.0)

    for i = 2, player.behavior:getMaximumNumberOfDecks(), 1 do

        player:changeDeck(i)
        lu.assertEquals(player:showDeck().money, 0.0)

    end

end


function testReceiveFirstCards()

    local player = Player(100.0, testDealer, ClassicPlayer(), ConsoleInputHandler, testPlayerObserver)
    setUp(player)

    player:receiveFirstCards()

    lu.assertEquals("KING", player:showDeck().cards[1].value)
    lu.assertEquals("DIAMONDS", player:showDeck().cards[1].color)
    lu.assertEquals("KING", player:showDeck().cards[2].value)
    lu.assertEquals("HEARTS", player:showDeck().cards[2].color)


end
