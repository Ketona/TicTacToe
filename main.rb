Player = Struct.new(:name)

class Game 
	$table = Array.new(3, Array.new(3, ' '))
	def initialize

		puts "Welcome to the game!"

		@o = Player.new("0")
		@x = Player.new("X")

		puts "You are 0!"
		@currentPlayer = @o.name

		self.Question

	end


	def Question
		self.DrawTable
		puts "\n\nIt's #{@currentPlayer}'s turn!"

		puts "Where would you like to move? (Ex: A1, A2, etc):"

		answer = gets.chomp

		@currentPlayer = @currentPlayer == @x.name ? @o.name : @x.name
	end

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


