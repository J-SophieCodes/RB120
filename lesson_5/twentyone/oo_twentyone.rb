module Hand
  HAND_MAX = 21

  def show_hand
    puts "#{name}'s hand:"
    puts cards
    puts "Total = #{hand_total}"
    puts
  end

  def hit(new_card)
    cards << new_card
  end

  def busted?
    hand_total > HAND_MAX
  end

  def calculate_total
    self.hand_total = cards.sum(&:value)
    cards.count(&:ace?).times do
      self.hand_total -= 10 if busted?
    end
  end
end

class Participant
  include Hand

  attr_accessor :name, :cards, :hand_total

  def initialize
    set_name
    reset
  end

  def reset
    self.cards = []
    self.hand_total = 0
  end
end

class Player < Participant
  def set_name
    name = nil
    loop do
      puts "What's your name?"
      name = gets.chomp.squeeze.strip
      break unless name.empty?
      puts "Sorry, must enter a value."
    end
    self.name = name
  end

  def stay?
    answer = nil
    loop do
      puts "Hit(h) or stay(s)?"
      answer = gets.downcase
      break if answer.start_with?("h", "s")
      puts "Sorry, invalid input."
    end
    answer.start_with?("s")
  end
end

class Dealer < Participant
  ROBOTS = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']
  DEALING_THRESHOLD = 17

  def set_name
    self.name = ROBOTS.sample
  end

  def show_partial_hand
    puts "#{name}'s hand:"
    puts [Card.new(*Card::HIDDEN), cards.last]
    puts "Known total = #{cards.last.value}"
    puts
  end

  def stay?
    hand_total >= DEALING_THRESHOLD
  end
end

class Deck
  attr_accessor :deck

  def initialize
    reset
  end

  def reset
    self.deck = new_deck
  end

  def new_deck
    Card::SUITS.product(Card::FACES.keys).map do |suit, face|
      Card.new(suit, face)
    end.shuffle
  end

  def deal
    deck.pop
  end
end

class Card
  SUITS = %w(Hearts Diamonds Clubs Spades)

  FACES = %w(2 3 4 5 6 7 8 9 10 J Q K A).zip(
    [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11]
  ).to_h

  HIDDEN = %w(? ?)

  attr_reader :suit, :face, :value

  def initialize(suit, face)
    @suit = suit
    @face = face
    @value = FACES[face]
  end

  def ace?
    face == "A"
  end

  def to_s
    "=> #{face} of #{suit}"
  end
end

class Game
  def initialize
    clear_screen
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    clear_screen
    display_welcome_message
    continue?
    main_game
    display_goodbye_message
  end

  private

  attr_reader :player, :dealer, :deck

  def clear_screen
    system 'clear'
  end

  def display_welcome_message
    puts "Hello, #{player.name} :)"
    puts "Welcome to Twenty-One!"
    puts
    puts "RULES:"
    puts "\t- Numbers 2 through 10 are worth their face value."
    puts "\t- Ace can be worth 1 or 11"
    puts "\t- Jack, Queen and King are each worth 10."
    puts "\t- Try to get as close to 21 as possible without going over."
    puts
  end

  def continue?
    puts "Press enter to continue.."
    gets
  end

  def display_goodbye_message
    puts
    puts "Thanks for playing Twenty-One! Goodbye!"
  end

  def deal_cards
    2.times do
      player.hit(deck.deal)
      dealer.hit(deck.deal)
    end
  end

  def show_initial_cards
    clear_screen
    dealer.show_partial_hand
    player.show_hand
  end

  def show_all_cards
    clear_screen
    player.show_hand
    dealer.show_hand
    sleep(1)
  end

  def take_turn(party)
    loop do
      party.calculate_total
      party == player ? show_initial_cards : show_all_cards
      break if party.busted? || party.stay?
      party.hit(deck.deal)
    end
  end

  def all_players
    [dealer, player]
  end

  def someone_busted?
    all_players.find(&:busted?)
  end

  def tied?
    player.hand_total == dealer.hand_total
  end

  def winner
    all_players.reject(&:busted?).max_by(&:hand_total)
  end

  def show_result
    puts "#{someone_busted?.name} busted!" if someone_busted?
    puts tied? ? "It's a tie!" : "#{winner.name} won!"
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

    answer == "y"
  end

  def reset
    player.reset
    dealer.reset
    deck.reset
  end

  def main_game
    loop do
      deal_cards
      take_turn(player)
      take_turn(dealer) unless player.busted?
      show_result
      break unless play_again?
      reset
    end
  end
end

Game.new.start
