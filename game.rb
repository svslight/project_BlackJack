# frozen_string_literal: true

# Create game

require_relative 'users'
require_relative 'card'
require_relative 'deck'
require_relative 'hand'

class Game
  attr_reader :user, :dealer, :bank, :deck, :decks, :win

  def initialize
    @user = user
    @dealer = dealer
    @bank = 0
    @win = 0
  end

  def create_players(name)
    @user = Player.new(name)
    @user.hand = Hand.new
    @dealer = Dealer.new
    @dealer.hand = Hand.new
  end

  def first_step
    @decks = Deck.new
    deal_cards(@user, 2)
    deal_cards(@dealer, 2)
    bit
  end

  def valid_cards
    @dealer.hand.cards.count == 3
  end

  def valid_cards_user
    @user.hand.cards.count == 3
  end

  def bit
    @user.balance -= 10
    @dealer.balance -= 10
    first_bit = 20
    @bank += first_bit
  end

  def one_card
    deal_cards(@user, 1)
  end

  def dealers_step
    @dealer.hand.count_cards
    if @dealer.hand.cards.count < 3 && @dealer.hand.score <= 17
      deal_cards(@dealer, 1)
    else
      valid_cards
    end
  end

  def deal_cards(player, num_cards)
    @player = player
    @player.hand.cards << decks.deck.sample(num_cards)
    @player.hand.cards.flatten!
    decks.deck.delete_if { |cards| @player.hand.cards.include?(cards) }
  end

  def processing
    if @user.hand.score > 21 && @dealer.hand.score < 22
      @win = @dealer
    elsif  @dealer.hand.score > 21 && @user.hand.score < 22
      @win = @user
    elsif  @user.hand.score > 21 && @dealer.hand.score > 21
      @win = 'busts'
    end
  end

  def great
    if @user.hand.score <= 21 && @user.hand.score > @dealer.hand.score
      @win = @user
    elsif @dealer.hand.score <= 21 && @dealer.hand.score > @user.hand.score
      @win = @dealer
    elsif @user.hand.score == @dealer.hand.score
      @win = 'draw'
    end
  end

  def calculation
    if @win == @user
      @user.balance += @bank
    elsif @win == @dealer
      @dealer.balance += @bank
    elsif @win == 'draw'
      @user.balance += (@bank / 2)
      @dealer.balance += (@bank / 2)
    end
  end

  def end_game
    @user.hand.count_cards
    @dealer.hand.count_cards
    processing
    great
    calculation
  end

  def post_game
    @user.hand = Hand.new
    @dealer.hand = Hand.new
    @bank = 0
  end
end
