# frozen_string_literal: true

# Добавление класса для карт

class Card
  SUITS = %w[Hearts Spades Clubs Diamonds].freeze
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_accessor :suit, :rank, :show

  def initialize(suit, rank)
    @show = true

    if SUITS.include?(suit) && RANKS.include?(rank)
      @suit = suit
      @rank = rank
    else
      @suit = 'UNKNOWN'
      @rank = 'UNKNOWN'
    end
  end

  def to_s
    if show
      "#{rank} #{suit}"
    else
      'Карту не видим'
    end
  end
end
