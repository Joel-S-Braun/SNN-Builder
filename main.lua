function love.draw(d)
    gametime = gametime + settings.step
    input.update()
	render(d)
end

function love.quit()
	--format
	for i,v in pairs(workspace) do
        if type(v) == 'table' then
            v.destroy = nil
        elseif type(v) == 'function' then
            workspace[i] = nil
        end
	end --]]
	local file = ser(workspace)
	if settings.ai_model ~= 'no save' then
		love.filesystem.write('workspace_'..settings.ai_model..'.lua',file)
	end
    
	--local chunk = love.filesystem.load('workspace_persistant.lua')
end

function love.load(func, chunkname)
	print('what')
<<<<<<< HEAD
<<<<<<< HEAD

=======
>>>>>>> origin/master
=======
>>>>>>> origin/master
	font = love.graphics.setNewFont(11)
	love.keyboard.setKeyRepeat(true)
	
    require('ser')
	require('settings')
	require('vector2')
	require('workspace')
	require('input')
	require('render')
end