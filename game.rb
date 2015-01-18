Player = Struct.new(:name)

class Game

  @@table = Array.new(3){ Array.new(3){' '} }
  @@counter = 1

  def initialize
    puts 'Welcome to the game!'

    @o = Player.new('0')
    @x = Player.new('X')

    @currentPlayer = @o.name
    puts "You are #{@currentPlayer}!"

    question
  end

  def question params = ''
    draw_table

    puts "\n\nIt's #{params}#{@currentPlayer}'s turn!"
    puts 'Where would you like to move? (Ex: A1, A2, etc):'

    check_answer gets.chomp
  end

  def check_answer answer

    #check is the answer is in correct format
    unless answer =~ /^[abcABC][123]$/
      puts "Woops something bad's going on in here!"
      question 'still '
    else
      #split answer into the row and column values
      row, column = answer.split ''
      row = row.upcase.ord - 65
      column = column.to_i - 1

      #checkin if the place is already taken
      check_result unless check_place_taken row, column
    end

  end

  def check_result

    if game_over
      draw_table
      puts "\nYay! #{@currentPlayer} won the game"
    elsif check_draw
      draw_table
      puts 'Draw!'
    else
      #switching the player
      @currentPlayer = @currentPlayer == @x.name ? @o.name : @x.name
      @@counter += 1 #counting the turns
      question
    end

  end

  def check_draw

    @@counter == 9 ? true : false

  end

  def check_place_taken row, column
    taken = false

    if @@table[row][column] == ' '
      @@table[row][column] = @currentPlayer
    else
      puts 'Sorry bro, the place is taken'
      question 'still '
      taken = true
    end

    taken
  end

  def game_over
    key = @currentPlayer.ord * 3
    over = false

    #cheking rows
    @@table.each do |x|
      over = true if get_key(x) == key
    end

    #cheking columns
    @@table.transpose.each do |x|
      over = true if get_key(x) == key
    end

    #chekin diagonals
    over = true if get_key(@@table.flatten.values_at(2, 4, 6)) == key ||
        get_key(@@table.flatten.values_at(0, 4, 8)) == key

    over
  end

  def get_key param

    param.join.split('').map(&:ord).inject(:+)

  end

  def draw_table
    countLines = 0

    @@table.each do |item|
      print item * '|'
      countLines += 1
      puts "\n-----" if countLines < 3
    end

  end

end