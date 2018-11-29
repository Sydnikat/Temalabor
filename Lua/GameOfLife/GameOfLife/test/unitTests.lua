

lu = require "test.luaunit"

--------------------- Cell unit tests -------------------------------

 local _ = require "test.cellUnitTest"

----------------- FrameMaker unit tests -----------------------------

local _ = require "test.frameMakerUnitTest"

----------------- Frame unit tests ----------------------------------

local _ = require "test.frameTest"

----------------- Execute tests -------------------------------------

os.exit( lu.LuaUnit.run() )