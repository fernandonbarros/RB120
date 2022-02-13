# frozen_string_literal: true

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end

  def to_s
    @name
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?

      puts 'Sorry, must enter a value.'
    end
    self.name = n
  end

  def choose
    choice = nil

    loop do
      puts 'Please choose rock, paper, or scissors:'
      choice = gets.chomp
      break if Move::VALUES.include? choice

      puts 'Sorry, invalid choice.'
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w[R2D2 Chappie PC].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = %w[rock paper scissors].freeze

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other)
    (rock? && other.scissors?) ||
      (paper? && other.rock?) ||
      (scissors? && other.paper?)
  end
end

class RPSGame
  attr_accessor :human, :computer, :score

  def initialize
    @human = Human.new
    @computer = Computer.new
    @score = {@human => 0, @computer => 0}
  end

  def display_welcome_message
    puts 'Welcome to Rock, Paper, Scissors!'
  end

  def display_goodbye_message
    puts 'Thanks for playing Rock, Paper, Scissors. Good bye!'
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      add_score(human)
      puts "#{human.name} won!"
    elsif computer.move > human.move
      add_score(computer)
      puts "#{computer.name} won!"
    else
      puts "It's a tie"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp
      break if %w[y n].include? answer.downcase

      puts 'Sorry, must be y or n.'
    end

    return true if answer == 'y'

    false
  end

  def add_score(player)
    score[player] += 1
  end

  def display_score
    puts "Score: #{human} (#{score[human]}) - #{computer} (#{score[computer]})"
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      display_score
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
