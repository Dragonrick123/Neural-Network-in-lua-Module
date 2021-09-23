local Library = require(module)
local MyLayers = {
		Library.layers.Create_Layer("FirstLayerPREMADE", 1, Library.activations.relu),
		Library.layers.Create_Layer("FirstHiddenLayerPREMADE", 2, Library.activations.sigmoid),
		Library.layers.Create_Layer("MiddleLayerPREMADE", 3, Library.activations.tanh),
		Library.layers.Create_Layer("SecondHiddenLayerPREMADE", 4, Library.activations.relu),
		Library.layers.Create_Layer("FinalLayerPREMADE", 5, Library.activations.softmax)
}--[[
for the CreateLayer function, 

the first argument is the name of the layer.

the second argument, will be the order in which the data will be sorted, through the layers, like it'll execute 
the layer with ord set to 1, then the layer with ord set to 2, etc, etc.

and the third argument, is the activation the layer will be using, as an extra tip, there's a function inside the layer which is called
through layer.ChangeActivation(NewActivation), that's all, each layer will have a property called activation, which you can change with 
a custom activation, just keep in mind that the given object must be a funtion.

--]]

--example of creating a new neural network class, with our custom layers

local MyNeuralNetwork = Library.Create_neuronal_network("am pro", MyLayers)
