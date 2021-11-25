--!nonstrict
local ia = {
	optim = {
		Adam = {};
	};
	activations = {deriv = {};};
	layers = {};
	neuronal_networks = {};
}
local e = 2.71828
function ia.DotProduct(x, y)
	local res = {}
	for i, v in pairs(y) do
		table.insert(res, x[i] * y[i])
	end
	return res
end
function ia.Multiply2dArray(x, y)
	local res = {}
	for i, v in pairs(y) do
		table.insert(res, x[i] * y[i])
	end
	return res
end
function ia.Multiply(x, y)
	local res = {}
	for i, v in pairs(x) do
		table.insert(res, x[i] * y)
	end
	return res
end
function ia.less2dArray(x, y)
	local res = {}
	for i, v in pairs(y) do
		table.insert(res, x[i] - y[i])
	end
	return res
end
local function check(a, b) return a[b] end
local DotProduct = ia.DotProduct
function ia.compute_loss(x)
	return x^2-2*x+1
end
function ia.grad(x)
	return 2*x-2
end
local function compute_Adam()
	ia.optim.Adam["m_dw"], ia.optim.Adam["v_dw"] = 0, 0
	ia.optim.Adam["m_db"], ia.optim.Adam["v_db"] = 0, 0
	ia.optim.Adam["beta1"] = 0.9
	ia.optim.Adam["beta2"] = 0.999
	ia.optim.Adam["epsilon"] = 1e-8
	ia.optim.Adam["eta"] = 0.01
end compute_Adam()
--//
function ia.optim.Adam.Update(t, weights, bias, dw, db)
	local self = ia.optim.Adam
	self.m_dw = self.beta1*self.m_dw + (1-self.beta1)*dw
	self.m_db = self.beta1*self.m_db + (1-self.beta1)*db
	self.v_dw = self.beta2*self.v_dw + (1-self.beta2)*(dw^2)
	self.v_db = self.beta2*self.v_db + (1-self.beta2)*(db^2)
	local m_dw_corr = self.m_dw/(1-self.beta1^t)
	local m_db_corr = self.m_db/(1-self.beta1^t)
	local v_dw_corr = self.v_dw/(1-self.beta2^t)
	local v_db_corr = self.v_db/(1-self.beta2^t)
	local w = weights - self.eta*(m_dw_corr/(math.sqrt(v_dw_corr)+self.epsilon))
	local b = bias - self.eta*(m_db_corr/(math.sqrt(v_db_corr)+self.epsilon))
	return w, b
end
--//
function ia.activations.tanh(x)
	local res = {}
	for i, v in pairs(x) do
		table.insert(res, math.sinh(x[i])/math.cosh(x[i]))
	end
	return res
end
--//
function ia.activations.sigmoid(x)
	local res = {}
	for i, v in pairs(x) do
		table.insert(res, 1/(1 + (-x[i] * e)))
	end
	return res
end
--//
function ia.activations.relu(x)
	local res = {}
	for i, v in pairs(x) do
		table.insert(res, math.max(0, x[i]))
	end
	return res
end
--//
function ia.activations.softmax(x)
	local res = {}
	for i, v in pairs(x) do
		table.insert(res, x[i] * e/(x[i] * e))
	end
	return res
end
--//
function ia.activations.deriv.sigmoid_derivate(x)
	local res = {}
	local originalFunction = ia.activations.sigmoid(x)
	for i, v in pairs(originalFunction) do
		table.insert(res, originalFunction[i]*(1-originalFunction[i]))
	end
	return res
end
--//
function ia.ComputeActivation(Activation)
	if typeof(Activation) == "function" then
	return Activation else
		return ia.activations[Activation] or ia.activations.deriv[Activation]
	end
end
--//
local folder_of_layers = ia.layers
--//
function ia.layers.Create_Layer(name, ord, Activation)
	local function computeSelf()
		folder_of_layers[name] = {};
		folder_of_layers[name]["Activation"] = ia.ComputeActivation(Activation)
		folder_of_layers[name]["ord"] = ord
	end computeSelf()
	local self = folder_of_layers[name]
	function self.layer_think(inputs, weights, bias)
		local res = ia.Multiply(inputs, weights)
		for i, v in pairs(res) do
			res[i] = res[i] + bias
		end
		return self["Activation"](res)
	end
	function self.ChangeActivation(NewActivation)
		self["Activation"] = NewActivation
	end
	return folder_of_layers[name]
