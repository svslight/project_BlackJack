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
    if choice == '1'
      stand
    elsif choice == '2'
      hit
    elsif choice == '3'
      open
    end
  end

  def stand
    @game.dealers_step
    if @game.dealer.hand.cards.count == 3
      puts "\nДилер взял карту, у него 3 карты: [*] [*] [*]"
      @game.valid_cards ? open : main_menu
    else
      puts "\nДилер пропустил ход..."
      main_menu
    end
  end

  def hit
    if @game.user.hand.cards.count == 3
      puts "\nУ вас максимальное количество карт!"
      main_menu
    else
      @game.one_card
      puts "\nВы взяли карту, у вас на руках: #{@game.user.hand.cards.map(&:face)}"
      puts "У вас #{@game.user.hand.count_cards} очков"
      @game.dealers_step
      stand
    end
  end

  def open
    @game.end_game
    puts "\nУ #{@game.user.name} на руках: #{@game.user.hand.cards.map(&:face)}"
    puts "Очков: #{@game.user.hand.score}"
    puts "\nУ Дилера на руках: #{@game.dealer.hand.cards.map(&:face)}"
    puts "Очков: #{@game.dealer.hand.score}"
    @game.processing ? processing_message : great_message
  end

  def great_message
    if @game.win == @game.dealer
      puts "\nПобедил Дилер, у него: #{@game.dealer.balance}$"
    elsif @game.win == @game.user
      puts "\nВы победили, у вас: #{@game.user.balance}$"
    elsif @game.win == 'draw'
      puts "\nНичья, все остались при своих деньгах."
      puts "У #{@game.user.name} - #{@game.user.balance}$"
      puts "У #{@game.dealer.name} - #{@game.dealer.balance}$"
    end
    again
  end

  def processing_message
    if @game.win == @game.dealer
      puts "\nПобедил Дилер, теперь у него: #{@game.dealer.balance}$"
    elsif @game.win == @game.user
      puts "\nВы победили, теперь у вас: #{@game.user.balance}$"
    elsif @game.win == 'busts'
      puts "\nВы оба обанкротились!!!"
    end
    again
  end

  def again
    @game.post_game
    puts "\n1: Сыграть еще раз?  2: Выйти"
    choice = gets.chomp
    choice == '1' ? start_game : exit
  end
end

interface = Interface.new
interface.welcome
interface.start_game
