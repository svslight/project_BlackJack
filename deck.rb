# frozen_string_literal: true

# Create new card deck

require_relative 'card'

class Deck
  attr_reader :deck, :suits, :ranks

  def initialize
    @deck = []
    @suits = suits
    @ranks = ranks
    create_deck
  end

  def create_deck
    card_generator = [(2..10).to_a, Card::PICTURES].flatten!
    # puts "card_generator = #{card_generator}"
    card_generator.each do |rank|
      Card::SUITS.each do |suit|
        @deck.push(Card.new(suit, rank))
      end
    end
  end
end
