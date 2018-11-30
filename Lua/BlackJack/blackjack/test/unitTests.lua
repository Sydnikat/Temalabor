

lu = require "test.luaunit"


----------------- Calculator unit tests -----------------------------

require "test.calculatorTest"

----------------- Card Maker unit tests -----------------------------

require "test.cardMakerTest"

----------------- Dealer unit tests ---------------------------------

require "test.dealerTest"

----------------- ConsoleInputHandler unit tests --------------------

require "test.consoleInputHandlerTest"

----------------- Execute tests -------------------------------------

os.exit( lu.LuaUnit.run() )