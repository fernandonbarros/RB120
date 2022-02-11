class Player
  def initialize
    # maybe a "name"? what about a "move"?
  end

  def choose
    
  end
end

class Move
  def initialize
    # we need somthing to keep track of choice
    # a move can be paper, rock or scissors
  end
end

class Rule
  def initialize
    # not sure what the state of a rule object should be
  end
end

# not sure where compare goes
def compare(move1, move2)
end

class RPSGame
  attr_accessor :humar, :computer
  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def play
    display_welcome_message
    # human_choose_move
    # computer_choose_move
    # display_winner
    display_goodbye_message
  end
end

RPSGame.new.play