workspace = (love.filesystem.load('workspace_'..settings.ai_model..'.lua') or function() return {} end)() -- :^)
for i,v in pairs(workspace) do -- disgostin i know
    if type(v) == 'table' then
        function v:destroy()
            local object = v
            object.real = false
            workspace[object.name] = nil
            local meta = getmetatable(object) or {}
            meta.__mode = 'v'
            for i,_ in pairs(object) do
                print(i)
                object[i] = nil
            end
            setmetatable(object, meta)
        end
    end
end

local ftype = type
function clone_table(t)
	local new = {}
	for i,v in pairs(t) do
		new[i] = v
	end
	local meta = getmetatable(t)
	if meta then
		setmetatable(new,meta)
	end
	return  new
end

local default = { -- coulda just used switch function but im cool xd
    input = {}, -- format = [tick()] = {intensity,type},
    connections={},
    synthesis='action_p',
}

types = {
	input_neuron = {"connections","synthesis","input"},
	hidden_neuron= {"connections","synthesis","input"},
	output_neuron= {"connections","synthesis","input"},
	soft_mem_neuron={"connections","synthesis","input"},
}

 function workspace:new_connection(from,to,v)
	from.connections[to] = v
end

function workspace:instance(name,type,position,...)
	local object = {type=type,name=name,position=position,real=true}

	for index,value in pairs(types[type]) do -- fills in default to be ovewritten
		local val = default[value]
		if ftype(val) == 'table' then
			val = clone_table(val)
		end
		object[value] = val
	end
	for index,value in pairs({...}) do
		local property = types[type][index]
		object[property] = value
	end
	function object:destroy()
		object.real = false
		workspace[object.name] = nil
		local meta = getmetatable(object) or {}
		meta.__mode = 'v'
		for i,_ in pairs(object) do
			print(i)
			object[i] = nil
		end
		setmetatable(object, meta)
	end
	workspace[name] = object
	return object
end

function workspace:getchildren()
	local children = {}
	for _,value in pairs(workspace) do
		if  not term and ftype(value) == 'table' and value.position and value.real then
			children[#children+1] = value
		end
	end
	return children
end