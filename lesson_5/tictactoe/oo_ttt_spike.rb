require 'pry'
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def [](key)
    @squares[key]
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!detect_winner
  end

  def markers_at(a, b, c)
    @squares.values_at(a, b, c).map(&:marker)
  end

  def detect_winner
    WINNING_LINES.each do |a, b, c|
      if markers_at(a, b, c).none?(" ") && markers_at(a, b, c).uniq.size == 1
        return @squares[a].marker
      end
    end
    nil
  end

  def to_s
    unmarked_keys.join(", ").sub(/(.)$/, 'or \1')
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker 

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board(clear = true)
    system 'clear' if clear
    puts "You are #{human.marker}. Computer is #{computer.marker}."
    puts
    puts "1      |2      |3"
    puts "   #{board[1]}   |   #{board[2]}   |   #{board[3]}   "
    puts "       |       |"
    puts "-------+-------+-------"
    puts "4      |5      |6"
    puts "   #{board[4]}   |   #{board[5]}   |   #{board[6]}   "
    puts "       |       |"
    puts "-------+-------+-------"
    puts "7      |8      |9"
    puts "   #{board[7]}   |   #{board[8]}   |   #{board[9]}   "
    puts "       |       |"
    puts
  end

  def human_moves
    puts "Choose a square: #{board}:"
    square = nil
    loop do 
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    
    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def display_result
    display_board

    case board.detect_winner
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "The board is full!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n."
    end
    
    answer == "y"
  end

  def play
    system 'clear'
    display_welcome_message
    
    loop do
      display_board(false)

      loop do
        human_moves
        break if board.someone_won? || board.full?
        computer_moves
        break if board.someone_won? || board.full?
        display_board
      end

      display_result
      break unless play_again?
      
      board.reset
      system 'clear'
      puts "Let's play again!"
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play