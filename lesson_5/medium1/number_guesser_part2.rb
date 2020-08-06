class ValidNumber
  include Comparable

  attr_reader :value

  def <=>(other)
    self.value <=> other.value
  end
end

class RandomNumber < ValidNumber
  def initialize(range)
    @value = rand(range)
  end
end

class Guess < ValidNumber
  def initialize(range)
    @range = range
    @max_guesses = set_max_guesses
    @count = 0
  end

  def prompt
    guess = nil
    loop do
      puts "Enter a number between #{range.first} and #{range.last}:"
      guess = gets.chomp.to_i
      break if range.cover?(guess)
      puts "Invalid guess."
    end
    @value = guess
    self.count += 1
    count
  end

  def remaining
    max_guesses - count
  end

  def none_remaining?
    remaining.zero?
  end

  private

  attr_reader :range, :max_guesses
  attr_accessor :count

  def set_max_guesses
    Math.log2(range.size).to_i + 1
  end
end

class GuessingGame
  def initialize
    system 'clear'
    @range = set_range
    reset
  end

  def play
    system 'clear'
    reset
    
    loop do
      show_guesses_remaining
      guess.prompt
      show_result
      break if correct_guess? || no_more_guesses?
    end

    summarize
    continue?
  end
  
  private

  attr_reader :guess, :secret_number, :range

  def reset
    @secret_number = RandomNumber.new(range)
    @guess = Guess.new(range)
  end

  def set_range
    min, max = nil, nil

    puts "Please enter the lower limit of the guessing range:"
    min = gets.chomp.to_i

    loop do
      puts "Please enter the upper limit of the guessing range:"
      max = gets.chomp.to_i
      break if max > min
      puts "The upper limit must be greater than the lower limit #{min}."
    end

    (min..max)
  end

  def show_guesses_remaining
    puts
    puts "You have #{guess.remaining} guess#{"es" if guess.remaining > 1} remaining."
  end

  def no_more_guesses?
    guess.none_remaining?
  end

  def correct_guess?
    guess == secret_number
  end

  def show_result
    case guess <=> secret_number
    when 1 then puts "Your guess is too high."
    when -1 then puts "Your guess is too low."
    when 0 then puts "That's the number!"
    end
  end

  def summarize
    puts correct_guess? ? "\nYou won!" : "\nYou have no more guesses. You lost!"
  end

  def continue?
    puts
    puts "Press enter to continue.."
    gets
  end
end

game = GuessingGame.new
game.play
game.play
