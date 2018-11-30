

lu = require "test.luaunit"

--------------------- Cell unit tests -------------------------------

require "test.cellUnitTest"

----------------- FrameMaker unit tests -----------------------------

require "test.frameMakerUnitTest"

----------------- Frame unit tests ----------------------------------

require "test.frameTest"

----------------- Execute tests -------------------------------------

os.exit( lu.LuaUnit.run() )