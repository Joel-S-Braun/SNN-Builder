local render_function = {
	hidden_neuron = function(obj)
		local cl = settings.colours[obj.type]
		love.graphics.setColor(cl[1], cl[2], cl[3])
		love.graphics.rectangle('fill',obj.position.x,obj.position.y,50,50) -- oh vector2s!
	end
}

function render(delta)
	for _,object in pairs(workspace:getchildren()) do
		render_function[object.type](object)
	end
end
