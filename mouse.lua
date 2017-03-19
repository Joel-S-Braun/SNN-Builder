mouse = {}

mouse.position = vector2.new(0,0)

local function move_mouse(obj)

end

function get_selected()
	mouse.position.x = love.mouse.getX()
	mouse.position.y = love.mouse.getY()

	if love.keyboard.isDown("a") then

	end

	if love.keyboard.isDown("m") and mouse.hover then
		print('dragging')
		mouse.hover.position = mouse.position-mouse.hover_offset
	end

	mouse.hover = nil
	mouse.hover_offset = nil

	for name,child in pairs(workspace:getchildren()) do
		local offset = mouse.position-child.position
		if offset.x <= 50 and offset.y <= 50 then
			mouse.hover_offset = offset
			mouse.hover = child
		end
	end
end