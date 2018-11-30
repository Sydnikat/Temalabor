

local ResultType = require "type.ResultType"
local ColorType = require "type.ColorType"
local Calculator = require("entity.Calculator"):getInstance()
local Card = require "entity.Card"
local Deck = require "entity.Deck"


function testEvaluateCardsWithoutAce()

    local cards1 = {}
    table.insert(cards1, Card("EIGHT", ColorType.CLUBS, 8))
    table.insert(cards1, Card("TEN", ColorType.SPADES, 10))

    local cards2 = {}
    table.insert(cards2, Card("QUEEN", ColorType.DIAMONDS, 11))
    table.insert(cards2, Card("KING", ColorType.SPADES, 11))


    local cards3 = {}
    table.insert(cards3, Card("JACK", ColorType.CLUBS, 11))
    table.insert(cards3, Card("TEN", ColorType.HEARTS, 10))


    local cards4 = {}
    table.insert(cards4, Card("TWO", ColorType.CLUBS, 2))
    table.insert(cards4, Card("SEVEN", ColorType.SPADES, 7))
    table.insert(cards4, Card("SIX", ColorType.HEARTS, 6))
    table.insert(cards4, Card("FOUR", ColorType.SPADES, 4))


    lu.assertEquals(Calculator.evaluate(cards1), 18)
    lu.assertEquals(Calculator.evaluate(cards2), 22)
    lu.assertEquals(Calculator.evaluate(cards3), 21)
    lu.assertEquals(Calculator.evaluate(cards4), 19)

end


function testEvaluateCardsWithAceButLessThan21OrEvenWith21()

    local cards1 = {}
    table.insert(cards1, Card("EIGHT", ColorType.CLUBS, 8))
    table.insert(cards1, Card("ACE", ColorType.SPADES, 11))


    local cards2 = {}
    table.insert(cards2, Card("TEN", ColorType.DIAMONDS, 10))
    table.insert(cards2, Card("ACE", ColorType.HEARTS, 11))


    lu.assertEquals(Calculator.evaluate(cards1), 19)
    lu.assertEquals(Calculator.evaluate(cards2), 21)

end


function testEvaluateCardsWithAceButMoreThan21()

    local cards1 = {}
    table.insert(cards1, Card("JACK", ColorType.CLUBS, 11))
    table.insert(cards1, Card("ACE", ColorType.SPADES, 11))


local cards2 = {}
    table.insert(cards2, Card("ACE", ColorType.DIAMONDS, 11))
    table.insert(cards2, Card("TEN", ColorType.SPADES, 10))
    table.insert(cards2, Card("TWO", ColorType.SPADES, 2))


local cards3 = {}
    table.insert(cards3, Card("ACE", ColorType.DIAMONDS, 11))
    table.insert(cards3, Card("FOUR", ColorType.CLUBS, 4))
    table.insert(cards3, Card("SIX", ColorType.HEARTS, 6))
    table.insert(cards3, Card("QUEEN", ColorType.DIAMONDS, 11))


    lu.assertEquals(Calculator.evaluate(cards1), 12)
    lu.assertEquals(Calculator.evaluate(cards2), 13)
    lu.assertEquals(Calculator.evaluate(cards3), 22)

end


function testEvaluateCardsWithMultipleAces()

    local cards1 = {}
    table.insert(cards1, Card("ACE", ColorType.CLUBS, 11))
    table.insert(cards1, Card("ACE", ColorType.SPADES, 11))


    local cards2 = {}
    table.insert(cards2, Card("ACE", ColorType.DIAMONDS, 11))
    table.insert(cards2, Card("TEN", ColorType.SPADES, 10))
    table.insert(cards2, Card("ACE", ColorType.SPADES, 11))
    table.insert(cards2, Card("SIX", ColorType.SPADES, 6))


    local cards3 = {}
    table.insert(cards3, Card("ACE", ColorType.DIAMONDS, 11))
    table.insert(cards3, Card("EIGHT", ColorType.CLUBS, 8))
    table.insert(cards3, Card("ACE", ColorType.HEARTS, 11))
    table.insert(cards3, Card("JACK", ColorType.DIAMONDS, 11))


    lu.assertEquals(Calculator.evaluate(cards1), 12)
    lu.assertEquals(Calculator.evaluate(cards2), 18)
    lu.assertEquals(Calculator.evaluate(cards3), 21)

end


function testCalculateResultWithWinByBlackJack()

    local pDeck = Deck({
            Card("JACK", ColorType.CLUBS, 11),
            Card("TEN", ColorType.SPADES, 10)
            }, 0)

    local bDeck = Deck({
            Card("NINE", ColorType.DIAMONDS, 9),
            Card("ACE", ColorType.HEARTS, 11)
            }, 0)

    lu.assertEquals(Calculator.calculateResult(pDeck, bDeck), ResultType.WINBYJACK)

    pDeck = Deck({
            Card("TEN", ColorType.DIAMONDS, 10),
            Card("JACK", ColorType.HEARTS, 11)
            }, 0)

    bDeck = Deck({
            Card("TEN", ColorType.SPADES, 10),
            Card("ACE", ColorType.SPADES, 11)
            }, 0)

    lu.assertEquals(Calculator.calculateResult(pDeck, bDeck), ResultType.WINBYJACK)

