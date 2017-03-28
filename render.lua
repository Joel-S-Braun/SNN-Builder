local function render_neuron(obj)
	local cl = settings.colours[obj.type]
	love.graphics.setColor(cl[1], cl[2], cl[3])
    if obj.position then
    	love.graphics.rectangle('fill',obj.position.x,obj.position.y,50,50) -- oh vector2s!
    	local len = 0
        for to,weight in pairs(obj.connections) do
            if to and to.real then
                local inverse
                local cl = settings.colours[obj.synthesis]
                if weight < 0 then
                    inverse = true
                end
                if inverse then
                    love.graphics.setColor(255-cl[1],255-cl[2],255-cl[3],-(weight*255))
                else
                    love.graphics.setColor(cl[1],cl[2],cl[3],(weight*255))
                end
                love.graphics.line(obj.position.x+25,obj.position.y,to.position.x+25,to.position.y+50)
            else
                obj.connections[to] = nil
            end
        end

        --synthesis col
        local sum_color = settings.colours[obj.synthesis]
        love.graphics.setColor(sum_color[1]/2,sum_color[2]/2,sum_color[3]/2)
        love.graphics.rectangle('fill', obj.position.x+10, obj.position.y+10, 50-20, 50-20) -- boo add size to settings
        
        --activation
        local activated = ((workspace:get_activation(obj)/10) + (2.5/10))*255
        love.graphics.setColor(activated,activated,activated) -- makes it reference activation. ironically that will make snn run
        love.graphics.rectangle('fill',obj.position.x+15,obj.position.y+15,50-30,50-30)
        
        --name
        love.graphics.setColor(0,253,253)
        love.graphics.printf(obj.name, obj.position.x, obj.position.y, 50, 'left', r, sx, sy, ox, oy, kx, ky)
    end
end

local render_function = {
	hidden_neuron = render_neuron,
	input_neuron = render_neuron,
	output_neuron = render_neuron,
	soft_mem_neuron = render_neuron
}

local function render_select(s)
	if input['selected'..s] then
        local pos = input['selected'..s].position
        if pos then
            local cl = settings.colours['selected'..s]

    		love.graphics.setColor(cl[1], cl[2], cl[3])
    		love.graphics.rectangle('fill', pos.x-3, pos.y-3, 56, 56)
        else
            input['selected'..s] = nil
        end
	end
end

function render(delta) -- possibly need to order so that input render first?

    local types = {}
    local total_connections = 0
    
	render_select(1)
	render_select(2)
    print('')
	for _,object in pairs(workspace:getchildren()) do -- potentially want to run SORTED (as in, inputs first?) just so the SNN runs in order
        for to_obj,weight in pairs(object.connections) do
            if approx_equal(weight,0,1) then
                object.connections[to_obj] = nil
            else
                total_connections = total_connections + 1 
            end
        end
        types[object.type] = (types[object.type] or 0) + 1
		render_function[object.type](object)
	end
    love.graphics.printf('Editing: '..settings.ai_model,0,0,12 * 50,'left')
    local len = 0
    local total = 0
    
    for i,v in pairs(types) do
        if v then
            total = total+v
            len = len + 1
            love.graphics.printf(i..' count: '..v,0,len*16,12*50,'left')
        end
    end
    love.graphics.printf('total neuron count: '..total,0,(len+1)*16,12*50,'left')
    love.graphics.printf('total connection count: '..total_connections,0,(len+2)*16,12*50,'left')
    love.graphics.printf('gametime: '..(math.floor(gametime*10))..'ms',0,(len+3)*16,12*50,'left')
    love.graphics.printf('fps: '..love.timer:getFPS(),0,(len+4)*16,12*50,'left')
end