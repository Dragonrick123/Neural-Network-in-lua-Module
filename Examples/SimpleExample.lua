local Library = require(module)
local MyNeuralNetwork = Library.Create_neuronal_network("am pro", "premade")
--keep in mind that you must pass the layers, inside a table



--[[
in this constructor, 

the first argument is the name of the neural network, which will be used for indexing the class,
in case you want to create multiple neural networks.

the second argument, are the layers, you can pass out the string "premade" for creating it with the premade layers,
otherwise, you can try the layers constructor I created, for a deeper guide on this, check ./LayersConstructor.lua

--]]
MyNeuralNetwork.Train(data.X, data.Y, Library.optim.Adam, 20, true)
--[[
for the Train Function, the arguments are,

the first argument and second arguments are inputs, and outputs, which will be the data that
the neural network will be trained with.

the third argument, will tell the neural network, which optimizer should it use, at the moment it only supports Adam.

the fourth argument will tell the neural network how many iterations should it train.

and finally the fifth argument, is for specifying whether it should print the results, and other data after each iteration, or not

--]]
local guess = MyNeuralNetwork.run(data.X, "general")
--[[The expected output here, is data.Y
the "general" is neccesary for telling the neural network to make a general prediction, anyways 
feel free to test the layers, example; MyNeuralNetwork.run(data.X, MyNeuralNetwork.Layers[2])

--]]
print(guess)

