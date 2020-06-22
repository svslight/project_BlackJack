# frozen_string_literal: true

# Create card

class Card
  SUITS = %w[♠ ♥ ♣ ♦].freeze
  PICTURES = %i[J Q K A].freeze
  SCORES = { J: 10, Q: 10, K: 10, A: 11 }.freeze

  attr_reader :suit, :rank
  attr_accessor :score

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def price
    @score = (2..10).include?(@rank) ? @rank : SCORES[@rank]
  end

  def face
    "#{rank} #{suit}"
  end
end
