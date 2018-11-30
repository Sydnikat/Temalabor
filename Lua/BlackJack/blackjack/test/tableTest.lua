
h = require "test.testHelper"
io.read = h.read

local Card = require "entity.Card"
local Table = require "entity.Table"
local ConsoleInputHandler = require("input.ConsoleInputHandler"):getInstance()


local testDealer = {
    deckPool = {}
}
function testDealer:giveCard()
    return table.remove(self.deckPool, 1)
end


function testGameWithWinByBlackJackAndStopAndQuit()

    local table = Table( 5, ConsoleInputHandler)
    table.dealer = testDealer
    -- Csinálok egy olyan osztót, aminek gyorsan megadom a felhasználandó kártyákat.
    -- Itt csak az értékekből gyorsan csinálok egy teszt paklit.
    table.dealer.deckPool = deckMaker({"10", "j", "3", "7", "q", "8"})

    -- Beállítom mind a player mind a bank dealerjét újra a test dealernek
    table.player.dealer, table.bank.dealer = table.dealer, table.dealer

    -- Először kér rossz input az alapösszegre, amjd a jó adat.
    -- Aztán egy rossz input a kezdésre, majd egy indítás.
    -- Ezután megint rossz adat tesztelése az emelésnél, majd 10-es érték bevitele.
    -- Menet elindul majd megáll, aztán kilép
    h.input = {"100e", "100", "o", "n", "j10", "10", "e", "q", "q"}
    h.cnt = 0

    table:startGame()

    lu.assertEquals(table.player:showMoney(), 115.0)
    lu.assertEquals(table.winCount, 1)
    lu.assertEquals(table.loseCount, 0)

end


function testGameWithLoseByBlackJackAndStopAndQuit()

    local table = Table( 5, ConsoleInputHandler)
    table.dealer = testDealer
    table.dealer.deckPool = deckMaker({"3", "7", "10", "j", "q", "8"})

    table.player.dealer, table.bank.dealer = table.dealer, table.dealer

    h.input = {"10e", "10", "o", "n", "j10", "10", "e", "q", "q"}
    h.cnt = 0

    table:startGame()

    lu.assertEquals(table.player:showMoney(), 0.0)
    lu.assertEquals(table.winCount, 0)
    lu.assertEquals(table.loseCount, 1)

end


function testGameWithTwoTimesThanNewGameAndThenStop()

    -- Egy sor egy kör kártyáinak felel meg.
    -- Ezzel tesztelek egy győztes, egy vesztes egy döntetlen kört.
    -- Az utolsó sor pedig csak a teszt befejezéséhez kell.
    local table = Table( 5, ConsoleInputHandler)
    table.dealer = testDealer
    table.dealer.deckPool = deckMaker({"3", "7", "10", "10", "q",
                                       "k", "4", "4", "5", "j",
                                       "j", "6", "7", "10",
                                       "k", "q", "j", "10"})

    table.player.dealer, table.bank.dealer = table.dealer, table.dealer

    -- Először kér rossz input az alapösszegre, amjd a jó adat.
    -- Aztán egy rossz input a kezdésre, majd egy indítás.
    -- Ezután megint rossz adat tesztelése az emelésnél, majd 10-es érték bevitele.
    -- Aztán húz -> megáll -> folytatja -> emel 5-öt -> megáll -> abbahagyja.
    -- Újat kezd -> 200 az alapösszeg -> új játék start -> 10-et emel -> megáll -> folytatja
    -- -> 10-et emel -> új játékot kezd -> 500 az alapösszeg majd nem indít, hanem egyből kilép.
    h.input = {"10e", "100", "o", "n", "j20", "10", "h", "e", "i", "5", "e", "q", "n", "200", "n", "10", "e", "i", "10", "n", "500", "q"}
    h.cnt = 0

    table:startGame()

    lu.assertEquals(table.player:showMoney(), 500.0)
    lu.assertEquals(table.winCount, 0)
    lu.assertEquals(table.loseCount, 0)

end

function deckMaker(cards)

    local result = {}

    for _, k in pairs(cards) do

        if(k == "1") then Card("ACE", "DIAMONDS", 11)
        elseif (k == "2") then table.insert(result, Card("TWO", "DIAMONDS", 2))
        elseif (k == "3") then table.insert(result, Card("THREE", "DIAMONDS", 3))
        elseif (k == "4") then table.insert(result, Card("FOUR", "DIAMONDS", 4))
        elseif (k == "5") then table.insert(result, Card("FIVE", "DIAMONDS", 5))
        elseif (k == "6") then table.insert(result, Card("SIX", "DIAMONDS", 6))
        elseif (k == "7") then table.insert(result, Card("SEVEN", "DIAMONDS", 7))
        elseif (k == "8") then table.insert(result, Card("EIGHT", "DIAMONDS", 8))
        elseif (k == "9") then table.insert(result, Card("NINE", "DIAMONDS", 9))
        elseif (k == "10") then table.insert(result, Card("TEN", "DIAMONDS", 10))
        elseif (k == "j") then table.insert(result, Card("JACK", "DIAMONDS", 11))
        elseif (k == "q") then table.insert(result, Card("QUEEN", "DIAMONDS", 11))
        elseif (k == "k") then table.insert(result, Card("KING", "DIAMONDS", 11))
        end

    end

    return result

end