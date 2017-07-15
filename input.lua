input = {}
input.mposition = vector2.new(0,0)

function love.keypressed(key) -- change name UNLESS modify exists
	if key == 'escape' then
		input.selected1 = nil
		input.selected2 = nil
	end
    if key == '=' then
        local file = ser(workspace)
        love.filesystem.write('workspace_'..settings.ai_model..'.lua',file)
    end
	if key == 'space' then
		key = ' '
	end
	local instance = settings.instance_key[key]
	local increment = settings.increment[key]
    local synthesis = settings.synthesis[key]
    local fire_neuron = settings.fire_neuron[key]
    
	if key == 'x' and input.hover then
		input.hover:destroy()
	end
	if (input.hover and input.hover.name) and not input.selected1 and not input.selected2 and (#key == 1 or key == 'backspace') then -- gross
		local newname
		if key == 'backspace' then
			newname = input.hover.name:sub(1,#input.hover.name-1)
		elseif #key == 1 then
			newname = input.hover.name..key
		else
			return
		end
		if not workspace[newname] and newname then
			workspace[newname] = input.hover
			workspace[input.hover.name] = nil

			input.hover.name = newname
		end
	elseif (not input.hover) and not input.selected1 and not input.selected2 and key == '.' then
    	
	elseif input.selected1 and synthesis and not input.selected2 then
        input.selected1.synthesis = synthesis
    elseif input.selected2 and increment then
        input.selected1.connections[input.selected2] = input.selected1.connections[input.selected2] or 0
        input.selected1.connections[input.selected2] = math.max(math.min(input.selected1.connections[input.selected2]+increment,1),-1)
	elseif instance and not (input.selected1 or input.selected2) then
		workspace:instance(tostring(love.math.random(1000)),instance,input.mposition+vector2.new(0,0))
	elseif key == 'return' and input.hover then
		if input.selected1 == input.hover then
			input.selected1 = nil
		elseif input.selected2 == input.hover then
			input.selected2 = nil
		elseif not input.selected1 then
			input.selected1 = input.hover
		elseif not input.selected2 and input.selected1 then
			input.selected2 = input.hover
		end
    elseif key == ' ' then
        settings.paused=not settings.paused
    elseif key == 'g' then
        local grid = 50 + settings.grid
        for i,v in pairs(workspace:getchildren()) do
           v.position = vector2.new(math.floor(v.position.x/grid + 0.5)*grid + (grid-50),math.floor(v.position.y/grid + 0.5)*grid+(grid-50)) 
        end
	end
end

function input.update()
	input.mposition.x = love.mouse.getX()
	input.mposition.y = love.mouse.getY()

	if love.mouse.isDown(1) and input.hover then
		input.hover.position = input.mposition-input.hover_offset
	end

	input.hover = nil
	input.hover_offset = nil

	for name,child in pairs(workspace:getchildren()) do
		local offset = input.mposition-child.position
		if math.abs(offset.x) == offset.x and math.abs(offset.y) == offset.y and 
			(offset.x) <= 50 and (offset.y) <= 50 then
			input.hover_offset = offset
			input.hover = child
		end
    end

    if input.selected1~=(input.hover or '') and input.selected2~=(input.hover or '') then --
	    if love.keyboard.isDown("1") then
	        input.selected1 = input.hover
	    elseif love.keyboard.isDown("2") then
	        input.selected2 = input.hover
  		end
	end
end