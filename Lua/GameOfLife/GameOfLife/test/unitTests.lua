

lu = require "luaunit"

--------------------- Cell unit tests -------------------------------

 local _ = require "test.cellUnitTest"

----------------- FrameMaker unit tests -----------------------------

local _ = require "test.frameMakerUnitTest"



----------------- Execute tests -------------------------------------

os.exit( lu.LuaUnit.run() )