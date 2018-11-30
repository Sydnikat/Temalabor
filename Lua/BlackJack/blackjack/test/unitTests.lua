

lu = require "test.luaunit"


----------------- Calculator unit tests -----------------------------

require "test.calculatorTest"

----------------- Execute tests -------------------------------------

os.exit( lu.LuaUnit.run() )