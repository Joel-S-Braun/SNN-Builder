workspace = {}

local types = {
	input_neuron = {},
	hidden_neuron= {},
	output_neuron= {},
}

function workspace:instance(name,type,position,...)
	local object = {type=type,name=name,position=position}
	for index,value in pairs({...}) do
		local property = types[type][index]
		object[property] = value
	end
	workspace[name] = object
end

function workspace:getchildren()
	local children = {}
	for _,value in pairs(workspace) do
		if type(value) == 'table' then
			children[#children+1] = value
		end
	end
	return children
end

workspace:instance('bethesda','hidden_neuron',vector2.new(0,0))
--[[





]]