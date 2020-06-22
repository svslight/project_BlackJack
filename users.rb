# frozen_string_literal: true

# Create player with start balance

class Player
  attr_reader :name
  attr_accessor :balance, :hand

  def initialize(name)
    @name = name
    @balance = 100
    @hand = 0
  end
end

class Dealer < Player
  def initialize(name = 'Dealer')
    super
  end
end
