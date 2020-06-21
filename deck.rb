# frozen_string_literal: true

require_relative 'card'

class Deck
  SUITS = %w[Hearts Spades Clubs Diamonds].freeze
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_reader :deck, :suits, :ranks

  def initialize(suits, ranks)
    @deck = []
    @suits = suits
    @ranks = ranks
    create_deck
  end

  def shuffle
    @deck.shuffle!
  end

  def deal_card
    @deck.pop
  end

  def create_deck
    suits.each do |suit|
      ranks.each do |rank|
        @deck.push(Card.new(suit, rank))
      end
    end
  end
end
