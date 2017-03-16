function love.draw(d)
	render(d)
end

function love.load(func, chunkname)
	require('settings')
	require('vector2')
	require('workspace')
	require('render')
end