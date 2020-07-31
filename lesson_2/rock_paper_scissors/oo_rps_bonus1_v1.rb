# Keeping score as a state of an existing class

class Move
  VALUES = %w(rock paper scissors)

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def >(other)
    (rock? && other.scissors?) ||
      (paper? && other.rock?) ||
      (scissors? && other.paper?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    @score = 0
    @move = nil
    set_name
  end

  def reset_score
    self.score = 0
  end

  def to_s
    name
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors?"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 Hal Chappie Sonny).sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  WINNING_SCORE = 3

  def initialize
    system 'clear'
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_moves
    puts "#{human} chose #{human.move}"
    puts "#{computer} chose #{computer.move}"
  end

  def display_winner
    if human.move > computer.move
      human.score += 1
      puts "#{human} won!"
    elsif computer.move > human.move
      computer.score += 1
      puts "#{computer} won!"
    else
      puts "It's a tie!"
    end
  end

  def someone_won?
    human.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def display_grand_winner
    case human.score <=> computer.score
    when 1
      puts "#{human} is the champion!"
    when -1
      puts "#{computer} is the champion!"
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
    return false if answer == "n"
    return true if answer == "y"
  end

  def display_scores
    puts "#{human}: #{human.score}"
    puts "#{computer}: #{computer.score}"
  end

  def continue?
    puts "Press enter to continue..."
    gets
  end

  def play # objects required to facilitate the game
    display_welcome_message
    loop do
      loop do
        system 'clear'
        display_scores
        human.choose
        computer.choose
        display_moves
        display_winner
        continue?
        break if someone_won?
      end

      system 'clear'
      display_scores
      display_grand_winner

      break unless play_again?

      human.reset_score
      computer.reset_score
    end
    display_goodbye_message
  end
end

RPSGame.new.play
