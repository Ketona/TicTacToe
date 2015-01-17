Player = Struct.new(:name)

class Game 
	$table = Array.new(3, Array.new(3, 'a'))
	def initialize

		puts "Welcome to the game!"

		@o = Player.new("0")
		@x = Player.new("X")
	end

	public
	def DrawTable
		counter = 0
		$table.each do |item|
			print item * '|'
			counter += 1
			puts "\n-----" if counter < 3
		end
	end
end

game = Game.new
game.DrawTable


