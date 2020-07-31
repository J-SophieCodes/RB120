module Printable
  def to_s
    self.class.to_s.downcase
  end
end

class Rock
  include Printable

  def >(other)
    [Scissors, Lizard].include?(other.class)
  end
end

class Paper
  include Printable

  def >(other)
    [Rock, Spock].include?(other.class)
  end
end

class Scissors
  include Printable

  def >(other)
    [Paper, Lizard].include?(other.class)
  end
end

class Spock
  include Printable

  def >(other)
    [Scissors, Rock].include?(other.class)
  end
end

class Lizard
  include Printable

  def >(other)
    [Spock, Paper].include?(other.class)
  end
end

class Move
  @@log = {}

  VALUES = {
    'rock' => Rock.new,
    'paper' => Paper.new,
    'scissors' => Scissors.new,
    'spock' => Spock.new,
    'lizard' => Lizard.new
  }

  def initialize(player)
    @@log[player] = []
  end

  def self.[]=(player, move)
    @@log[player] << VALUES[move]
  end

  def self.[](player)
    @@log[player].last
  end

  def self.display
    puts
    @@log.each do |player, moves|
      puts "#{player} chose #{moves.last}"
    end
    puts
  end

  def self.history
    puts "<< Hisory of Moves >>"

    p1, p2 = @@log.keys
    @@log[p1].zip(@@log[p2]).each_with_index do |(a, b), idx|
      puts "Round #{idx + 1}: #{p1} played #{a}. #{p2} played #{b}."
    end

    puts
  end

  def self.reset
    @@log.each { |player, _| @@log[player] = [] }
  end

  def self.match_valid_choices(str)
    valid_choices.scan(/\b#{str}\w+/)
  end

  def self.valid_choices
    to_s.sub(/(\w+)$/, 'or \1')
  end

  def self.to_s
    VALUES.keys.join(", ")
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    Score.new(self)
    Move.new(self)
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
      n = gets.chomp.squeeze.strip
      break unless n.empty?
      puts "Must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose #{Move.valid_choices}?"
      choice = Move.match_valid_choices(gets.chomp.downcase)
      break if choice.size == 1
      puts choice.empty? ? "Invalid choice." : "Please be more specific."
    end
    Move[self] = choice.first
  end
end

class Computer < Player
  attr_accessor :personality

  def set_personality
    self.personality =
      Move::VALUES.keys.each_with_object([]) do |type, arr|
        rand(5).times { arr << type }
      end
  end

  def initialize
    super
    set_personality
  end

  def set_name
    self.name = %w(R2D2 Hal Chappie Sonny).sample
  end

  def choose
    Move[self] = personality.sample
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
    @@scores.each { |player, _| @@scores[player] = 0 }
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

  def game_name
    Move.to_s.gsub(/\w+/) { $&.capitalize }
  end

  def display_welcome_message
    system 'clear'
    puts "Hello, #{human.name} :)"
    puts "Welcome to #{game_name}!"
    puts
    puts "HOW TO WIN: First to score #{Score::WIN} points wins."
    puts
    puts "NOTE: You may type the first 1-2 letters of each choice."
    puts
    continue?
  end

  def display_goodbye_message
    puts "Thanks for playing #{game_name}. Good bye!"
  end

  def display_result
    human_move = Move[human]
    computer_move = Move[computer]

    if human_move > computer_move
      winner = human
    elsif computer_move > human_move
      winner = computer
    end

    Score.increment(winner) unless winner.nil?
    Move.display
    display_winner(winner)
  end

  def display_winner(player)
    puts player.nil? ? "It's a tie!" : "#{player} won!"
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

  def match
    loop do
      system 'clear'
      Score.display
      human.choose
      computer.choose
      display_result

      continue?

      break if Score.someone_won?
    end
  end

  def display_match_result
    system 'clear'
    Move.history
    Score.display
    display_champion
  end

  def play
    display_welcome_message

    loop do
      match
      display_match_result

      break unless play_again?

      Score.reset
    end

    display_goodbye_message
  end
end

RPSGame.new.play
