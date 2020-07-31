# Keep track of a history of moves
require 'pry'

class Move
  @@log = {}

  VALUES = %w(rock paper scissors lizard spock)

  def initialize(player = self)
    @@log[player] = []
  end

  def self.create(value)
    case value
    when 'rock' then Rock.new
    when 'paper' then Paper.new
    when 'scissors' then Scissors.new
    when 'spock' then Spock.new
    when 'lizard' then Lizard.new
    end
  end

  def self.log(player, move)
    @@log[player] << create(move)
  end

  def self.current(player)
    @@log[player].last
  end

  def self.display
    puts "<< Hisory of Moves >>"

    p1, p2 = @@log.keys
    @@log[p1].zip(@@log[p2]).each_with_index do |(a, b), idx|
      puts "Round #{idx+1}: #{p1} played #{a}. #{p2} played #{b}."
    end

    puts
  end

  def self.reset
    @@log.each {|player, _| @@log[player] = [] }
  end

  def to_s
    self.class.to_s.downcase
  end
end

class Rock < Move
  def >(other)
    other.class == Scissors || other.class == Lizard
  end
end

class Paper < Move
  def >(other)
    other.class == Rock || other.class == Spock
  end
end

class Scissors < Move
  def >(other)
    other.class == Paper || other.class == Lizard
  end
end

class Spock < Move
  def >(other)
    other.class == Scissors || other.class == Rock
  end
end

class Lizard < Move
  def >(other)
    other.class == Spock || other.class == Paper
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    Score.new(self)
    Move.new(self)
    @move = nil
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
      puts "Please choose rock, paper, scissors, spock, or lizard?"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.log(self, choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 Hal Chappie Sonny).sample
  end

  def choose
    self.move = Move.log(self, Move::VALUES.sample)
  end
end

class Score
  @@scores = {}
  WIN = 3

  def initialize(player)
    @@scores[player] = 0
  end

  def self.increment(player)
    @@scores[player] += 1
  end

  def self.someone_won?
    @@scores.value?(WIN)
  end

  def self.champion
    @@scores.key(WIN)
  end

  def self.display
    puts "<< Scoreboard >>"

    @@scores.each do |player, score|
      puts "#{player}'s score': #{score}"
    end

    puts
  end

  def self.reset
    @@scores.each {|player, _| @@scores[player] = 0 }
  end

  def to_s
    value
  end
end

# Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    system 'clear'
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Spock, Lizard!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Good bye!"
  end

  def display_moves
    puts
    puts "#{human} chose #{Move.current(human)}"
    puts "#{computer} chose #{Move.current(computer)}"
    puts
  end

  def display_winner
    if Move.current(human) > Move.current(computer)
      Score.increment(human)
      puts "#{human} won!"
    elsif Move.current(computer) > Move.current(human)
      Score.increment(computer)
      puts "#{computer} won!"
    else
      puts "It's a tie!"
    end

    puts
  end

  def display_champion
    puts "#{Score.champion} is the champion!"
    puts
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

  def continue?
    puts "Press enter to continue..."
    gets
  end

  def play # objects required to facilitate the game
    display_welcome_message
    loop do
      loop do
        system 'clear'
        Score.display
        human.choose
        computer.choose
        display_moves
        display_winner
        continue?
        break if Score.someone_won?
      end

      system 'clear'
      Move.display
      Score.display
      display_champion

      break unless play_again?

      Score.reset
      Move.reset
    end
    display_goodbye_message
  end
end

RPSGame.new.play
