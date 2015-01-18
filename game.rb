class Game
  @@table = Array.new(3){ Array.new(3){' '} }
  @@counter = 1
  def initialize

    puts 'Welcome to the game!'

    @o = Player.new('0')
    @x = Player.new('X')

    @currentPlayer = @o.name
    puts "You are #{@currentPlayer}!"

    self.Question
  end

  def Question params = ''
    self.DrawTable

    puts "\n\nIt's #{params}#{@currentPlayer}'s turn!"
    puts 'Where would you like to move? (Ex: A1, A2, etc):'

    self.CheckAnswer gets.chomp
  end

  def CheckAnswer answer
    #check is the answer is in correct format
    unless answer =~ /^[abcABC][123]$/
      puts "Woops something bad's going on in here!"
      self.Question 'still '
    else
      #split answer into the row and column values
      row, column = answer.split ''
      row = row.upcase.ord - 65
      column = column.to_i - 1

      #checkin if the place is already taken
      unless self.CheckPlaceTaken row, column
        #checkin is the game should continue
        self.CheckResult
      end
    end
  end

  def CheckResult
    if self.GameOver
      self.DrawTable
      puts "\nYay! #{@currentPlayer} won the game"
    elsif self.CheckDraw
      self.DrawTable
      puts 'Draw!'
    else
      #switching the player
      @currentPlayer = @currentPlayer == @x.name ? @o.name : @x.name
      @@counter += 1 #counting the turns
      self.Question
    end
  end

  def CheckDraw
    @@counter == 9 ? true : false
  end

  def CheckPlaceTaken row, column
    taken = false
    if @@table[row][column] == ' '
      @@table[row][column] = @currentPlayer
    else
      puts 'Sorry bro, the place is taken'
      self.Question 'still '
      taken = true
    end
    taken
  end

  def GameOver
    key = @currentPlayer.ord * 3
    over = false
    #cheking rows
    @@table.each do |x|
      over = true if self.GetKey(x) == key
    end
    #cheking columns
    @@table.transpose.each do |x|
      over = true if self.GetKey(x) == key
    end
    #chekin diagonals
    over = true if self.GetKey(@@table.flatten.values_at(2, 4, 6)) == key || GetKey(@@table.flatten.values_at(0, 4, 8)) == key
    over
  end

  def GetKey param
    param.join.split('').map(&:ord).inject(:+)
  end

  def DrawTable
    countLines = 0
    @@table.each do |item|
      print item * '|'
      countLines += 1
      puts "\n-----" if countLines < 3
    end
  end
end