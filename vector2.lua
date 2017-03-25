vector2 = {
	x=0,
	y=0,
	__index = {
		magnitude = function(self)
			return (self.x^2+self.y^2)^0.5
		end,
	},
	__add = function(self,vec,...)
		print(self,vec,...,'innit')
		return vector2.new(self.x+vec.x,self.y+vec.y)
	end,

	__sub = function(self,vec)
		return vector2.new(self.x-vec.x,self.y-vec.y)
	end
}


function vector2.new(x,y)
	return setmetatable({x=x,y=y}, vector2)
end
