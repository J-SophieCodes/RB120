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

  def self.flush?(cards)
    PokerHand.new(cards).flush?
  end

  # protected

  attr_reader :hand

  def flush?
    hand.map(&:suit).uniq.one?
  end

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
  alias_method :draw, :pop  ## still need this
end

p PokerHand.flush?([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
