
math.randomseed(os.time())
local matrix = require("scripts.matrix")

print(matrix.toString(matrix.new(2, 4, true, 1, 2), true, 5))
