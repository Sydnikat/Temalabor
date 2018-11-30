

lu = require "test.luaunit"


----------------- Calculator unit tests -----------------------------

require "test.calculatorTest"

----------------- Card Maker unit tests -----------------------------

require "test.cardMakerTest"

----------------- Dealer unit tests ---------------------------------

require "test.dealerTest"

----------------- ConsoleInputHandler unit tests --------------------

require "test.consoleInputHandlerTest"

----------------- Bank unit tests -----------------------------------

require "test.bankTest"

----------------- Player unit tests ---------------------------------

require "test.playerTest"

----------------- Table unit tests ----------------------------------

require "test.tableTest"

----------------- Execute tests -------------------------------------

os.exit( lu.LuaUnit.run() )