local frktest = require("@lune_pkg/frktest")
local collection = require("../src/lib")

local test = frktest.test
local check = frktest.assert.check

return function()
    test.suite("collection_manager.register", function()
        test.case("register a value", function()
            local my_collection = collection.new()
            local string1 = "banana"
            local stored: string? = nil

            check.should_not_error(function()
                stored = my_collection:register(string1, "test1"):unwrap()
                
                return nil
            end)
            check.equal(stored, string1)

            return nil
        end)

        test.case("register two values with grouping", function()
            local my_collection = collection.new()
            local string1, string2 = "apple", "banana"
            local stored1: string?, stored2: string? = nil, nil

            check.should_not_error(function()
                stored1 = my_collection:register(string1, "fruits/index_1"):unwrap()
                stored2 = my_collection:register(string2, "fruits/index_2"):unwrap()

                return nil
            end)
            check.equal(stored1, string1)
            check.equal(stored2, string2)

            return nil
        end)

        test.case("register two values with grouping and peek the values", function()
            local my_collection = collection.new()
            local string1, string2 = "apple", "banana"
            local stored1: string?, stored2: string? = nil, nil

            check.should_not_error(function()
                my_collection:register(string1, "fruits/index_1"):unwrap()
                my_collection:register(string2, "fruits/index_2"):unwrap()

                return nil
            end)
            check.should_not_error(function()
                stored1 = my_collection:get("fruits/index_1"):unwrap()
                stored2 = my_collection:get("fruits/index_2"):unwrap()

                return nil
            end)
            check.equal(stored1, string1)
            check.equal(stored2, string2)

            return nil
        end)

        return nil
    end)
end