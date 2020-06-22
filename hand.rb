# frozen_string_literal: true

# Players cards on hand

class Hand
  attr_accessor :cards, :score

  def initialize
    @cards = []
    @score = 0
  end

  def count_cards
    report ||= []

    @cards.each { |card| report << card.price }
    report[-1] = 1 if report.last == 11 && report.count(11) == 2
    report[-1] = 1 if report.last == 11 && report[0..-2].sum > 10
    @score = report.sum
  end
end
