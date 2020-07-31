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
  def initialize
    # maybe a "name"? what about a "move"?
  end

  def choose

  end
end

class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)

end

# Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize 
    @human = Player.new
    @computer = Player.new
  end

  def play # objects required to facilitate the game
    display_welcome_message
    human_choose_move
    computer_choose_move
    display_winner
    display_goodbye_message
  end
end

RPSGame.new.play