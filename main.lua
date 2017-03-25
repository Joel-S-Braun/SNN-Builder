local fprint = print

function love.draw(d)
	--v=binser.serialize{a='ur dadda'}
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
	love.filesystem.write('workspace_'..settings.ai_model..'.lua',file)
    
	--local chunk = love.filesystem.load('workspace_persistant.lua')
end

function love.load(func, chunkname)
	fprint('consoley')
	love.keyboard.setKeyRepeat(true)
	
    require('ser')
	require('settings')
	require('vector2')
	require('workspace')
	require('input')
	require('render')
end