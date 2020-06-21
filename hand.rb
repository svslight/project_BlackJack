# frozen_string_literal: true

# Добавление сданных карт в массив

class Hand
  VALUES = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'J' => 10,
    'Q' => 10,
    'K' => 10,
    'A' => 1
  }.freeze

  attr_accessor :delt_cards

  def initialize
    @delt_cards = []
  end

  def add_card(card)
    @delt_cards << card
  end

  def total_value
    card_ranks = @delt_cards.map(&:rank)
    result = card_ranks.reduce(0) { |acc, rank| acc + VALUES[rank.to_s] }

    if card_ranks.include?('A') && @delt_cards.first.show
      result += 10 if result + 10 <= 21
    end
    result
  end

  def to_s
    report = ''

    delt_cards.each { |card| report += "#{card}, " if card.show }

    if delt_cards.first.show == false
      first_value = VALUES[@delt_cards.first.rank]
      report + "Total value: #{(total_value - first_value)}"
    else
      report + "Total value: #{total_value}"
    end
  end
end
