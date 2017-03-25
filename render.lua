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

        local sum_color = settings.colours[obj.synthesis]
        
        love.graphics.setColor(sum_color[1]/2,sum_color[2]/2,sum_color[3]/2)
        
        love.graphics.rectangle('fill', obj.position.x+10, obj.position.y+10, 50-20, 50-20) -- boo add size to settings
        
        love.graphics.setColor(255,255,255)
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

function render(delta)
    love.graphics.printf('Editing: '..settings.ai_model,0,0,12 * 50,'center')
    
	render_select(1)
	render_select(2)

	for _,object in pairs(workspace:getchildren()) do
		render_function[object.type](object)
	end
end