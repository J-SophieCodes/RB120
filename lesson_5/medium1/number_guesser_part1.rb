class ValidNumber
  include Comparable

  RANGE = 1..100

  attr_reader :value

  def <=>(other)
    self.value <=> other.value
  end
end

class RandomNumber < ValidNumber
  def initialize
    @value = rand(RANGE)
  end
end

class Guess < ValidNumber
  MAX_GUESSES = 7

  attr_accessor :count, :value

  def initialize
    @count = 0
  end

  def prompt
    guess = nil
    loop do
      puts "Enter a number between #{RANGE.minmax.join(" and ")}:"
      guess = gets.chomp.to_i
      break if RANGE.cover?(guess)
      puts "Invalid guess."
    end
    self.value = guess
    self.count += 1
    count
  end

  def remaining
    MAX_GUESSES - count
  end

  def none_remaining?
    remaining.zero?
  end
end

class GuessingGame
  def initialize
    reset
  end

  def play
    system 'clear'

    loop do
      show_guesses_remaining
      guess.prompt
      show_result
      break if correct_guess? || no_more_guesses?
    end

    summarize
    continue?
    reset
  end
  
  private

  attr_reader :guess, :number

  def reset
    @number = RandomNumber.new
    @guess = Guess.new
  end

  def show_guesses_remaining
    puts
    puts "You have #{guess.remaining} guess#{"es" if guess.remaining > 1} remaining."
  end

  def no_more_guesses?
    guess.none_remaining?
  end

  def correct_guess?
    guess == number
  end

  def show_result
    case guess <=> number
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