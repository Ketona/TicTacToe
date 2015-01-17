Player = Struct.new(:name)

class Game 
	$table = Array.new(3){ Array.new(3){' '} }
	def initialize

		puts "Welcome to the game!"

		@o = Player.new("0")
		@x = Player.new("X")

		@currentPlayer = @o.name
		puts "You are #{@currentPlayer}!"

		self.Question
	end


	def Question
		self.DrawTable
		puts "\n\nIt's #{@currentPlayer}'s turn!"
		puts "Where would you like to move? (Ex: A1, A2, etc):"

		answer = gets.chomp
		self.CheckAnswer answer

		@currentPlayer = @currentPlayer == @x.name ? @o.name : @x.name
	end

	def CheckAnswer answer
		puts "Woops something bad's going on in here!" unless answer =~ /^[abcABC][123]$/

		row, column = answer.split ""
		row = row.upcase.ord - 65
		column = column.to_i - 1
		$table[row][column] = @currentPlayer
		self.DrawTable

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


