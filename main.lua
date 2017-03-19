local text = 'hi'

function love.draw(d)
	local selected,offset = get_selected()
	--print(selected,offset.x..','..offset.y)
	love.graphics.setColor(255, 255, 255, alpha)
	love.graphics.print(text,200,200)
	render(d)
end

function love.textinput(t)
	text = text..t
	print(text)
end

function love.keypressed(key)
	if key == "backspace" then
		text = text:sub(1,#text-1)
		print(text)
	end
end

function love.load(func, chunkname)
	love.keyboard.setKeyRepeat(true)

	require('settings')
	require('vector2')
	require('workspace')
	require('mouse')
	require('render')
end