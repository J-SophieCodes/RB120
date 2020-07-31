=begin
1. Write a textual description of the problem or exercise.
   
    Rock, Paper, Scissors is a two-player game where each player chooses
    one of three possible moves: rock, paper, or scissors. The chosen moves
    will then be compared to see who wins, according to the following rules:

    - rock beats scissors
    - scissors beats paper
    - paper beats rock

    If the players chose the same move, then it's a tie.

2. Extract the major nouns and verbs from the description.
   
    Nouns: player, move, rule
    Verbs: choose, compare

3. Organize and associate the verbs with the nouns.

    Player
    - choose
    Move (no associated verbs)
    Rule (no associated verbs)

    - compare (no associated noun)

4. The nouns are the classes and the verbs are the behaviors 
    or methods. 
=end

class Player
attr_accessor :move, :name

  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end

  def set_name
    if human?
      n = nil
      loop do
        puts "What's your name?"
        n = gets.chomp
        break unless n.empty?
        puts "Sorry, must enter a value."
      end
      self.name = n
    else
      self.name = %w(R2D2 Hal Chappie Sonny).sample
    end
  end

  def choose
    if human?
      choice = nil
      loop do
        puts "Please choose rock, paper, or scissors?"
        choice = gets.chomp
        break if %w(rock paper scissors).include? choice
        puts "Sorry, invalid choice."
      end
      self.move = choice
    else
      self.move = %w(rock paper scissors).sample
    end
  end

  def human?
    @player_type == :human
  end
end

# Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize 
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_winner
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"

    case human.move
    when 'rock'
      puts "It's a tie!" if computer.move == 'rock'
      puts "#{human.name} won!" if computer.move == 'scissors'
      puts "#{computer.name} won!" if computer.move == 'paper'
    when 'paper'
      puts "It's a tie!" if computer.move == 'paper'
      puts "#{human.name} won!" if computer.move == 'rock'
      puts "#{computer.name} won!" if computer.move == 'scissors'
    when 'scissors'
      puts "It's a tie!" if computer.move == 'scissors'
      puts "#{human.name} won!" if computer.move == 'paper'
      puts "#{computer.name} won!" if computer.move == 'rock'
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if %w(y n).include? answer.downcase
      puts "Sorry, must be y or n."
    end
    return true if answer == "y"
    return false
  end

  def play # objects required to facilitate the game
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play