end
--//
function ia.UsePreMadeLayers()
	local PREMADE_LAYERS = {
	ia.layers.Create_Layer("FirstLayerPREMADE", 1, ia.activations.relu),
	ia.layers.Create_Layer("FirstHiddenLayerPREMADE", 2, ia.activations.sigmoid),
	ia.layers.Create_Layer("MiddleLayerPREMADE", 3, ia.activations.tanh),
	ia.layers.Create_Layer("SecondHiddenLayerPREMADE", 4, ia.activations.relu),
	ia.layers.Create_Layer("FinalLayerPREMADE", 5, ia.activations.softmax)} return PREMADE_LAYERS
end
--//
function ia.Create_neuronal_network(name, layers)
	ia.neuronal_networks[name] = {} 
	local self = ia.neuronal_networks[name]
	local name = name
	name = name
	local function computeLayers()
		self["weights-1"] = {}
		self["bias-1"] = {}
		self["TrainComplete"] = {false} 
		self["TrainCompleted"] = {}
		if typeof(layers) == "string" and layers:lower():find("premade") then
			self["layers"] = ia.UsePreMadeLayers()
			return self["layers"]
		else
			self["layers"] = layers
			return self["layers"]
		end
	end local layers = computeLayers()
	--//
	function self.run(input, layerz)
		local array = {}
		if layerz == "general" or layerz == nil then
			for i = 1,#self["layers"] do
				for i, v in pairs(self["layers"]) do
					if v["ord"] == i then
						if i == 1 then
							table.insert(array, v.layer_think(input, self["weights"], self["bias"]))
						else
							table.insert(array, v.layer_think(array[i-1], self["weights"], self["bias"]))
						end
					end
				end
			end
			return array[#array-1]
		else
			return layerz.layer_think(input, self["weights"], self["bias"])
		end
	end
	--//
	function self.TrainCompleted:Connect(functionCalled)
			for i,v in pairs(ia.neuronal_networks) do
				if tostring(i) == tostring(name) then
				for i=1, 10000 do
					if unpack(v.TrainComplete) == true then
						functionCalled()
						v.TrainComplete = {false}
					end
					wait(0.004)
				end
				end
			end
	end
	--//
	function self.Train(inputs, outputs, optim, iterations, printq)
		local generator = Random.new(tick()) 
		if (self["weights"]) then else 
			self["weights"] = generator:NextNumber(0, 1)
			self["bias"] = generator:NextNumber(0, 1)
		end
		table.insert(self["weights-1"],1, self["weights"]) table.insert(self["bias-1"],1, self["bias"])
		for i = 1,iterations do
			local result = self.run(inputs, "general")
			if (printq == true) then print(i.."/"..iterations.." completed") print(unpack(result)) end
			local dw, db = ia.grad(self.weights), ia.grad(self.bias)
			self["weights"], self["bias"] = optim.Update(i, self.weights, self.bias, dw, db)
			local weightsAnt = self["weights-1"] local biasAnt = self["bias-1"]
			table.insert(self["weights-1"], self["weights"]) table.insert(self["bias-1"], self["bias"])
			task.wait(0.004)
		end
		self.TrainComplete = {true}
	end
	--//
	function self.TestWeights(optim)
		local generator = Random.new(tick()) 
		if (self["weights"]) then else 
			self["weights"] = generator:NextNumber(0, 1)
			self["bias"] = generator:NextNumber(0, 1)
		end
		table.insert(self["weights-1"],1, self["weights"]) table.insert(self["bias-1"],1, self["bias"])
		local converged = false
		local t = 1
		while not converged do
			local dw, db = ia.grad(self.weights), ia.grad(self.bias)
			local weightsbef = self.weights
			self["weights"], self["bias"] = optim.Update(t, self.weights, self.bias, dw, db)
			if weightsbef == self.weights then
				print("Finally converged, after "..t.." iterations")
				break
			else
				print('iteration '..t..': weight='..self.weights)
				t = t+1
			end
			task.wait(0.004)
		end
	end
	--//
	function self.TestBias(optim)
		local generator = Random.new(tick()) 
		if (self["weights"]) then else 
			self["weights"] = generator:NextNumber(0, 1)
			self["bias"] = generator:NextNumber(0, 1)
		end
		table.insert(self["weights-1"],1, self["weights"]) table.insert(self["bias-1"],1, self["bias"])
		local converged = false
		local t = 1
		while not converged do
			local dw, db = ia.grad(self.weights), ia.grad(self.bias)
			local biasbef = self.bias
			self["weights"], self["bias"] = optim.Update(t, self.weights, self.bias, dw, db)
			if biasbef == self.bias then
				print("Finally converged, after "..t.." iterations")
				break
			else
				print('iteration '..t..': bias='..self.bias)
				t = t+1
			end
			task.wait(0.004)
		end
	end
	
	--//
	return self
end

return ia
