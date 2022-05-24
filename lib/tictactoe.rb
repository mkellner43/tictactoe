# frozen_string_literal: true
require_relative 'player'
require_relative 'message'

class TicTacToe
  include Messages

  attr_reader :player1, :player2, :board

  WIN = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [0, 4, 8], [1, 4, 7],
    [2, 5, 8], [2, 4, 6]
  ].freeze

  def initialize
    @player1 = nil
    @player2 = nil
    @winner = nil
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @selected = [false, false, false, false, false, false, false, false, false]
  end

  def start
    instructions
    game_set_up
    display
    turn_tracker
    winner_or_tie
    puts display_message('game_over')
  end

  def game_set_up
    puts display_message('player1_name')
    @player1 = create_player(1)
    puts display_message('player2_name')
    @player2 = create_player(2, @player1.player_symbol)
  end 

  def create_player(player_number, dup=nil)
    puts display_message('player_name')
    name = gets.chomp
    symbol = symbol_checker(player_number, dup, name)
    Player.new(name, symbol)
  end

  def symbol_checker(player_number, dup, name)
    puts display_message('player_symbol', name)
    input = gets.chomp
    return input if input.length == 1 && player_number == 1 
    return input if input.length == 1 && input != dup
    puts display_message('invalid_symbol')
    symbol_checker(player_number, dup, name)
  end 

  def instructions
    puts <<-HEREDOC

    Lets play a simple game of Tic Tak Toe in the console.
    Players will choose a symbol and then take turns selecting
    where they would like to place their symbol on the board!

    When it's your turn choose your place on the board by typing in
    the number displayed on the board and that number will be replaced
    with your symbol! Simple as that!
    HEREDOC
  end

  def display
    puts <<-HEREDOC

            #{@board[0]} | #{@board[1]} | #{@board[2]}
           ---+---+---
            #{@board[3]} | #{@board[4]} | #{@board[5]}
           ---+---+---
            #{@board[6]} | #{@board[7]} | #{@board[8]}

    HEREDOC
  end 

  def turn_tracker
    turn(@player1)
    return if game_over?
    turn(@player2)
    turn_tracker until game_over?
  end 

  def turn(player)
    puts display_message('player_turn', player.player_name)
    selects = gets.chomp.to_i
    valid_position?(selects) ? turn_end(player, selects) : invalid(player)
  end 

  def valid_position?(selects)
    (1..9).include?(selects) && @selected[selects - 1] == false ? true : false 
  end

  def turn_end(player, selects)
    @board[selects - 1] = player.player_symbol
    @selected[selects - 1] = true
    @current_player = player.player_name  
    display
  end 

  def invalid(player)
    puts display_message('invalid_move', player.player_name)
    turn(player)
  end

  def win? 
    WIN.any? do |combo|
      [@board[combo[0]], @board[combo[1]], @board[combo[2]]].uniq.length == 1
    end
  end   

  def board_full?
    full = @selected.all? { |values| values == true ? true : false }
  end 

  def game_over?
    win? == true || board_full? == true ? true : false 
  end 

  def winner_or_tie
    if win? == true
      @winner = @current_player
      puts display_message('winner', @winner)
    else  
      puts display_message('tie')
    end 
  end 
end
