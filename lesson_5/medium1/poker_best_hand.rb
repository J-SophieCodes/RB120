class Card
  include Comparable

  RANK_ORDER = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def rank_order
    RANK_ORDER.index(rank)
  end

  def <=>(other)
    rank_order <=> other.rank_order
  end

  def -(other)
    rank_order - other.rank_order
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if deck.empty?
    deck.pop
  end
  
  private

  attr_accessor :deck

  def reset
    @deck = create_deck
  end

  def create_deck
    RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end.shuffle
  end
end

class PokerHand  
  include Comparable

  RANK_ORDER = [
      'Royal flush',
      'Straight flush',
      'Four of a kind',
      'Full house',
      'Flush',
      'Straight',
      'Three of a kind',
      'Two pair',
      'Pair',
      'High card'
  ].reverse

  def initialize(deck)
    @hand = []
    5.times { hand << deck.draw }
  end

  def print
    puts hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  def <=>(other)
    RANK_ORDER.index(evaluate) <=> RANK_ORDER.index(other.evaluate)
  end

  private

  attr_reader :hand

  def flush?
    hand.map(&:suit).uniq.one?
  end

  # def royal?
    # hand.sort.map(&:rank) == Card::RANK_ORDER.last(5)
  # end

  def royal_flush?
    straight_flush? && hand.min.rank == 10
  end

  def straight?
    return false if hand.any? { |rank| hand.count(rank) > 1 }
    hand.minmax.reduce(&:-).abs == 4
  end

  def straight_flush?
    flush? && straight?
  end

  def n_of_a_kind?(n)
    hand.any? { |rank| hand.count(rank) == n }
  end

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    hand.count { |rank| hand.count(rank) == 2 } == 4
  end

  def pair?
    n_of_a_kind?(2)
  end
end

# Danger danger danger: monkey
# patching for testing purposes.

class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.

hand1 = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
hand1.print
puts hand1.evaluate #== 'Straight flush'
puts

hand2 = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
hand2.print
puts hand2.evaluate #== 'Straight'
puts

puts "Better hand is #{[hand1, hand2].max.evaluate}"
puts

hand3 = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
hand3.print
puts hand3.evaluate #== 'Straight'
puts

hand4 = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
hand4.print
puts hand4.evaluate #== 'Royal flush'
puts

puts "Better hand is #{[hand3, hand4].max.evaluate}"
puts

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(3, 'Diamonds')
# ])
# puts hand.evaluate == 'Four of a kind'

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(5, 'Hearts')
# ])
# puts hand.evaluate == 'Full house'

# hand = PokerHand.new([
#   Card.new(10, 'Hearts'),
#   Card.new('Ace', 'Hearts'),
#   Card.new(2, 'Hearts'),
#   Card.new('King', 'Hearts'),
#   Card.new(3, 'Hearts')
# ])
# puts hand.evaluate == 'Flush'

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(6, 'Diamonds')
# ])
# puts hand.evaluate == 'Three of a kind'

# hand = PokerHand.new([
#   Card.new(9, 'Hearts'),
#   Card.new(9, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(8, 'Spades'),
#   Card.new(5, 'Hearts')
# ])
# puts hand.evaluate == 'Two pair'

# hand = PokerHand.new([
#   Card.new(2, 'Hearts'),
#   Card.new(9, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(9, 'Spades'),
#   Card.new(3, 'Diamonds')
# ])
# puts hand.evaluate == 'Pair'

# hand = PokerHand.new([
#   Card.new(2,      'Hearts'),
#   Card.new('King', 'Clubs'),
#   Card.new(5,      'Diamonds'),
#   Card.new(9,      'Spades'),
#   Card.new(3,      'Diamonds')
# ])
# puts hand.evaluate == 'High card'
