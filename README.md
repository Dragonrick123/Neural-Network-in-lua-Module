# Neural Network for lua, module!

after some serious time developing this, I have come with a simple module for creating neural networks, easily using lua, and this package.
![example](https://github.com/Dragonrick123/Neural-Network-in-lua-Module/blob/general/Images/example.png)
as you can see it only takes 4-5 lines to actually start training a neural network using this module!.

More about this:
this started as a project I started by myself, it is inspired on [brain.js](https://github.com/BrainJS), and [keras](https://github.com/keras-team/keras)
by the way, we're looking for contributors, if you'd like to help us on this project, let me know, my discord is Eyeless.#4808



and finally, here's a brief explanation on all the classes, and features this module offers.


first of all, this module have 2 main classes, which are the layers and the neural network class.

# Layers

## module.Layers.CreateLayer(name, orderOfActivation, Activation)
_returns a layer object and stores it in a cache folder inside the module_
* name typeof name must be a string
* orderOfActivation typeof orderOfActivaction must be a number, you can't skip numbers; 1-x
* Activation typeof Activation must be a function, the module functions library of activations are stored inside module.activations
## layer.layer_think(inputs, weights, bias)
_returns a evaluated value based on the layers activation, the inputs, weights, and bias_
* inputs typeof inputs must be a table
* weights typeof weights must be a decimal number between 0-1
* bias typeof bias must be a decimal number between 0-1
###### for more info on [weights and bias](https://towardsdatascience.com/whats-the-role-of-weights-and-bias-in-a-neural-network-4cf7e9888a0f)
## layer.ChangeActivation(NewActivation)
_changes the property activation of the layer_
* NewActivation typeof NewActivation must be a function
###### keep in mind that layer.layer_think(inputs, weights, bias) will execute the activation, with the given arguments
