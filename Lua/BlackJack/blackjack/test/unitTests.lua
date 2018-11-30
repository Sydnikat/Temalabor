

lu = require "test.luaunit"


----------------- Calculator unit tests -----------------------------

require "test.calculatorTest"

----------------- Card Maker unit tests -----------------------------

require "test.cardMakerTest"

----------------- Execute tests -------------------------------------

os.exit( lu.LuaUnit.run() )