end


function testCalculateResultWithLoseByBlackJack()

    local bDeck = Deck({
        Card("JACK", ColorType.CLUBS, 11),
        Card("TEN", ColorType.SPADES, 10)
    }, 0)

    local pDeck = Deck({
        Card("NINE", ColorType.DIAMONDS, 9),
        Card("ACE", ColorType.HEARTS, 11)
    }, 0)

    lu.assertEquals(Calculator.calculateResult(pDeck, bDeck), ResultType.LOSEBYJACK)

    bDeck = Deck({
        Card("TEN", ColorType.DIAMONDS, 10),
        Card("JACK", ColorType.HEARTS, 11)
    }, 0)

    pDeck = Deck({
        Card("TEN", ColorType.SPADES, 10),
        Card("ACE", ColorType.SPADES, 11)
    }, 0)

    lu.assertEquals(Calculator.calculateResult(pDeck, bDeck), ResultType.LOSEBYJACK)

end


function testCalculateResultWithTie()

    local bDeck = Deck({
        Card("NINE", ColorType.CLUBS, 9),
        Card("TEN", ColorType.SPADES, 10),
        Card("TWO", ColorType.SPADES, 2)
    }, 0)

    local pDeck = Deck({
        Card("TEN", ColorType.DIAMONDS, 10),
        Card("ACE", ColorType.HEARTS, 11)
    }, 0)

    lu.assertEquals(Calculator.calculateResult(pDeck, bDeck), ResultType.TIE)

    bDeck = Deck({
        Card("TEN", ColorType.DIAMONDS, 10),
        Card("SIX", ColorType.SPADES, 6),
        Card("FOUR", ColorType.CLUBS, 4)
    }, 0)

    pDeck = Deck({
        Card("NINE", ColorType.DIAMONDS, 9),
        Card("FIVE", ColorType.HEARTS, 5),
        Card("THREE", ColorType.SPADES, 3),
        Card("THREE", ColorType.HEARTS, 3)

    }, 0)

    lu.assertEquals(Calculator.calculateResult(pDeck, bDeck), ResultType.TIE)

end


function testCalculateResultLose()


    local pDeck = Deck({
        Card("QUEEN", ColorType.CLUBS, 11),
        Card("KING", ColorType.SPADES, 11)
    }, 0)

    local bDeck = Deck({
        Card("THREE", ColorType.DIAMONDS, 3),
        Card("ACE", ColorType.HEARTS, 11)
    }, 0)

    lu.assertEquals(Calculator.calculateResult(pDeck, bDeck), ResultType.LOSE)

    pDeck = Deck({
        Card("QUEEN", ColorType.CLUBS, 11),
        Card("KING", ColorType.SPADES, 11)
    }, 0)

    bDeck = Deck({
        Card("JACK", ColorType.DIAMONDS, 11),
        Card("JACK", ColorType.HEARTS, 11)
    }, 0)

    lu.assertEquals(Calculator.calculateResult(pDeck, bDeck), ResultType.LOSE)

    pDeck = Deck({
        Card("TEN", ColorType.DIAMONDS, 10),
        Card("SIX", ColorType.SPADES, 6),
        Card("THREE", ColorType.CLUBS, 3)
    }, 0)

    bDeck = Deck({
        Card("NINE", ColorType.DIAMONDS, 9),
        Card("FIVE", ColorType.HEARTS, 5),
        Card("THREE", ColorType.SPADES, 3),
        Card("THREE", ColorType.HEARTS, 3)

    }, 0)

    lu.assertEquals(Calculator.calculateResult(pDeck, bDeck), ResultType.LOSE)

end


function testCalculateWin()

    local pDeck = Deck({
        Card("TEN", ColorType.CLUBS, 10),
        Card("KING", ColorType.SPADES, 11)
    }, 0)

    local bDeck = Deck({
        Card("JACK", ColorType.DIAMONDS, 11),
        Card("JACK", ColorType.HEARTS, 11)
    }, 0)

    lu.assertEquals(Calculator.calculateResult(pDeck, bDeck), ResultType.WIN)

    pDeck = Deck({
        Card("TEN", ColorType.DIAMONDS, 10),
        Card("SIX", ColorType.SPADES, 6),
        Card("THREE", ColorType.CLUBS, 3)
    }, 0)

    bDeck = Deck({
        Card("NINE", ColorType.DIAMONDS, 9),
        Card("FIVE", ColorType.HEARTS, 5),
        Card("THREE", ColorType.SPADES, 3)

    }, 0)

    lu.assertEquals(Calculator.calculateResult(pDeck, bDeck), ResultType.WIN)

end 