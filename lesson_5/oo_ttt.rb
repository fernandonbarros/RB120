# Tic Tac Toe is a 2-player board game played on a 3X3 grid. Players take turns
# marking a square. The first player to mark 3 squares in a row wins

# Nouns: board, player, square, grid
# Verbs: play, mark

# Board
# Square
# Player
# - mark
# - play
require 'pry'

module Joinable
  def joinor(array, sep = ', ', modifier = 'or')
    if array.size < 3
      array.join(modifier)
    else
      "#{array[0...-1].join(sep)}#{sep}#{modifier} #{array[-1]}"
    end
  end
end

class Board
  WINNING_LINES = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
                   [0, 3, 6], [1, 4, 7], [2, 5, 8],
                   [0, 4, 8], [2, 4, 6]]

  def initialize
    @squares = []
    9.times { |_| @squares.append(Square.new) }
  end

  def clear
    @squares.each { |s| s.marker = Square::INITIAL_MARKER }
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def to_s
    blank_line = '     |     |     '
    line = '-----|-----|-----'
    array = [blank_line, get_row_at(0), blank_line, line,
             blank_line, get_row_at(1), blank_line, line,
             blank_line, get_row_at(2), blank_line]
    array.join("\n")
  end

  def get_row_at(i)
    i *= 3
    "  #{@squares[i + 0]}  |  #{@squares[i + 1]}  |  #{@squares[i + 2]}"
  end

  def unmarked_keys
    (0..8).select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def center_marked?
    @squares[4].marked?
  end

  # return winning marker or return nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def square_at_risk(marker)
    WINNING_LINES.each do |line|
      if line.count { |el| @squares[el].marker == marker } == 2
        key = line.select { |el| @squares[el].unmarked? }.first
        return key if key
      end
    end

    nil
  end

  private

  def three_identical_markers?(squares)
    squares.first.marked? & squares.all? { |s| s.marker == squares.first.marker }
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    !marked?
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker = nil)
    @marker = marker || pick_marker
  end

  def pick_marker
    loop do
      puts "Pick your marker: "
      choice = gets.chomp.chars.first
      return choice if (choice.size == 1) & (choice != " ")
      puts "Invalid marker, marker must not be empty nor a space!"
    end
  end
end

class TTTGame
  COMPUTER_MARKER = "O"

  include Joinable

  def play
    clear
    display_welcome_message
    main_game
    display_final_score
    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer, :current_marker, :score

  def initialize
    clear
    @board = Board.new
    @human = Player.new
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = @human.marker
    @score = { @computer.marker => 0, @human.marker => 0 }
  end

  def main_game
    loop do
      display_board
      player_move
      display_result
      update_score
      break if max_score?
      reset
      display_score
      display_play_again_message
    end
  end

  def max_score?
    (score[COMPUTER_MARKER] >= 5) | (score[HUMAN_MARKER] >= 5)
  end

  def update_score
    winner = board.winning_marker
    return unless winner
    @score[winner] += 1
  end

  def display_score
    puts "Current score: Player - #{@score[HUMAN_MARKER]}; " \
         "Computer - #{@score[COMPUTER_MARKER]}"
  end

  def display_final_score
    puts "Final score: Player - #{@score[HUMAN_MARKER]}; " \
         "Computer - #{@score[COMPUTER_MARKER]}"
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
    end
  end

  def clear
    system 'clear'
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Goodbye. Thank you for playing Tic Tac Toe!"
  end

  def display_board
    puts "You're a #{human.marker}. Computer is #{computer.marker}."
    puts board
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when HUMAN_MARKER
      puts "You won!"
    when COMPUTER_MARKER
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def display_play_again_message
    puts "Let's play again!"
  end

  def human_moves
    puts "Choose a square(#{joinor(board.unmarked_keys)}): "
    key = nil
    loop do
      key = gets.chomp.to_i
      break if board.unmarked_keys.include?(key)
      puts "Sorry, that's is no a valid choice."
    end

    board[key] = human.marker
  end

  def computer_moves
    # Pick center
    key = 4 unless board.center_marked?

    # Offense
    key ||= board.square_at_risk(computer.marker)

    # Defense
    key ||= board.square_at_risk(human.marker)

    # Random
    key ||= board.unmarked_keys.sample

    board[key] = computer.marker
  end

  def human_turn?
    current_marker == human.marker
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      clear_screen_and_display_board
      @current_marker = human.marker
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if 'yn'.include?(answer)
      puts "Invalid selection. Try again."
    end
    answer == 'y'
  end

  def reset
    board.clear
    clear
    @current_marker = FIRST_TO_MOVE
  end
end

game = TTTGame.new
game.play
