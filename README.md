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
_returns a layer object and stores it in a cache folder inside the module until being injected in a neural network object_
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
###### keep in mind that [layer.layer_think(inputs, weights, bias)](https://github.com/Dragonrick123/Neural-Network-in-lua-Module/blob/general/README.md#layerlayer_thinkinputs-weights-bias) will execute the activation

## properties of class layer
* Activation typeof Activation is a function
* ChangeActivation typeof ChangeActivation is a function
* layer_think typeof layer_think is a function
* ord (OrderOfActivation) typeof ord is a number

# optimizer

###### **Note that optimizers self compute itselves**
## optimizer.Update(t, weights, bias, dw, db)
_returns evaluated bias and weights_
* t typeof t must be a number (iteration number, or/ known as time)
* weights typeof weights must be a decimal number between 0-1
* bias typeof bias must be a decimal number between 0-1
* dw typeof dw must be a decimal number between 0-1 derivated from the weights
* db typeof db must be a decimal number between 0-1 derivated from the bias
## properties of class optimizer
* m_dw typeof m_dw must be a decimal number between 0-1 derivated from the weights
* m_db typeof n_db must be a decimal number between 0-1 derivated from the bias
* beta1 typeof beta1 must be a decimal number used for optimization
* beta2 typeof beta2 must be a decimal number used for optimization
* epsilon typeof epsilon must be an insanely low number, for not dividing by 0
* eta typeof eta must be a decimal number between 0-1, usually known as learning rate

# Neural Networks

## module.Create_neuronal_network(name, layers)
_returns a neural network object and stores it in a folder inside the module_
* name typeof name must be a string
* layers typeof layers must be a table with layer objects
## NeuralNetwork.Train(inputs, outputs, optim, iterations, printq)
_trains the neural network with the given inputs and outputs_
* inputs typeof inputs must be a table with the inputs
* outputs typeof outputs must be a table with the outputs
* optim typeof optim must be a optimizer object
* iterations typeof iterations must be a number, which will be the number of times the neural network will be trained
* printq typeof printq must be a boolean value, it'll specify whether it should print the results after each iteration, or not
## NeuralNetwork.TrainCompleted:Connect(function)
_executes the function given, when the train is completed, must be fired after the Train function is called_
* function typeof function must be a function
## NeuralNetwork.TestBias(optim)
_executes a test of the optimizer, based on the bias_
* optim typeof optim must be a optimizer object
## NeuralNetwork.TestWeights(optim)
__executes a test of the optimizer, based on the weights_
* optim typeof optim must be a optimizer object
## NeuralNetwork.run(input, layer)
_returns a guess based on the input, and the layer, pass "general" through the layer argument, to get a general prediction_
* input typeof input must be a table with the inputs
* layer typeof layer must be a layer object or "general" as stated before
## properties of class Neural Network
* TestBias typeof TestBias is a function
* TestWeights typeof TestWeights is a function
* Train typeof train is a function
* TrainCompleted typeof TrainCompleted is a boolean, will be fired when the train is completed
* bias-1 typeof bias-1 is a table with all the previous bias
* weights-1 typeof weights-1 is a table with all the previous weights
* run typeof run is a function
* layers typeof layers is a table with all the layer objects

# all existing activations
* tanh
* sigmoid
* relu
* softmax

#all existing optimizers
* Adam
