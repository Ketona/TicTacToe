Player = Struct.new(:name)

class Game 
	$table = Array.new(3){ Array.new(3){' '} }
	@@counter = 1
	def initialize

		puts "Welcome to the game!"

		@o = Player.new("0")
		@x = Player.new("X")

		@currentPlayer = @o.name
		puts "You are #{@currentPlayer}!"

		self.Question
	end

	def Question params = ""
		self.DrawTable

		puts "\n\nIt's #{params}#{@currentPlayer}'s turn!"
		puts "Where would you like to move? (Ex: A1, A2, etc):"

		answer = gets.chomp
		self.CheckAnswer answer

	end

	def CheckAnswer answer
		#check is the answer is in correct format
		unless answer =~ /^[abcABC][123]$/
			puts "Woops something bad's going on in here!"
			self.Question "still "
		end

		#split answer into the row and column values
		row, column = answer.split ""
		row = row.upcase.ord - 65
		column = column.to_i - 1

		#checkin if the place is already taken
		self.CheckPlaceTaken row, column

		#checkin is the game should continue
		self.CheckResult
	end

	def CheckResult
		if self.GameOver
			puts "Yay! #{@currentPlayer} won the game"
		elsif self.CheckDraw
			puts "Draw!"
		else
			@currentPlayer = @currentPlayer == @x.name ? @o.name : @x.name
			@@counter += 1
			self.Question
		end
	end

	def CheckDraw
		@@counter == 9 ? true : false
	end

	def CheckPlaceTaken row, column
		if $table[row][column] == " "
			$table[row][column] = @currentPlayer
		else
			puts "Sorry bro, the place is taken"
			self.Question "still "
		end
	end

	def GameOver
		false
	end

	def DrawTable
		counter = 0
		$table.each do |item|
			print item * '|'
			counter += 1
			puts "\n-----" if counter < 3
		end
		p $table
	end
end

Game.new


