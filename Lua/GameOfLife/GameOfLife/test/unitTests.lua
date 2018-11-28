

lu = require "luaunit"

--------------------- Cell unit tests -------------------------------

 local _ = require "test.cellUnitTest"

----------------- InputHandler unit tests ----------------------------

FileInputHandler = require ("input.FileInputHandler").getInstance()



os.exit( lu.LuaUnit.run() )