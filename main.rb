Player = Struct.new(:name)

class Game 
	def initialize
		O = Player.new("0")
		X = Player.new("X")
	end
end


Game.new
