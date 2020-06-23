# frozen_string_literal: true

# Run user's text interface

require_relative 'users'
require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'game'

class Interface
  def initialize
    puts 'Добро пожаловать в игру Black Jack!'
    @game = Game.new
  end

  def welcome
    print 'Введите ваше имя: '
    name = gets.chomp
    @game.create_players(name)
  end

  def start_game
    @game.first_step
    puts "\nВам раздали карты: #{@game.user.hand.cards.map(&:face)}"
    puts "У вас: #{@game.user.hand.count_cards}"
    puts 'У дилера на руках 2 карты: [***] [***]'
    main_menu
  end

  def main_menu
    puts "\nВаш ход: 1 - Пропустить ход;  2 - Взять карту;  3 - Открыть карты;"
    choice = gets.chomp
    case choice
    when '1'
      @game.dealers_step ? stand_user : stand_dealer
    when '2'
      @game.valid_cards_user ? hit_max_cards : hit
    when '3'
      open
    end
  end

  def stand_user
    puts "\nДилер взял карту, у него 3 карты: [*] [*] [*]"
    open
  end

  def stand_dealer
    puts "\nДилер пропустил ход..."
    main_menu
  end

  def hit_max_cards
    puts "\nУ вас максимальное количество карт!"
    main_menu
  end

  def hit
    @game.one_card
    puts "\nВы взяли карту, у вас на руках: #{@game.user.hand.cards.map(&:face)}"
    puts "У вас #{@game.user.hand.count_cards} очков"
    @game.dealers_step ? stand_user : stand_dealer
  end

  def open
    @game.end_game
    puts "\nУ #{@game.user.name} на руках: #{@game.user.hand.cards.map(&:face)}"
    puts "Очков: #{@game.user.hand.score}"
    puts "\nУ Дилера на руках: #{@game.dealer.hand.cards.map(&:face)}"
    puts "Очков: #{@game.dealer.hand.score}"
    great_message
  end

  def great_message
    case @game.win
    when @game.dealer
      puts "\nПобедил Дилер, у него: #{@game.dealer.balance}$"
    when @game.user
      puts "\nВы победили, у вас: #{@game.user.balance}$"
    when 'draw'
      puts "\nНичья, все остались при своих деньгах."
      puts "У #{@game.user.name} - #{@game.user.balance}$"
      puts "У #{@game.dealer.name} - #{@game.dealer.balance}$"
    when 'busts'
      puts "\nВы оба обанкротились!!!"
    end
    again
  end

  def again
    @game.post_game
    puts "\n---------- 1: Сыграть еще раз?  2: Выйти ------------"
    choice = gets.chomp
    choice == '1' ? start_game : exit
  end
end

interface = Interface.new
interface.welcome
interface.start_game
