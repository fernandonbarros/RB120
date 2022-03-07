require "pry"

module Joinable
  def joinor(array, sep = ', ', modifier = 'or')
    if array.size < 3
      modifier = " #{modifier} "
      array.join(modifier)
    else
      "#{array[0...-1].join(sep)}#{sep}#{modifier} #{array[-1]}"
    end
  end
end

class Participant
  include Joinable

  attr_accessor :hand, :name

  def initialize(name)
    @hand = []
    @name = name
  end

  def show_cards
    puts "#{name} has: #{joinor(hand, ', ', 'and')} (#{total})"
  end

  def add_card(card)
    hand.append(card)
  end

  def total
    hand.reduce(0) do |sum, card|
      value = Deck.card_value(card)
      if (card == "Ace") & ((sum + value) > 21)
        sum + 1
      else
        sum + value
      end
    end
  end

  def busted?
    total > 21
  end
end

class Player < Participant
  def initialize
    super('Player')
  end

  def hit?
    choice = nil
    loop do
      print "Hit (h) or stay (s)? "
      choice = gets.chomp.downcase
      break if "hs".include?(choice)
      puts "Invalid choice!"
    end
    choice == 'h'
  end
end

class Dealer < Participant
  def initialize
    super('Dealer')
  end

  def show_first_card
    puts "#{name} has: #{hand.first} and unknown card"
  end

  def stay?
    total >= 17
  end
end

class Deck
  ALL_CARDS = %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King)

  def initialize
    @cards = (ALL_CARDS * 4).shuffle
  end

  def draw
    @cards.pop
  end

  def self.card_value(card)
    case card
    when 'Ace'
      11
    when 'Jack', 'Queen', 'King'
      10
    else
      card.to_i
    end
  end
end

class Game
  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    clear
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn unless player.busted?
    show_result
  end

  def deal_cards
    player.add_card(deck.draw)
    player.add_card(deck.draw)
    dealer.add_card(deck.draw)
    dealer.add_card(deck.draw)
  end

  def show_initial_cards
    dealer.show_first_card
    player.show_cards
  end

  def player_turn
    until player.busted?
      break unless player.hit?
      clear
      player.add_card(deck.draw)
      dealer.show_first_card
      player.show_cards
    end
  end

  def dealer_turn
    clear
    until dealer.busted? | dealer.stay?
      dealer.add_card(deck.draw)
    end
    dealer.show_cards
    player.show_cards
  end

  def clear
    system 'clear'
  end

  def show_result
    case result
    when :player_busted
      puts "You busted! Dealer wins!"
    when :dealer_busted
      puts "Dealer busted! You win!"
    when :player
      puts "You win!"
    when :dealer
      puts "Dealer wins!"
    when :tie
      puts "It's a tie!"
    end
  end

  def result
    return :player_busted if player.busted?
    return :dealer_busted if dealer.busted?
    return :dealer if dealer.total > player.total
    return :player if player.total > dealer.total
    :tie
  end
end

Game.new.start
